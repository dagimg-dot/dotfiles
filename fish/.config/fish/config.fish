set fish_greeting

# Init
starship init fish | source
atuin init fish | source
zoxide init fish | source
eval (ssh-agent -c) >/dev/null 2>&1
fnm env --use-on-cd --shell fish | source

# Enable vim mode
fish_vi_key_bindings

# Custom
source $__fish_config_dir/custom/functions.fish

# Exports
set -g __sdkman_custom_dir ~/.sdkman
set -x PATH $PATH $HOME/Apps/flutter/bin
set -x CHROME_EXECUTABLE /var/lib/flatpak/app/com.google.Chrome/x86_64/stable/active/export/bin/com.google.Chrome
set -x PATH $PATH $HOME/.pub-cache/bin
set -x PATH $PATH $HOME/.local/bin
set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH /home/jd/.spicetify
set -x DOCKER_HOST unix:///var/run/docker.sock
set -x XDG_DATA_DIRS "$XDG_DATA_DIRS:/home/jd/Personal/.local/share/flatpak/exports/share"
set -x ANDROID_SDK_HOME ~/.android
set -x ANDROID_AVD_HOME ~/.android/avd
set -x ANDROID_HOME ~/Android/Sdk
set -x ZSH_CUSTOM $HOME/.oh-my-zsh/custom
set -x ATUIN_CONFIG_DIR $HOME/dotfiles/atuin/.config/atuin


# Aliases
alias zshconfig="nvim ~/.zshrc"
alias fishconfig="nvim ~/.config/fish/config.fish"
alias rlc='. ~/.config/fish/config.fish'
alias d="z"
alias mk="mkdir"
alias dp="rm -rf"
alias ff="fd --type f --exclude node_modules --exclude Lib | fzf --preview 'bat --style=numbers --color=always {}' --preview-window=right:60%"
alias p="cd /home/jd/JDrive/Projects"
alias i="cd .."
alias j="clear -x"
alias dl="yt-dlp"
alias gs="git switch"
alias gi="git status"
alias gb="git branch"
alias gk="git checkout -b"
alias gsp="git stash apply"
alias gsl="git stash list"
alias gss="git stash push -m"
alias gm="git commit"
alias lg="lazygit"
alias ss="scrcpy"
alias f="cd -"
alias r="cd"
alias k="code ."
alias l="exit"
alias ls="eza"
alias vi="nvim"
alias denc="$HOME/JDrive/Projects/BASH/enc.sh"
alias dkd="docker compose down"
alias ld=lazydocker
alias po=poetry
alias zz=7zz
alias tt='date "+%b %d %Y %H:%M"'
alias dev="ssh lix@192.168.124.167"
alias win="ssh admin@192.168.124.60"
alias chx="chmod +x"
alias grep="rg"

# pnpm
set -gx PNPM_HOME "/home/jd/.local/share"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# deno
set -x DENO_INSTALL "/home/jd/.deno"    
set -x PATH $DENO_INSTALL/bin:$PATH