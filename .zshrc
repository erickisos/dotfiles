plugins=(git sudo docker aws brew npm)

ZSH_THEME="simple"

source $ZSH/oh-my-zsh.sh
[[ -s $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases
[[ -s $HOME/.nubank_rc ]] && source $HOME/.nubank_rc
[[ -s $HOME/.nubank_aliases ]] && source $HOME/.nubank_aliases

autoload -Uz compinit ; compinit
