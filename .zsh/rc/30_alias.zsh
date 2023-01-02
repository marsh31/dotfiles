
alias rel="source ~/.zsh/.zshrc"
alias ..="cd .."


# Force to check action.
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"


if type bat >/dev/null 2>&1; then
  alias bat="bat --terminal-width=-1"
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi


# linux command
if [[ "$(uname -s)" = "Linux" ]]; then
    alias lock="gnome-screensaver-command -l"

    alias ls='ls --color=auto'
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

    alias open="xdg-open"


# darwin command. So, for OSX.
elif [[ "$(uname -s)" = "Darwin" ]]; then
    alias lock="osascript -e 'tell applkication \"Finder\" to sleep'"

    alias ls="ls -G"
#    alias alert='osascript -e \"display notification \"$(history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*aleeert$//')\"\"'    

fi


# colored GCC warnings and errors
# some more ls aliases
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'


# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias tree="tree --charset=C -N"
alias l='clear && la'
alias vi='vim'
alias bye="exit"


