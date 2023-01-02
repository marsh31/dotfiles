# ~/.zshenv: executed by zsh for non login shells.
#
# $PATH, $EDITOR, $PAGER
# [TODO]
# [NOTE]

stty -ixon # disable Ctrl-s and Ctrl-q.

# Linux setting
if [[ "$(uname -s)" = "Linux" ]]; then
    :

# Mac OS setting
elif [[ "$(uname -s)" = "Darwin" ]]; then
    export CLICOLOR=1
fi

export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export TERMINAL="urxvt"
export BROWSER="firefox"
export WWW_BROWSER="w3m"
export DOWNLOADER="wget -S"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="UTF-8"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export RUST_SRC_PATH=$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library
source $HOME/.cargo/env

export MEMO_HOME="$HOME/Memo"


export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# export LESS='-i -R -Q -s -M -x4 -N -J --LONG-PROMPT'
export LESS='-i -J -M -Q -R -s -x --LONG-PROMPT'

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"


export FZF_DEFAULT_OPTS="--ansi --height 40% --reverse --cycle --margin=0,1 --exit-0 --multi --bind ctrl-a:select-all"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob \"!.git/*\""

export JAVA_HOME="$(readlink -f /usr/bin/java | sed "s:/bin/java::")"
export PATH=$PATH:$JAVA_HOME/bin

export HISTFILE=~/.zsh/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000


export EDITOR="nvim"

export QT_STYLE_OVERRIDE=kvantum

path=(
    /snap/bin
    $HOME/bin(N-/)
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin
    /usr/games
    /usr/local/games
    $HOME/.local/bin(N-/)
    $HOME/go/bin
    $HOME/.cargo/env
    $path
)



chpwd() {
    if [[ "$(uname -s)" = "Linux" ]]; then
        ls --color=auto -a
    elif [[ "$(uname -s)" = "Darwin" ]]; then
        ls -G -a
    fi
}


export ANDROID_NDK_HOME=~/Android/Sdk/ndk/21.0.6113669
# c/c++ include header path


# library path

# ld_library path

# dyld_library path


# go lang
export GOPATH=$HOME/go
export GOPATH=$GOPATH:$HOME/git

export GOBIN=$HOME/bin

export PATH=$PATH:$GOPATH/bin


# # ssh-agent
# eval "$(ssh-agent)"

# xset r rate 200 60
# xmodmap ~/.Xmodmap
