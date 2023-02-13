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
__conda_name=""
if [[ -d "$HOME/miniforge3" ]]; then
    __conda_name="miniforge3"
elif [[ -d "$HOME/mambaforge" ]]; then
    __conda_name="mambaforge"
fi

__conda_setup="$('$HOME/${__conda_name}/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/${__conda_name}/etc/profile.d/conda.sh" ]; then
        . "$HOME/${__conda_name}/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/${__conda_name}/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

autoload -Uz compinit ; compinit
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
