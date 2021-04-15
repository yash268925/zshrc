### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"

zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma/fast-syntax-highlighting \
    blockf \
        zsh-users/zsh-completions \

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

bindkey -v

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light tj/git-extras
zinit light zsh-users/zsh-history-substring-search

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
export TERM=xterm-256color

if type nvim > /dev/null 2>&1; then
  export EDITOR=nvim
fi

setopt share_history
setopt extended_history
setopt append_history

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:sudo:*' \
    command-path \
        /usr/local/sbin \
        /usr/local/bin \
        /usr/sbin \
        /usr/bin \
        /sbin \
        /bin \
        /usr/X11R6/bin \
        /usr/local/git/bin

if type dircolors > /dev/null 2>&1; then
  eval $(dircolors $HOME/.dircolors)
elif type gdircolors > /dev/null 2>&1; then
  eval $(gdircolors $HOME/.dircolors)
fi
export ZLS_COLORS=$LS_COLORS
export CLICOLOR=true

if [[ $(/bin/ls --version > /dev/null 2>&1| xargs | awk "{print $2}") =~ coreutils ]]; then
  LS='ls'
else
  LS='gls'
fi
alias ls="$LS --color"

export PROMPT=$'\n'"%F{220}${HOST}: %F{222}%~"$'\n'"%F{007}%# "

export PATH=$HOME/.local/bin:$PATH

if [[ -f $HOME/.zshrc.local ]]; then
  source $HOME/.zshrc.local
fi
