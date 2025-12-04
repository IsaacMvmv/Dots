#! /bin/bash

# Parse cmus arguments
parse_arguments() {
    local status=""
    local file=""
    local album=""
    local duration=""
    local artist=""
    local title=""

    args=("$@")
    for ((i=0; i<${#args[@]}; i++)); do
        case "${args[i]}" in
            status)
                status="${args[i+1]}"
                ((i++))
                ;;
            file)
                file="${args[i+1]}"
                ((i++))
                ;;
            album)
                album="${args[i+1]}"
                ((i++))
                ;;
            duration)
                duration="${args[i+1]}"
                ((i++))
                ;;
            artist)
                artist="${args[i+1]}"
                ((i++))
                ;;
            title)
                title="${args[i+1]}"
                ((i++))
                ;;
        esac
    done

    echo "$status"
    echo "$file"
    echo "$album"
    echo "$duration"
    echo "$artist"
    echo "$title"
}

# Extract just the filename without path and extension
get_filename() {
    local file_path="$1"
    if [[ -z "$file_path" ]]; then
        echo "Unknown"
        return
    fi
    # Remove file extension and path, keep only filename
    filename="${file_path##*/}"
    filename="${filename%.*}"
    echo "$filename"
}

# Extract cover art using ffmpeg and crop to circle
extract_cover() {
    local music_file="$1"
    local cover_path="/tmp/cmus_cover_$$.jpg"
    local circle_cover_path="/tmp/cmus_cover_circle_$$.jpg"

    if command -v ffmpeg &> /dev/null && [[ -f "$music_file" ]]; then
        # Extract cover art using ffmpeg
        ffmpeg -i "$music_file" -an -vcodec copy "$cover_path" -y 2>/dev/null

        # Validate the extracted image
        if [[ -f "$cover_path" ]] && [[ -s "$cover_path" ]]; then
            # Check if file is actually an image
            if file -b "$cover_path" 2>/dev/null | grep -q "image"; then
                # Get image dimensions
                if command -v identify &> /dev/null; then
                    # Using ImageMagick's identify to get dimensions
                    dimensions=$(identify -format "%wx%h" "$cover_path" 2>/dev/null)
                    if [[ $? -eq 0 ]]; then
                        width=$(echo "$dimensions" | cut -d'x' -f1)
                        height=$(echo "$dimensions" | cut -d'x' -f2)
                        
                        # Choose the SMALLER dimension to ensure circle fits without stripes
                        if [[ $width -lt $height ]]; then
                            circle_size=$width
                        else
                            circle_size=$height
                        fi
                        
                        echo "Image: ${width}x${height}, Using circle size: $circle_size" >&2
                        
                        # Create circular image using mask approach
                        convert "$cover_path" \
                            -resize "${circle_size}x${circle_size}^" \
                            -gravity center \
                            -extent "${circle_size}x${circle_size}" \
                            \( -size ${circle_size}x${circle_size} xc:none -fill white \
                               -draw "circle $((circle_size/2)),$((circle_size/2)) $((circle_size/2)),$((circle_size))" \) \
                            -compose copy_opacity -composite \
                            "$circle_cover_path" 2>/dev/null
                        
                        if [[ -f "$circle_cover_path" ]] && [[ -s "$circle_cover_path" ]]; then
                            rm -f "$cover_path" 2>/dev/null
                            echo "$circle_cover_path"
                            return 0
                        fi
                    fi
                fi
                # Fallback: if ImageMagick not available or conversion failed, use original
                echo "$cover_path"
                return 0
            fi
        fi
        rm -f "$cover_path" "$circle_cover_path" 2>/dev/null
    fi
    echo ""
}

# Parse arguments
IFS=$'\n' read -r -d '' status file album duration artist title <<< "$(parse_arguments "$@")"

# Only show for playing status
if [[ "$status" != "playing" ]]; then
    exit 0
fi

# Get just the filename without path
filename=$(get_filename "$file")

# Build notification body with metadata
notify_body=""
if [[ -n "$artist" && "$artist" != " " ]]; then
    notify_body+="👤 $artist"
fi
if [[ -n "$album" && "$album" != " " ]]; then
    if [[ -n "$notify_body" ]]; then
        notify_body+="\n💿 $album"
    else
        notify_body+="💿 $album"
    fi
fi
if [[ -n "$duration" ]]; then
    minutes=$((duration / 60))
    seconds=$((duration % 60))
    formatted_duration="${minutes}:$(printf "%02d" $seconds)"
    if [[ -n "$notify_body" ]]; then
        notify_body+="\n⏱ $formatted_duration"
    else
        notify_body+="⏱ $formatted_duration"
    fi
fi

# Extract cover art
cover_art=$(extract_cover "$file")

# Send notification using notify-send
if [[ -n "$cover_art" && -f "$cover_art" ]]; then
    notify-send -t 3000 -i "$cover_art" "$filename" "$notify_body"
    # Ensure cover art is removed after notification
    (sleep 30; rm -f "$cover_art") &
else
    notify-send "$filename" "$notify_body"
fi
