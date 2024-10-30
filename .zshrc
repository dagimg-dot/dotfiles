CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"

plugins=(git)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export PATH="$PATH:$HOME/Apps/flutter/bin"
export CHROME_EXECUTABLE="/var/lib/flatpak/app/com.google.Chrome/x86_64/stable/active/export/bin/com.google.Chrome"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/.local/bin"
export PATH="$PATH":"$HOME/.cargo/bin"

# Aliases

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias hib="kitty"
alias cd="z"
alias mk="mkdir"
alias dp="rm -rf"
alias ff="fd --type f --exclude node_modules --exclude Lib | fzf --preview 'bat --style=numbers --color=always {}' --preview-window=right:60%"
alias p="cd /home/jd/JDrive/Projects"
alias i="cd .."
alias j="clear -x"
alias al="nautilus ."
alias dl="yt-dlp"
alias gs="git switch"
alias gb="git checkout -b"
alias gsp="git stash apply"
alias gsl="git stash list"
alias gc="git commit"
alias ss="scrcpy"
alias f="cd -"
alias r="cd"
alias k="code ."
alias l="exit"
alias ls="eza"
alias v="nvim"
alias dev="ssh lix@192.168.124.167"
alias win="ssh admin@192.168.124.60"

# initialize autocompletion
autoload -U compinit && compinit

# history setup
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST

# starship
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(ssh-agent -s)" >/dev/null 2>&1

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/fzf/shell/key-bindings.zsh
source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $HOME/JDrive/Projects/BASH/popener.sh
source $HOME/JDrive/Projects/BASH/dent.sh
source $HOME/JDrive/Projects/BASH/toggle_encfs.sh
# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# --- setup fzf theme ---
#fg="#CBE0F0"
#bg="#011628"
#bg_highlight="#143652"
#purple="#B388FF"
#blue="#06BCE4"
#cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

export BAT_THEME=tokyonight_night
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}	


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.cargo/env"

# Check for .nvmrc and use the specified Node version
if [ -f ".nvmrc" ]; then
    nvm use
    clear
fi


# pnpm
export PNPM_HOME="/home/jd/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
source "$HOME/.rye/env"


# Custom Functions

# Function to change directory inside the current directory
fk() {
  local dir=$(fd --type d --exclude node_modules --exclude Lib | fzf --no-multi)
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}


function cursor() {
    /home/jd/AppImages/cursor.appimage </dev/null &>/dev/null $1 &
}

export DOCKER_HOST=unix:///var/run/docker.sock
export XDG_DATA_DIRS="$XDG_DATA_DIRS:/home/jd/Personal/.local/share/flatpak/exports/share"
alias ld=lazydocker
alias po=poetry
alias zz=7zz
alias tt='date +"%b %-d %Y"'

export PATH=$PATH:/home/jd/.spicetify

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
