#
# .zshrc 
# 


export FPATH=/home/marsh/.zsh/bin:$FPATH
autoload -Uz zsh_test

export PAGER=less

# Completion
autoload -Uz compinit
compinit

setopt complete_in_word
setopt correct
setopt magic_equal_subst
setopt auto_list
setopt list_packed
setopt list_types
unsetopt auto_menu
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' vebose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completion %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
zstyle ':completion:*' group-name ''

autoload -U select-word-style
select-word-style bash
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified


# History
unsetopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt inc_append_history



# changed directory
setopt auto_pushd
setopt pushd_ignore_dups


# Character
setopt ignoreeof
setopt print_eight_bit
setopt interactive_comments


# Glob
setopt extended_glob
unsetopt caseglob


# Notify
setopt no_beep
setopt no_list_beep
setopt no_hist_beep
setopt notify


# bind key
bindkey -e

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^[^E" edit-command-line


# Prompt
autoload -Uz colors
colors

autoload -Uz add-zsh-hook
autoload -Uz terminfo

setopt prompt_subst
PROMPT="
%{$fg_bold[green]%}%n@%m:%{$reset_color%}%{$fg_bold[blue]%}%~%{$reset_color%}
%{$fg_bold[red]%}>%{$reset_color%} "

## version control system info
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{blue}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '%F{red}[%b|%a]%f'

precmd() { vcs_info }
RPROMPT='${vcs_info_msg_0_}'



# Load setting file
for file in $(find $ZDOTDIR/rc -type f); do
  source $file
done


# Load complete
for file in $(find $ZDOTDIR/complete -maxdepth 1 -type f); do
  source $file
done


type fzf > /dev/null 2>&1 && . $ZDOTDIR/rc/git_fzf.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -f ~/git/src/github.com/marsh31/tmuxtream/keybind.zsh ]] && source ~/git/src/github.com/marsh31/tmuxtream/keybind.zsh

if [[ -z "$TMUX" ]]; then
  # tmuxtream
fi
