plugins=(git sudo docker aws brew npm)
ZSH_THEME="simple"

[[ -s $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh
[[ -s $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases

if [[ -d $NU_HOME ]]; then
    [[ -s $HOME/.nubank_rc ]] && source $HOME/.nubank_rc
    [[ -s $HOME/.nubank_aliases ]] && source $HOME/.nubank_aliases
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

autoload -Uz compinit ; compinit
