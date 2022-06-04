plugins=(git sudo docker aws brew npm)

ZSH_THEME="simple"

source $ZSH/oh-my-zsh.sh

if [[ -r $HOME/.nubank_rc ]]; then
    source .nubank_rc
fi

autoload -Uz compinit ; compinit
