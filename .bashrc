# [[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach
# Exports
export VISUAL='nvim'
export QT_QPA_PLATFORMTHEME=qt5ct
export CACA_DRIVER=ncurses
export EDITOR='nvim'
export PATH="$HOME/.local/bin:$PATH"
export PYTHONDONTWRITEBYTECODE=1
export TERM=xterm-256color

# Better tab completion
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Prompt
GREEN='\[\e[32m\]'
WHITE='\[\e[37m\]'
BLUE='\[\e[34m\]'
YELLOW='\[\e[33m\]'
RESET='\[\e[0m\]'

set_prompt() {
    __git_ps1 "${GREEN}\u ${WHITE}in ${BLUE}\W${YELLOW}" "${RESET} $ " "  %s"
}

PROMPT_COMMAND=set_prompt

# History
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

alias ls='eza -ah --color=auto --icons --group-directories-first --git-ignore'

# Safety nets
rm() {
    local has_r=false has_f=false
    for arg in "$@"; do
        [[ "$arg" == -* ]] || continue
        [[ "$arg" == *r* || "$arg" == *R* || "$arg" == *recursive* ]] && has_r=true
        [[ "$arg" == *f* || "$arg" == *F* || "$arg" == *force* ]] && has_f=true
    done
    if $has_r && $has_f; then
        read -p "⚠ rm -rf detected. are you sure? [y/N]: " confirm
        [[ "$confirm" == "y" ]] || return 1
    else
        command rm -i "$@"
        return
    fi
    command rm "$@"
}
quiet() {
    "$@" > /dev/null 2>&1 &
}

alias cp='cp -i'
alias mv='mv -i'


# Grep with color
alias grep='rg --color=auto'

# Quick edit & reload bashrc
alias bashrc='nvim ~/.bashrc'
alias reload='source ~/.bashrc'

# Disk & memory
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Misc
alias c='clear'
alias h='history'
alias ports='ss -tulanp'

# Qol
alias vim='nvim'
alias clean='rm -rf $HOME/.cache'
alias srb2='gamemoderun org.srb2.SRB2'
alias befast='xset r rate 200 35'
alias cdwm='nvim ~/dotfiles/dwm-btw/dwm/config.h'
alias start-server='cd ~/dotfiles/betternt && python -m http.server'
alias mangofetch='fastfetch -c ~/.config/fastfetch/mango.jsonc'
# extract func
extract() {
  case "$1" in
    *.tar.gz|*.tgz)   tar xzf "$1"  ;;
    *.tar.bz2)        tar xjf "$1"  ;;
    *.zip)            unzip "$1"    ;;
    *.7z)             7z x "$1"     ;;
    *.rar)            unrar x "$1"  ;;
    *.tar.zst) tar --zstd -xf "$1"  ;;
    *.tar.xz)         tar xJf "$1"  ;;
    *)                echo "bro idk what this is" ;;
  esac
}
compress() {
  tar -cvzf "${1%/}.tar.gz" "$1"
}

# ============ suckless functions ================ #
dwm-compile() {
    cd $HOME/dotfiles/dwm-btw/dwm; sudo make clean install; cd - 
}

st-compile() {
    cd $HOME/dotfiles/dwm-btw/st; sudo make clean install; cd - 
}

dmenu-compile() {
    cd $HOME/dotfiles/dwm-btw/dmenu; sudo make clean install; cd - 
}
status-compile() {
    cd $HOME/dotfiles/dwm-btw/slstatus; sudo make clean install; cd - 
}
# Autostart
source ~/.config/git/git-prompt.sh
if [[ $- == *i* ]]; then
    clear
    nitch
    echo ""
fi
# [[ ${BLE_VERSION-} ]] && ble-attach
