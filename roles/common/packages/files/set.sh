# autojump
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

# fzf
if [  -n "$ZSH_NAME" ]
then
    # echo 'running zsh';
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh;
else
    # echo 'running bash';
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash;
fi

glf() {
  local out file key
  out=($(git ls-files | fzf --preview 'head -100 {}' --query="$1" --select-1 --exit-0 --expect=ctrl-v))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
      if [ "$key" = ctrl-v ] ; then
        ${EDITOR:-vim} "$file"
      fi
  fi
}

gsh() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# tre() {
#   local dir
#   dir=$(tree | fzf --reverse +m) &&
#   cd "$dir"

#   # dir=$(find ${1:-.} -path '*/\.*' -prune \
#   #                 -o -type d -print 2> /dev/null | fzf --reverse +m) &&
#   # cd "$dir"
# }

# test() {
#   echo $(find ${1:-.})
# }


export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_DEFAULT_OPTS='--height 70% --reverse --border'

# Enhancd
if [ -d $HOME/.enhancd ] ; then
    source $HOME/.enhancd/init.sh
fi

# anyenv
if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
fi


# goenv
if [ -d $HOME/.anyenv/envs/goenv ] ; then
    export GOPATH=$HOME/go
    export GOBIN=$GOPATH/bin
    eval "$(goenv init -)"
fi

# pyenv
if [ -d $HOME/.anyenv/envs/pyenv ] ; then
    export PATH="$HOME/.anyenv/envs/pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    # eval "$(pyenv virtualenv-init -)"
fi

# mru
source $HOME/mru.sh
