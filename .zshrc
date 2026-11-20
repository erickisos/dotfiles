plugins=(git sudo docker aws brew npm)
# ZSH_THEME="robbyrussell"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} %D %T % %{$reset_color%}'

[[ -s $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh
[[ -s $HOME/.zsh_aliases ]] && source $HOME/.zsh_aliases

HIST_STAMPS="%Y-%m-%d %H:%M:%S"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

autoload -Uz compinit
compinit
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export OPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl@3
export PATH="/opt/homebrew/opt/ncurses/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# bun completions
[ -s "/Users/erickisos/.bun/_bun" ] && source "/Users/erickisos/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH=/Users/erickisos/.bun/bin:/Users/erickisos/.pyenv/shims:/opt/homebrew/opt/ncurses/bin:/Users/erickisos/.sdkman/candidates/leiningen/current/bin:/Users/erickisos/.sdkman/candidates/java/current/bin:/Users/erickisos/bin:/opt/homebrew/opt/icu4c/sbin:/opt/homebrew/opt/icu4c/bin:/Users/erickisos//bin:/opt/homebrew/bin:/opt/homebrew/sbin:/Library/Frameworks/Python.framework/Versions/3.12/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Library/Apple/usr/bin:/usr/local/MacGPG2/bin:/Library/TeX/texbin:/usr/local/share/dotnet:~/.dotnet/tools:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/Users/erickisos/.nvm/versions/node/v16.14.0/bin:/Users/erickisos/.cargo/bin:/Users/erickisos/.emacs.d/bin:/Users/erickisos/.local/bin:/Users/erickisos/.dotnet/tools:/Users/erickisos/.roswell/bin

export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/Cellar/glibmm/2.84.0/lib/pkgconfig"

# Qt5
export LDFLAGS="-L/opt/homebrew/opt/qt@5/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/qt@5/include $CPPFLAGS"
export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/qt@5/lib/pkgconfig:$PKG_CONFIG_PATH"

# OpenBLAS
export LDFLAGS="-L/opt/homebrew/opt/openblas/lib $LDFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/openblas/include $CPPFLAGS"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openblas/lib/pkgconfig:$PKG_CONFIG_PATH"

# Bison
export PATH="/opt/homebrew/opt/bison/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/bison/lib $LDFLAGS"

# NCurses
export LDFLAGS="-L/opt/homebrew/opt/ncurses/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ncurses/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ncurses/lib/pkgconfig:$PKG_CONFIG_PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Load Angular CLI autocompletion for interactive shells.
if [[ $- == *i* ]]; then
  source <(ng completion script)
fi
