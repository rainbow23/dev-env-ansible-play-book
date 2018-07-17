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
    git ls-files | fzf --preview 'head -100 {}'
}

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
