#
#
#
#
#


fbr() {
  local branches branch
  branches=$(git branch -vv) && 
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | awk '{ print $1 }' | sed "s/.* //")
}


fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) && 
    branch=$(echo "$branches" | fzf +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
        --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color-always % | less -R') << 'FZF-EOF'
                                {}
FZF-EOF"
}

gcd() {
  query_text="$@"
  selected=$(ghq list -p | fzf +m --ansi --query=$query_text)

  [[ -n "$selected" ]] && cd "${selected}"
}


rcd() {
  list="$HOME"
  cur_dir="$(pwd)"
  while :; do
    cur_dir="${cur_dir%/*}"
    if [[ "$cur_dir" == "$HOME" ]]; then
      break
    fi

    res="$(ls -a $cur_dir | grep .gitignore)"
    if [[ -n $res ]]; then
      list="$cur_dir\n$list"
    fi
  done
  res="$(echo $list  | sort | fzf +m)"
  if [[ -n $res ]]; then
    cd $res
  fi
}



# vim: ft=sh
