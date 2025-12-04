#!/bin/bash

# CMUS playlist manager script - FIXED for spaces in filenames
# Usage: create-playlist.sh name ~/music/*.mp3

show_usage() {
    echo "Usage: $0 playlist_name file1.mp3 [file2.mp3 ...]"
    echo "       $0 playlist_name /path/to/music/*.mp3"
    echo ""
    echo "Examples:"
    echo "  $0 my_playlist ~/Music/*.mp3"
    echo "  $0 rock_songs \"song with spaces.mp3\" \"another song.mp3\""
    exit 1
}

# Check if enough arguments are provided
if [ $# -lt 2 ]; then
    echo "Error: Please provide a playlist name and at least one music file"
    show_usage
fi

PLAYLIST_NAME="$1"
shift

# Set playlist directory
PLAYLIST_DIR="$HOME/.config/cmus/playlists"
PLAYLIST_FILE="$PLAYLIST_DIR/$PLAYLIST_NAME"

# Create playlist directory if it doesn't exist
mkdir -p "$PLAYLIST_DIR"

# Check if files were provided
if [ $# -eq 0 ]; then
    echo "Error: No files provided"
    show_usage
fi

# Use find to handle files with spaces and special characters properly
process_files() {
    local count=0
    declare -a files_array
    
    # Process each argument - handle both files and directories
    for arg in "$@"; do
        if [ -f "$arg" ]; then
            # It's a file
            get_absolute_path "$arg"
            ((count++))
        elif [ -d "$arg" ]; then
            # It's a directory - find all music files recursively
            while IFS= read -r -d '' file; do
                get_absolute_path "$file"
                ((count++))
            done < <(find "$arg" -type f \( -name "*.mp3" -o -name "*.flac" -o -name "*.ogg" -o -name "*.m4a" -o -name "*.wav" \) -print0 2>/dev/null)
        fi
    done
    echo "Processed $count files" >&2
}

# Function to get absolute path of a file
get_absolute_path() {
    local file="$1"
    if [ -f "$file" ]; then
        if command -v realpath >/dev/null 2>&1; then
            realpath "$file"
        else
            # Fallback method
            case "$file" in
                /*) echo "$file" ;;
                *) echo "$(cd "$(dirname "$file")" && pwd)/$(basename "$file")" ;;
            esac
        fi
    fi
}

# Function to sort files naturally
sort_files() {
    sort -V
}

echo "Processing files..."

# Collect all files, handling spaces and special characters
declare -a all_files
while IFS= read -r -d '' file; do
    all_files+=("$file")
done < <(
    for arg in "$@"; do
        if [ -f "$arg" ]; then
            # Single file
            get_absolute_path "$arg"
            printf '\0'
        elif [ -d "$arg" ]; then
            # Directory - find music files
            find "$arg" -type f \( -name "*.mp3" -o -name "*.flac" -o -name "*.ogg" -o -name "*.m4a" -o -name "*.wav" \) -print0 2>/dev/null
        fi
    done
)

# Check if we got any files
if [ ${#all_files[@]} -eq 0 ]; then
    echo "Error: No valid music files found"
    exit 1
fi

echo "Found ${#all_files[@]} files"

# Sort files naturally
sorted_files=()
while IFS= read -r -d '' file; do
    sorted_files+=("$file")
done < <(printf '%s\0' "${all_files[@]}" | sort -V -z)

# Check if playlist already exists
if [ -f "$PLAYLIST_FILE" ]; then
    echo "Playlist '$PLAYLIST_NAME' already exists."
    read -p "Do you want to (a)ppend or (o)verwrite? [a/o]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Oo]$ ]]; then
        # Overwrite - use printf to handle special characters
        printf '%s\n' "${sorted_files[@]}" > "$PLAYLIST_FILE"
        echo "Overwritten playlist '$PLAYLIST_NAME' with ${#sorted_files[@]} songs"
    else
        # Append - read existing content
        declare -a existing_playlist
        if [ -s "$PLAYLIST_FILE" ]; then
            while IFS= read -r line || [ -n "$line" ]; do
                existing_playlist+=("$line")
            done < "$PLAYLIST_FILE"
        fi
        
        # Combine and remove duplicates
        combined_files=("${existing_playlist[@]}" "${sorted_files[@]}")
        unique_sorted_files=()
        while IFS= read -r -d '' file; do
            unique_sorted_files+=("$file")
        done < <(printf '%s\0' "${combined_files[@]}" | sort -V -z | uniq -z)
        
        printf '%s\n' "${unique_sorted_files[@]}" > "$PLAYLIST_FILE"
        new_count=$(( ${#unique_sorted_files[@]} - ${#existing_playlist[@]} ))
        echo "Appended $new_count new songs to playlist '$PLAYLIST_NAME' (now has ${#unique_sorted_files[@]} songs)"
    fi
else
    # Create new playlist
    printf '%s\n' "${sorted_files[@]}" > "$PLAYLIST_FILE"
    echo "Created playlist '$PLAYLIST_NAME' with ${#sorted_files[@]} songs"
fi

# Show first few entries as confirmation
echo ""
echo "First 5 entries in playlist:"
head -n 5 "$PLAYLIST_FILE"
if [ ${#sorted_files[@]} -gt 5 ]; then
    echo "..."
fi

# Show playlist location
echo ""
echo "Playlist saved to: $PLAYLIST_FILE"
