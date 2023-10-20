#### Variaveis.
RCor="\[\033[1;31m\]"	# Red (Vermelho)
GCor="\[\033[1;32m\]"	# Green (Verde)
YCor="\[\033[1;33m\]"	# Yellow (Amarelo)
BCor="\[\033[1;34m\]"	# Blue (Azul)
PCor="\[\033[1;35m\]"	# Purple (Roxo)
CCor="\[\033[1;36m\]"	# Cyan (Turquesa)
WCor="\[\033[1;37m\]"	# White (Branco)
ECor="\[\033[0m\]"	# End (Fim)

EDITOR="nvim"

#### Começo da Funções git status.
gitU() { git status 2>&1 | tee | sed '/\t/!d;/:/d' | sed '$=' | sed '/\t/d;s/^//' ;}
gitH() { git status 2>&1 | tee | sed '/Your branch is ahead of/!d' | sed 's/.*./ /' ;}
gitD() { git status 2>&1 | tee | sed '/deleted:/!d' | sed '$=' | sed '/\t/d;s/^//' ;}
gitR() { git status 2>&1 | tee | sed '/renamed:/!d' | sed '$=' | sed '/\t/d;s/^/ /' ;}
gitM() { git status 2>&1 | tee | sed '/modified:/!d' | sed '$=' | sed '/\t/d;s/^//' ;}
gitN() { git status 2>&1 | tee | sed '/new file:/!d' | sed '$=' | sed '/\t/d;s/^/ /' ;}
gitB() { git branch 2>&1 | tee | sed '/^[^*]/d;s/* \(.*\)/\1/' | sed 's/^/ \[/;s/$/\] /' ;}

export PS1="\\n$RCor[$WCor\A$RCor] $GCor\u$YCor@$BCor\h $GCor\w$ECor\\n$YCor\$(gitB)$CCor\$(gitH)$RCor\$(gitD)$GCor\$(gitN)$CCor\$(gitR)$YCor\$(gitU)$CCor\$(gitM)$ECor $PCor$ $ECor"
export PS2=" $GCor>$ECor "

if [ -f ~/.config/lf/icons ]; then
	. ~/.config/lf/icons
fi

#### Aliases.
alias v='nvim'
alias V='sudo nvim'
alias ls='exa -l'
alias mv='mv -iv'
alias cp='cp -riv'
alias trc='tremc'
alias calc='concalc'
alias less='batcat'
alias mkdir='mkdir -vp'
alias tmuxd='tmux new -As0'
alias legenda='subliminal --opensubtitles USERNAME PASSWORD download -l pt-br'
alias yta-mp3='yt-dlp -c --extract-audio --audio-format mp3 -o "%(playlist_index)s-%(title)s.%(ext)s" --add-metadata'
alias ytv-best='yt-dlp -c --add-metadata --format mp4 -o "%(title)s.%(ext)s"'
# alias serverhttp="python3 -m http.server 8888 -b $(hostname -I | sed 's/ .*//')"
alias gallery-zip='gallery-dl --zip'

#### Funções.
finder(){ command -v lfrun >/dev/null && lfrun "$(fzf -e | xargs -r -0)" || lf "$(fzf -e | xargs -r -0)" ;}
mpv-yt(){ nohup mpv --ontop --no-border --force-window --autofit=500x280 --geometry=-15-60 "$1" >/dev/null 2>&1 & }
cue2chd(){ chdman createcd -i "$1" -o "${1%.*}.chd" ;}
chd2cue(){ chdman extractcd -i "$1" -o "${1%.*}.cue" ;}
justread(){ readable "$1" -p html-title,html-content > /tmp/readable.html&&lynx -image_links /tmp/readable.html ;}
mergesub(){ mkvmerge -o "${1%.*}.mkv" "$1" --language 0:por --track-name 0:"Português (Brasil)" "$2" ;}
mpv-stream(){ nohup streamlink -p "mpv --cache 2048 --ontop --no-border --force-window --autofit=500x280 --geometry=-15-60" "$1" best >/dev/null 2>&1 & }
hideinimage(){ cat "$@" > "copy_$1" ;}

apt() { 
  if [ -e /usr/bin/nala ]; then
    command nala "$@"
  else
    command apt "$@"
  fi
}
sudo() {
  if [ "$1" = "apt" ] && [ -e /usr/bin/nala ]; then
      shift
      command sudo nala "$@"
  else
      command sudo "$@"
  fi
}

mdtopdf() { 
  base=${1##*/}
  pandoc --pdf-engine=lualatex \
  -V 'mainfont: Quicksand' \
  -V 'fontsize: 12pt' \
  -V 'geometry:top=30mm, left=20mm, right=20mm, bottom=30mm' \
  "$1" -o "${base%.*}".pdf \
  ;}

#### Exports.
set -o vi
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.config/scripts"

#### Man Page Colors.
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

#### Mostrar arquivos ocultos com FZF e abri com o aplcativo padrão pra determinado arquivo.
export FZF_DEFAULT_COMMAND='find /home /media /mnt'
export FZF_DEFAULT_OPTS="--color='bg+:#282C34,fg+:#99cc99,pointer:#99cc99,prompt:#99cc99,border:#99cc99' --border"

bind '"\C-X":"tmuxd\n"'
bind '"\C-F":"finder\n"'
bind '"\C-G":"$(fzf -e)\n"'

debfetch
