#       ___           ___           ___           ___           ___     
#      /  /\         /  /\         /__/\         /  /\         /  /\    
#     /  /::|       /  /:/_        \  \:\       /  /::\       /  /:/    
#    /  /:/:|      /  /:/ /\        \__\:\     /  /:/\:\     /  /:/     
#   /  /:/|:|__   /  /:/ /::\   ___ /  /::\   /  /:/~/:/    /  /:/  ___ 
#  /__/:/ |:| /\ /__/:/ /:/\:\ /__/\  /:/\:\ /__/:/ /:/___ /__/:/  /  /\
#  \__\/  |:|/:/ \  \:\/:/~/:/ \  \:\/:/__\/ \  \:\/:::::/ \  \:\ /  /:/
#      |  |:/:/   \  \::/ /:/   \  \::/       \  \::/~~~~   \  \:\  /:/ 
#      |  |::/     \__\/ /:/     \  \:\        \  \:\        \  \:\/:/  
#      |  |:/        /__/:/       \  \:\        \  \:\        \  \::/   
#      |__|/         \__\/         \__\/         \__\/         \__\/    

# Disable compfix
export ZSH_DISABLE_COMPFIX="true"
export ZSH="$HOME/.oh-my-zsh"

# Syntax highlighting and history substring search
source /usr/local/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh /zsh-history-substring-search/zsh-history-substring-search.zsh

# Pasting with autosuggest
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Locale settings
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set up PATH
export PATH="/usr/local/opt/openjdk/bin:$PATH"
eval "$(direnv hook zsh)"

# Kubernetes configuration
source <(kubectl completion zsh)
alias kubectl=kubecolor
compdef kubecolor=kubectl
export PATH="$HOME/.krew/bin:$PATH"

# Git configuration
git config --global alias.short-log 'log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=short'
git config --global alias.latest-commit-sha 'rev-parse --short HEAD'
git config --global alias.branches '!git --no-pager branch -a'
git config --global core.editor "code --wait"

# Aliases and environment variables
alias tf=terraform
unset MAILCHECK
alias vim="nvim"
export EDITOR=vim

# Node version tooling
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Automatically switch NVM version based on .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc

# Additional PATH settings
export PATH="/usr/local/opt/cython/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Yargs completions for gt
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /opt/homebrew/bin/gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt

# Read NPM_TOKEN from .npmrc
export NPM_TOKEN=$(cat ~/.npmrc | cut -d "=" -f2)

# Rancher Desktop configuration
export PATH="$HOME/.rd/bin:$PATH"

# RVM configuration
export PATH="$HOME/.rvm/bin:$PATH"

# 1Password completion
eval "$(op completion zsh)"; compdef _op op

# Starship prompt
eval "$(starship init zsh)"

# AWS and other tooling configurations
export AWS_PROFILE=default

# GoEnv configuration
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# Startup commands
fastfetch -l nixos
load-nvmrc > /dev/null 2>&1
[[ ! -f ~/.kubecm ]] || source ~/.kubecm
