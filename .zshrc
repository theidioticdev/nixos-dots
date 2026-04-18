# ── git integration ───────────────────────────────────────────────────────────
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST

# ── static named dirs ─────────────────────────────────────────────────────────
hash -d pwos=~/pw-testing/


# ── fzf integration ──────────────────────────────────────────────────────────
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_OPTS="--color=16,info:4,pointer:4,marker:4,spinner:4,header:4 --height 40% --layout=reverse --border"

# ── Prompt ────────────────────────────────────────────────────────────────────
zstyle ':vcs_info:git:*' formats ' on %F{cyan}%b%f'
zstyle ':vcs_info:*' enable git

PROMPT='%B%F{white}%n%b %F{244}in %B%F{white}%~%b${vcs_info_msg_0_}%f ~> '
# ── Plugins ───────────────────────────────────────────────────────────────────
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# ── History ───────────────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# ── Navigation ────────────────────────────────────────────────────────────────
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

alias ..='cd ..'
alias ...='cd ../..'
alias back='popd'

# ── ls ────────────────────────────────────────────────────────────────────────
alias ls='eza --icons --color=auto'
alias ll='eza -lah'
alias la='eza -A'
cd() { 
  builtin cd "$@" && [ -t 1 ] && eza --icons --color=auto; 
}
# ── Safety nets ───────────────────────────────────────────────────────────────
alias rm='rm -i'
# alias cp='cp -i'
alias mv='mv -i'

# ── Better tools ─────────────────────────────────────────────────────────────
alias grep='rg --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# ── QoL ───────────────────────────────────────────────────────────────────────
alias c='clear'
alias ports='ss -tulanp'
alias please='sudo -i'
alias apt='man pacman'
alias apt-get='man pacman'
alias changekey="setxkbmap -layout us,eg -option 'grp:alt_shift_toggle'"
alias whereami='echo "Display: $DISPLAY | Wayland: $WAYLAND_DISPLAY | Session: $XDG_SESSION_TYPE"'
alias -g g='| grep'
alias -g l='| less'
alias -g h='| head'
alias -g t='| tail'
alias -g ne='2> /dev/null'
alias srb2='gamemoderun flatpak run org.srb2.SRB2'
alias befast='xset r rate 200 35'
alias gcl='git clone'
alias gsa='git status'
alias gcm='git commit -m'
alias ga='git add'
alias gph='git push'
alias gpu='git pull'
alias no-reb='git pull --no-rebase'
alias brave-wl='brave --ozone-platform=wayland --enable-features=WaylandWindowDecorations --disable-features=WaylandFractionalScaleV1'
# ── Config shortcuts ──────────────────────────────────────────────────────────
alias zshrc='$EDITOR ~/.zshrc'
alias reload='source ~/.zshrc'

# ── export ────────────────────────────────────────────────────────────────────
export EDITOR=vim
export VISUAL=vim
export PYTHONDONTWRITEBYTECODE=1
export TERM=alacritty
export PATH="$HOME/.local/bin:$PATH"

# ── Functions ─────────────────────────────────────────────────────────────────
mkcd() { mkdir -p "$1" && cd "$1"; }

extract() {
  case "$1" in
    *.tar.gz|*.tgz)   tar xzf "$1"  ;;
    *.tar.bz2)        tar xjf "$1"  ;;
    *.zip)            unzip "$1"    ;;
    *.7z)             7z x "$1"     ;;
    *.rar)            unrar x "$1"  ;;
    *.tar.xz)         tar xJf "$1"  ;;
    *.tar.zst)  tar --zstd -xf "$1" ;;
    *)                echo "bro idk what this is" ;;
  esac
}
compress() {
  tar -cvzf "${1%/}.tar.gz" "$1"
}

command_not_found_handler() {
    echo -e "\e[1;31mzsh: command not found: $1\e[0m"
    echo -n -e "\e[1;32mCheck CachyOS repos for '$1'? (y/n) \e[0m"
    read -r answer
    if [[ "$answer" == "y" ]]; then
        pacman -Ss "$1"
    fi
}
# ── Autostart ─────────────────────────────────────────────────────────────────
if [[ $- == *i* ]]; then
    if gum confirm "Play intro?"; then
        clear
        gum spin --spinner "dot" --title "Loading..." -- sleep 1
        
        echo  "Hello, $USER." | boxes -d ansi-rounded | pv -qL 1500
        
        echo -e " $(whoami)\n󰒋 $(hostname)\n $(pwd)" | gum style --faint
        echo ""
    fi
fi
fish_add_path -aP /home/mostafa/.local/share/bin
fish_add_path -aP /home/mostafa/.local/share/bin
fish_add_path -aP /home/mostafa/.local/share/bin
fish_add_path -aP /home/mostafa/.local/share/bin
fish_add_path -aP /home/mostafa/.local/share/bin
fish_add_path -aP /home/mostafa/.local/share/bin
