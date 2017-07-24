bindkey -e

alias la="ls -lha"
alias ll="ls -lh"
autoload -U compinit; compinit
alias em="emacs"
setopt nonomatch
zstyle ':completion:*default' menu select=1

autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
autoload colors
colors
local p_def=$'\n'"%F{yellow}%~%f"$'\n'
local p_def2="%n@%F{cyan}%m%f"
PROMPT="$p_def$p_def2 > "
RPROMPT="%1(v|%F{green}%1v%f|)"

if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi

export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin:$HOME/.cask/bin
alias ginstall="GOOS=linux GOARCH=amd64 go install"

set bell-style visble

export agent="/tmp/ssh-agent-$USER"
if [ $?SSH_AUTH_SOCK ] ; then
   if [ ! -S $SSH_AUTH_SOCK ]; then
      unset SSH_AUTH_SOCK
   fi
fi

if [ $?SSH_AUTH_SOCK ] ; then
    if [[ "$SSH_AUTH_SOCK" =~ "/tmp/ssh-.[a-zA-Z0-9]*/agent.[0-9]*" ]] ; then
      ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
    fi
else if [ -S $agent ] ; then
         export SSH_AUTH_SOCK=$agent
     else
         echo "no ssh-agent"
     fi
fi
unset agent

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY
setopt hist_ignore_all_dups
setopt hist_expand

LANG=ja_JP.UTF-8
export LANG
