#if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#  exec startx
#fi

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history



if [ -f "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ];then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/powerlevel10k/powerlevel10k.zsh-theme
#source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
source $HOME/.p10k.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
#source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-sudo/sudo.plugin.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
PATH=/home/$USER/.local/bin:/usr/lib/paxtest:$PATH
export _JAVA_AWT_WM_NONREPARENTING=1
export EDITOR="/usr/bin/nano"


/usr/bin/cat ~/.cache/wal/sequences
#setxkbmap es
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

alias fan='sudo amdgpu-fancontrol'
alias amdvlk='AMD_VULKAN_ICD=AMDVLK'
alias radv='AMD_VULKAN_ICD=RADV'
alias settarget='echo $1 > $HOME/.config/bin/target'
alias wifi="sudo lnxrouter -o wlan1 --ap wlan0 BU -p zzzzzzzz --no-virt --qr -g 0"
alias eth="sudo lnxrouter -o wlan0 -i eth0 -g 2"
alias cap="ffplay -input_format mjpeg /dev/video2 -loglevel error -fflags low_delay -fflags nobuffer"
alias wan="curl ifconfig.me > ~/.config/bin/target"
alias wd="hdparm -tT $1"
alias tarear="tar -cfz"
alias hdmion='xrandr --output HDMI-A-0 --auto --right-of eDP'
alias hdmioff='xrandr --output HDMI-A-0 --off'
alias reload='source ~/.zshrc'
alias sketchup='wine .wine/drive_c/Program\ Files/SketchUp/SketchUp\ 2019/SketchUp.exe'
alias xlaunch='wine .wine/drive_c/Program\ Files/VcXsrv/xlaunch.exe'
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='/usr/bin/bat'
alias counter='wine .wine/drive_c/Program\ Files\ \(x86\)/Counter-Strike\ 1.6/hl.exe "-nomaster -game cstrike"'
alias catn='/usr/bin/cat'
alias winrar='wine "/home/$USER/.wine/drive_c/Program Files/WinRAR/WinRAR.exe"'
alias mblock='LD_LIBRARY_PATH=/opt/pango-legacy/usr/lib:$LD_LIBRARY_PATH mblock'
alias autoremove='paru -Rs $(paru -Qqtd)'
alias parrot='bash /home/$USER/.config/bspwm/scripts/parrot.sh'
alias neofetch='/usr/bin/neofetch --ascii /home/$USER/shrek'
alias public='dig +short myip.opendns.com @resolver1.opendns.com'
alias gta='WINEPREFIX="/home/$USER/.wine" /usr/bin/wine C:\\windows\\command\\start.exe /Unix /home/$USER/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Rockstar\ Games/GTA\ San\ Andreas/Jugar\ a\ GTA\ San\ Andreas.lnk'
alias f3="sudo python3 ~/.config/bspwm/scripts/ofc/main.py -m 3"
alias f1="sudo python3 ~/.config/bspwm/scripts/ofc/main.py -m 0"
alias sdlx11="SDL_VIDEODRIVER=x11"
alias killwaydroid=" sudo kill -9 $(ps aux | grep waydroid | grep container | awk '{print $2}')"
alias adios="echo adios | sudo tee /sys/block/nvme0n1/queue/scheduler"
alias avidemux_qt5="XDG_CURRENT_DESKTOP=GNOME QT_QPA_PLATFORM=xcb /bin/avidemux3_qt5"
alias cpuP="$HOME/.config/bin/cpu-performance.sh"
alias cpup="$HOME/.config/bin/cpu-normal.sh"
alias odin="sudo odin4 -a AP* -b BL* -c CP* -s CSC*"
alias dontorrent="curl -sL https://t.me/s/DonTorrent | grep E29C85 | grep -i 'href=\"[^\"]*dontorrent' | sed 's/.*href=\"//; s/\".*//'"
alias 10wget="aria2c -x 10 -s 10"
alias xserver="Xephyr -fullscreen :1"
alias latexocr="python -m latex_ocr_server start --port 50051 -d --cache_dir /home/isaac/.obsidian/plugins/latex-ocr/model_cache"
alias x11="XDG_CURRENT_DESKTOP=GNOME QT_QPA_PLATFORM=xcb"
alias cmus_playlists="$HOME/.config/bin/cmus_playlists.sh"
alias randommac="$HOME/.config/bin/randommac.sh"
alias gplot="$HOME/.config/bin/gplot"


function cloudflare(){
echo "nameserver 1.1.1.1
nameserver 1.1.0.0" > /tmp/resolv.conf
chmod 644 /tmp/resolv.conf
sudo mv /tmp/resolv.conf /etc/resolv.conf
}

function videopaper(){
	mpvpaper -vs ALL -o "loop --fs --keepaspect=no" "$@"
}

function videopaper2(){
    mpvpaper -v -o "loop no-audio --input-ipc-server=/tmp/mpvsocket --fs --panscan=1.0 --keepaspect=no --scale=ewa_lanczossharp" $(hyprctl monitors | grep "(ID 0)" | awk '{print $2}') "$@"
}

function mic(){
	# mic.sh - Virtual Mic with Proper Input Detection

	# 1. Cleanup previous modules
	pactl unload-module module-null-sink 2>/dev/null
	pactl unload-module module-loopback 2>/dev/null

	# 2. Create virtual microphone components
	pactl load-module module-null-sink \
	  sink_name=VirtualMic \
	  sink_properties="device.description=Virtual-Mic-Output" \
	  rate=48000 \
	  channels=2 \
	  channel_map=front-left,front-right \
	  object.linger=1

	pactl load-module module-remap-source \
	  source_name=VirtualMic \
	  source_properties="device.description=Virtual-Mic-Input" \
	  master=VirtualMic.monitor \
	  channels=2 \
	  rate=48000

	# 3. Find physical microphone (updated detection)
	PHYSICAL_MIC=$(pactl get-default-source)

	# Verify we found a microphone
	[ -z "$PHYSICAL_MIC" ] && { echo "Error: No physical microphone found"; exit 1; }

	# 4. Create loopback from physical MICROPHONE (not headphones)
	pactl load-module module-loopback \
	  source="$PHYSICAL_MIC" \
	  sink=VirtualMic \
	  rate=48000 \
	  channels=2
}

function mic2() {
	# Esta función hace un mic cuyo input va redirigido al sink principal a lo voicemod
    # Unload existing modules
    pactl unload-module module-null-sink 2> /dev/null
    pactl unload-module module-loopback 2> /dev/null
    
    # Create virtual devices
    pactl load-module module-null-sink sink_name=VirtualMic sink_properties="device.description=Virtual-Mic-Output" rate=48000 channels=2 channel_map=front-left,front-right object.linger=1
    pactl load-module module-remap-source source_name=VirtualMic source_properties="device.description=Virtual-Mic-Input" master=VirtualMic.monitor channels=2 rate=48000
    
    # Get physical devices
    PHYSICAL_MIC=$(pactl get-default-source)
    DEFAULT_SINK=$(pactl get-default-sink)  # Get main output device
    
    [ -z "$PHYSICAL_MIC" ] && {
        echo "Error: No physical microphone found"
        exit 1
    }
    
    [ -z "$DEFAULT_SINK" ] && {
        echo "Error: No default output sink found"
        exit 1
    }

    # New: Monitor virtual output through speakers
    pactl load-module module-loopback source=VirtualMic.monitor sink="$DEFAULT_SINK" rate=48000 channels=2
}

function mic_clean() {
    # Remove virtual devices using PipeWire's native tools
    VIRTUAL_SINK_ID=$(pw-cli list-objects | grep -A20 "node.name = \"VirtualMic\"" | grep 'object.id' | awk '{print $NF}' | head -1)
    VIRTUAL_SOURCE_ID=$(pw-cli list-objects | grep -A20 "node.name = \"VirtualMic.monitor\"" | grep 'object.id' | awk '{print $NF}' | head -1)
    
    [ -n "$VIRTUAL_SINK_ID" ] && pw-cli destroy "$VIRTUAL_SINK_ID"
    [ -n "$VIRTUAL_SOURCE_ID" ] && pw-cli destroy "$VIRTUAL_SOURCE_ID"
    
    # Additional cleanup for loopback modules
    LOOPBACK_MODULES=$(pactl list modules short | grep "module-loopback.*sink=VirtualMic" | awk '{print $1}')
    for mod in $LOOPBACK_MODULES; do
        pactl unload-module "$mod" 2>/dev/null
    done
    
    # Verify cleanup
    if ! pw-cli list-objects | grep -q "VirtualMic"; then
        echo "Virtual devices removed successfully"
    else
        echo "Warning: Some components remain - try full service restart:"
        echo "systemctl --user restart pipewire pipewire-pulse"
    fi
}

function covermp3(){
	for file in *.mp3; do
	  ffmpeg -i "$file" -i "cover.jpg" \
	    -map 0 -map 1 -c copy -disposition:v:0 attached_pic \
	    -id3v2_version 3 -metadata:s:v title="Album Cover" \
	    -metadata:s:v comment="Cover (Front)" -y "${file%.mp3}_with_cover.mp3" \
	  && mv -f "${file%.mp3}_with_cover.mp3" "$file"
done
}

function mp32midi(){
	ffmpeg -i "$1" /tmp/output.wav
	waon -i /tmp/output.wav -o "$1".mid
	rm /tmp/output.wav
}

function mag(){
	ssh -oHostKeyAlgorithms=+ssh-dss -o KexAlgorithms=+diffie-hellman-group1-sha1 $@
}

function ttS(){
        wget "https://translate.google.com/translate_tts?ie=UTF-8&q=$1.&tl=en&total=1&idx=0&textlen=15&tk=350535.255567&client=webapp&prev=input" -O out.mp3
        mpg123 out.mp3
	rm out.mp3
}

function freq(){
	play -n synth sin $3 sine $1\+$2
}

function os(){
$HOME/.config/bin/os.py $1
#$(host $1 | grep address | awk '{print $4}')
}

function txt2audiomorse(){
        cd /home/$USER/clones/MATTA/
        ./txt2wav_gnu $@ >> /dev/null
        cd $OLDPWD
    aplay /home/$USER/clones/MATTA/new20wpm.wav
}

function txt2morse(){
        cd /home/$USER/clones/MATTA/
        ./txt2wav_gnu $@ >> /dev/null
        cd $OLDPWD
}

function morse2txt(){
    cd /home/$USER/clones/MATTA/
    ./wav2txt_gnu $@ >> /dev/null
    cd $OLDPWD        
}

function mvmorse(){
    cp /home/$USER/clones/MATTA/new20wpm.wav $1
}

function deb(){
        ar x $1
    tar xf data*
    rm -rf $1 data* control* debian*
}

function rmk(){
    scrub -p dod $1; shred -zun 10 -v $1
}


function cpkg() {
    sudo mv /var/cache/pacman/pkg/* /home/$USER/pkg/
    cd /home/$USER/.cache/yay/
    echo "If error here is becouse any package is found, in aur or in repos"
    mv $(fd zst) /home/$USER/pkg/
    sudo chown $USER -R /home/$USER/pkg/
    cd $OLDPWD
}

function mvformat(){
# Rename all *.txt to *.text
for f in *$1; do 
    mv -- "$f" "${f%$1}$2"
done
}

function glados(){
bash /home/$USER/glados.sh $@}

function wal-tile() {
    $HOME/.config/bin/wal-tile.sh $1
}

function esen(){
    trans es:en $@
}

function enes(){
    trans en:es $@
}

function cpstat()
{
  local pid="${1:-$(pgrep -xn cp)}" src dst
  [[ "$pid" ]] || return
  while [[ -f "/proc/$pid/fd/3" ]]; do
    read src dst < <(stat -L --printf '%s ' "/proc/$pid/fd/"{3,4})
    (( src )) || break
    printf 'cp %d%%\r' $((dst*100/src))
    sleep 1
  done
  echo
}

function a2so(){
#!/bin/bash
	tmp=`echo $RANDOM$RANDOM$RANDOM`
	current_dir=`pwd`
	args0="$1"
	args1="$2"

	helpmeplease()
	{
	echo "a2so <a> <so>"
	}

	if [ -z $args0 ]; then
	#    echo "good" > /dev/null
	#else
	    helpmeplease
	    exit 1
	fi
	
	if [ -z $args1 ]; then
	#    echo "goodette" > /dev/null
	#else
	    helpmeplease
	    exit 1
	fi
	
	mkdir -p /tmp/$tmp
	cp -R ${args0} /tmp/$tmp/$tmp
	cd /tmp/$tmp
	ar -x $tmp
	gcc-9 -shared *.o -o $tmp.so
	cd $current_dir
	cp -R /tmp/$tmp/$tmp.so $args1
	rm -R /tmp/$tmp
}

function gpspic(){ exiftool $@ | grep "GPS Position" | sed 's/ deg/º/' | sed 's/ deg/º/' | sed 's/,//' | sed 's/GPS Position                    : //'}

function odinify(){
	tar -H ustar -c $1.img > $1.tar
	md5sum -t $1.tar >> $1.tar
	mv $1.tar $1.tar.md5
}

mp3to5.1() {
    for input in "$@"; do
        # Validate input file
        if [[ ! -f "$input" || "${input##*.}" != "mp3" ]]; then
            echo "Skipping invalid MP3 file: $input"
            continue
        fi

        output="${input%.*}.dts"

        ffmpeg -i "$input" -vn -filter_complex \
            "[0:a]aformat=channel_layouts=stereo,asplit=2[main][lfe]; \
             [main]highpass=f=200, \
               pan=5.1(side)| \
                 FL=FL| \
                 FR=FR| \
                 FC=0.5*FL+0.5*FR| \
                 LFE=0| \
                 SL=1*FL| \
                 SR=1*FR[main]; \
             [lfe]lowpass=f=200, \
               aformat=channel_layouts=mono, \
               volume=1.0[lfe]; \
             [main][lfe]join=inputs=2:channel_layout=5.1(side): \
               map=0.0-FL|0.1-FR|0.2-FC|0.4-SL|0.5-SR|1.0-LFE[out]" \
            -map "[out]" -c:a dts -strict -2 -b:a 756k -ar 48000 "$output"
        
        echo "Converted: $input → $output"
    done
}

mp3lowpass() {
    for input in "$@"; do
        # Check if input is a valid MP3 file
        if [[ ! -f "$input" || "${input##*.}" != "mp3" ]]; then
            echo "Skipping invalid MP3 file: $input"
            continue
        fi
        
        # Generate output filename
        output="${input%.*}_lowpass.mp3"
        
        # Apply lowpass filter at 200Hz and save as MP3
        ffmpeg -i "$input" -af "lowpass=f=200" -c:a libmp3lame -q:a 2 "$output"
        
        echo "Created lowpass version: $output"
    done
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#/usr/bin/cat ~/zshascii
#[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh







funcion cover(){
	ffmpeg -i $2 -i $1 -map_metadata 0 -map 0 -map 1 -acodec copy "$2"-tmp
	mv "$2"-tmp $2
	rm $1
}

sshtime() {
  local epoch=$(date +%s)
  ssh -t "$1" "sudo date -s '@$epoch'"
}



alias nvrun="VK_ADD_IMPLICIT_LAYER_PATH=/usr/share/vulkan/implicit_layer.d __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json VK_LAYER_PATH=/usr/share/vulkan/explicit_layer.d __GLX_VENDOR_LIBRARY_NAME=nvidia $@"
alias game='STAGING_SHARED_MEMORY="1" WINE_LARGE_ADDRESS_AWARE="1" LD_BIND_NOW="1" WINEDEBUG="-all" gamescope --adaptive-sync --hdr-sdr-content-nits=500 --hdr-enabled --hdr-itm-enable --force-grab-cursor --xwayland-count 2 -w 1920 -h 1200 -f -- gamemoderun'

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/isaac/.dart-cli-completion/zsh-config.zsh ]] && . /home/isaac/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

[ -f /opt/miniforge/etc/profile.d/conda.sh ] && source /opt/miniforge/etc/profile.d/conda.sh
