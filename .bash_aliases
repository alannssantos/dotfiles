#### Variaveis.
Cor=("\[\033[0m\]"
  "\[\033[1;31m\]"
  "\[\033[1;32m\]"
  "\[\033[1;33m\]"
  "\[\033[1;34m\]"
  "\[\033[1;35m\]"
  "\[\033[1;36m\]"
  "\[\033[1;37m\]")

export EDITOR="hx"
export SUDO_EDITOR="hx"

#### Começo da Funções git status.
gitU() { git status 2>&1 | tee | sed '/\t/!d;/:/d' | sed '$=' | sed '/\t/d;s/^//'; }
gitH() { git status 2>&1 | tee | sed '/Your branch is ahead of/!d' | sed 's/.*./ /'; }
gitD() { git status 2>&1 | tee | sed '/deleted:/!d' | sed '$=' | sed '/\t/d;s/^//'; }
gitR() { git status 2>&1 | tee | sed '/renamed:/!d' | sed '$=' | sed '/\t/d;s/^/ /'; }
gitM() { git status 2>&1 | tee | sed '/modified:/!d' | sed '$=' | sed '/\t/d;s/^//'; }
gitN() { git status 2>&1 | tee | sed '/new file:/!d' | sed '$=' | sed '/\t/d;s/^/ /'; }
gitB() { git branch 2>&1 | tee | sed '/^[^*]/d;s/* \(.*\)/\1/' | sed 's/^/ \[/;s/$/\] /'; }

export PS1="\\n${Cor[1]}[${Cor[7]}\A${Cor[1]}] ${Cor[2]}\u${Cor[3]}@${Cor[4]}\h ${Cor[2]}\w${Cor[0]}\\n${Cor[3]}\$(gitB)${Cor[5]}\$(gitH)${Cor[1]}\$(gitD)${Cor[2]}\$(gitN)${Cor[6]}\$(gitR)${Cor[3]}\$(gitU)${Cor[6]}\$(gitM)${Cor[0]} ${Cor[5]}$ ${Cor[0]}"
export PS2=" ${Cor[2]}>${Cor[0]} "

if [ -f "$HOME"/.config/lf/icons ]; then
  . "$HOME"/.config/lf/icons
fi

#### Aliases.
alias v='nvim'
alias yz='yazi'
alias hx='helix'
alias ls='exa -l'
alias mv='mv -iv'
alias cp='cp -riv'
alias trc='tremc'
alias calc='concalc'
alias less='batcat'
alias mkdir='mkdir -vp'
alias tmuxd='tmux new -As0'
alias zs0='zellij attach --create s0'
alias legenda='subliminal --opensubtitles USERNAME PASSWORD download -l pt-br'
alias yta-mp3='yt-dlp -c --extract-audio --audio-format mp3 -o "%(playlist_index)s-%(title)s.%(ext)s" --add-metadata'
alias ytv-best='yt-dlp -c --add-metadata --format mp4 -o "%(title)s.%(ext)s"'
alias ortografia='aspell check --lang=pt_BR'
alias gallery-zip='gallery-dl --zip'

#### Funções.
hideinimage() { cat "$@" >"copy_$1"; }
ssh-tmux(){ ssh "$@" -t 'tmux new -As0'; }
cue2chd() { chdman createcd -i "$1" -o "${1%.*}.chd"; }
chd2cue() { chdman extractcd -i "$1" -o "${1%.*}.cue"; }
finder() { command -v lfrun >/dev/null && lfrun "$(fzf -e | xargs -r -0)" || lf "$(fzf -e | xargs -r -0)"; }
mpv-yt() { nohup mpv --ontop --no-border --force-window --autofit=500x280 --geometry=-15-60 "$@" >/dev/null 2>&1 & }
justread() { readable "$@" -p html-title,html-content >/tmp/readable.html && lynx -image_links /tmp/readable.html; }
mpv-stream() { nohup streamlink -p "mpv --cache 2048 --ontop --no-border --force-window --autofit=500x280 --geometry=-15-60" "$1" best >/dev/null 2>&1 & }

# Flexget Movie Function.
movie-add() { flexget movie-list add "$*"; }
movie-del() { flexget movie-list del "$(flexget movie-list list |
  sed -r '/^│/!d' |
  awk -F"│" '{print $3}' |
  sed 's/^ *//;s/ *$//' |
  fzf)"; }

mkvsubflag() {
  for i in "$@"; do
    data=$(ffprobe -loglevel error -select_streams s -show_entries stream=index:stream_tags=language:stream_tags=title:stream_disposition=default -of csv=p=0 "$i")
    unset_track=$(sed -r '/[0-9]*,1,.*/!d;s/([0-9]*),1,.*/\1/' <<<"$data" | tail -1)
    set_track=$(sed -r '/,por,.*Bra.il/!d;s/([0-9]*),.*/\1/' <<<"$data")
    mkvpropedit "$i" \
      --edit track:@$(("$unset_track" + 1)) \
      --set flag-default=0 \
      --edit track:@$(("$set_track" + 1)) \
      --set flag-default=1
  done
}

livetv() {
  Channel_Name=$(yt-dlp --skip-download "$@" --print "channel")
  Channel_Url=$(yt-dlp --skip-download "$@" --print "channel_url")
  yt-dlp --format "best[height<=720]" --skip-download -g "$@" > "$Channel_Name.strm"
  yt-dlp --skip-download --write-thumbnail --playlist-items 0 --convert-thumbnails jpg --output "%(channel)s" "$Channel_Url"
}

mdtopdf() {
  base=${1##*/}
  pandoc --pdf-engine=lualatex \
    -V 'mainfont:Ubuntu' \
    -V 'monofont:Ubuntu Mono' \
    -V 'fontsize:12pt' \
    -V 'geometry:a4paper' \
    -V 'geometry:margin=2cm' \
    "$1" -o "${base%.*}".pdf \
    ;
}

f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

#### Exports.
set -o vi
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.config/scripts"

#### Man Page Colors.
export MANPAGER="less -R --use-color -Dd+r -Du+b"

#### Mostrar arquivos ocultos com FZF e abri com o aplcativo padrão pra determinado arquivo.
export FZF_DEFAULT_COMMAND='fdfind . /home /media /mnt'
export FZF_DEFAULT_OPTS="--color='bg+:#282C34,fg+:#99cc99,pointer:#99cc99,prompt:#99cc99,border:#99cc99' --border"

bind '"\C-X":"tmuxd\n"'
bind '"\C-F":"finder\n"'

if [ -x "$(command -v debfetch)" ]; then
  debfetch
fi
