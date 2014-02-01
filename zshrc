#!/bin/zsh
# Compinit.
autoload -U compinit
compinit 

# emacs keybind.
bindkey -e

# Prompt apperance.
name=$HOST
PROMPT="${name}%~%% "
PROMPT2="${name} %_%% "
SPROMPT="might be %r ? [n,y,a,e]: "
unset name

# History completion.
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=2000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history    # share command history data 
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

# Directory stack.
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Ignore case when completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Do not logout with Ctrl-d
setopt ignore_eof

# Some alias
alias ls='ls -F'
