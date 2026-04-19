# ~/.zshrc

################################################################################
# START
################################################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# export PS1="➜ "

# Auto-start tmux if not running
if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
    tmux attach || tmux new
fi

# Auto-run fastfetch on start-up
# fastfetch: https://github.com/fastfetch-cli/fastfetch
if command -v fastfetch &>/dev/null; then
    fastfetch
fi

eval $(ssh-agent)

################################################################################
# OH MY ZSH
################################################################################

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="apple"

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 1

DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="false"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(
    git
    macos
)

source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:$MANPATH"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export ARCHFLAGS="-arch $(uname -m)"
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

################################################################################
# BASICS
################################################################################

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

export MANPAGER="less -R --use-color -Dd+r -Du+b"

export PATH="$HOME/bin:$PATH" # this allows me to run the bash scripts i wrote

################################################################################
# XDG
################################################################################

# https://specifications.freedesktop.org/basedir-spec/latest/
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
export XDG_CONFIG_DIRS="/etc/xdg"

################################################################################
# ALIASES
################################################################################

# Aliases
unalias -a

# zoxide: https://github.com/ajeetdsouza/zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init $(basename "$SHELL"))"
    alias cd='z'
fi

# Get OS type (Linux, Darwin/macOS, etc.)
OS="$(uname -s)"

# Linux-specific aliases
if [ "$OS" = "Linux" ]; then
    alias ls='ls --color=auto'
fi

# macOS-specific aliases
if [ "$OS" = "Darwin" ]; then
    alias ls='ls -G'
fi

# lsd: https://github.com/lsd-rs/lsd
if command -v lsd &>/dev/null; then
    alias ls='lsd'
fi

# ls
alias l='ls -l'
alias lla='ls -la'
alias ll='ls -lh'
alias la='ls -lAh'


# eza: https://github.com/eza-community/eza
if command -v eza &>/dev/null; then
    alias tree='eza -TR --classify=always --color=always --icons=always --absolute=off'
fi

# bat: https://github.com/sharkdp/bat
if command -v bat &>/dev/null; then
    alias cat='bat'
fi

# fzf: https://github.com/junegunn/fzf
if command -v fzf &>/dev/null; then
    source <(fzf --zsh)
    alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
fi

# fd: https://github.com/sharkdp/fd
if command -v fd &>/dev/null; then
    alias find='fd'
fi

# ripgrep: https://github.com/BurntSushi/ripgrep
if command -v rg &>/dev/null; then
    alias rg="rg --hidden --smart-case --glob='!.git/' --no-search-zip --trim --colors=line:fg:black --colors=line:style:bold --colors=path:fg:magenta --colors=match:style:nobold"
fi

# Disk space
alias df='df -h'
alias du='du -h -d 1'

# Open vim without loading the vimrc.
alias vimnilla='vim -u NONE'

# Open neovim without loading the init.lua.
alias nvimnilla='nvim -u NONE'

# Search
alias grep='grep --color=auto'

# Safety nets to prevent accidents
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

# Extras
alias yt-dlp='yt-dlp \
  --cookies-from-browser firefox \
  -P "~/Music" \
  -x \
  --audio-format mp3 \
  --audio-quality 0 \
  -o "%(uploader)s_%(playlist)s/%(title)s.%(ext)s" \
  --embed-metadata \
  --parse-metadata "%(title)s:%(meta_title)s" \
  --parse-metadata "%(uploader)s:%(meta_artist)s" \
  --parse-metadata "%(playlist)s:%(meta_album)s" \
  --parse-metadata "%(playlist_index)s:%(meta_track)s" \
  -i \
  --limit-rate 2M \
  --retries 10 \
  --sleep-interval 2 \
  --max-sleep-interval 5 \
  --concurrent-fragments 4'

alias valgrind='valgrind --tool=memcheck --leak-check=full --show-reachable=yes --error-exitcode=1'

# Package Management
## For brew (macOS)
alias brewup='brew update && brew upgrade && brew cleanup'

# VLC

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC --play-and-pause &'

# history opts
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

################################################################################
# FUNCTIONS
################################################################################

# Restart the shell.
restart_shell() {
  exec -l $SHELL
}

################################################################################
# ZSH
################################################################################

# load modules
# move annoying .zcompdump files into a better hidden directory
autoload -Uz compinit
compinit -d ~/.config/zsh/.zcompdump
zmodload zsh/complist

# vi keybinds
bindkey -v

################################################################################
# PROGRAMMING LANGUAGES
################################################################################

export GOROOT=
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$GOPATH/bin"
export PATH=$PATH:$GOBIN
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# eval "$(starship init zsh)"

. "$HOME/.local/share/../bin/env"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
