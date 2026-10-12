# --- Basic Setup ---
set -g fish_greeting ""
set -Ux EDITOR nvim

# --- Paths (Use fish_add_path instead of set -x PATH) ---
# fish_add_path automatically handles duplicates and keeps the list clean
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.eget/bin
fish_add_path $HOME/.deno/bin
fish_add_path $HOME/.bun/bin
fish_add_path $HOME/Apps/flutter/bin
fish_add_path $HOME/.pub-cache/bin
# Go path
if command -q go
    fish_add_path (go env GOPATH)/bin
end

# --- Environment Variables ---
set -x DOCKER_HOST unix://$HOME/.colima/default/docker.sock
set -x ANDROID_SDK_HOME ~/.android
set -x ANDROID_AVD_HOME ~/.android/avd
set -x ANDROID_HOME ~/Library/Android/sdk
set -x ATUIN_CONFIG_DIR $HOME/.config/atuin
set -gx PNPM_HOME "$HOME/Library/pnpm"
fish_add_path $PNPM_HOME

# --- Interactive Initializations (Performance Optimized) ---
if status is-interactive
    # Init tools only once when shell is interactive
    starship init fish | source
    atuin init fish | source
    zoxide init fish | source
    fnm env --use-on-cd --shell fish | source

    # Enable vim mode
    fish_vi_key_bindings

    # Load custom functions
    if test -f "$__fish_config_dir/custom/functions.fish"
        source "$__fish_config_dir/custom/functions.fish"
    end
end

# --- Aliases ---
alias zshconfig="nvim ~/.zshrc"
alias fishconfig="nvim ~/.config/fish/config.fish"
alias rlc='source ~/.config/fish/config.fish'
alias d="z"
alias lj="zi"
alias mk="mkdir -p"
alias dp="rm -rf"
alias ff="fd --type f --exclude node_modules --exclude Lib | fzf --preview 'bat --style=numbers --color=always {}' --preview-window=right:60%"
alias p="cd $HOME/JDrive/Projects"
alias i="cd .."
alias j="clear -x"
alias sl="clear"
alias dl="yt-dlp"
alias lg="lazygit"
alias ss="scrcpy"
alias f="cd -"
alias r="cd"
alias k="code ."
alias l="exit"
alias ls="lsd"
alias vi="nvim"
alias denc="$HOME/JDrive/Projects/BASH/enc.sh"
alias dkd="docker compose down"
alias ld="lazydocker"
alias zz="7zz"
alias tt='date "+%b %d %Y %H:%M"'
alias dev="ssh jd@192.168.122.155"
alias win="ssh admin@192.168.124.60"
alias chx="chmod +x"
alias cb="pbcopy"
alias fl="yazi"

# --- Git Aliases ---
alias gs="git switch"
alias gi="git status"
alias gb="git branch"
alias gk="git checkout -b"
alias gsp="git stash apply"
alias gsa="git stash -u"
alias gso="git stash pop"
alias gsl="git stash list"
alias gss="git stash push -m"
alias gm="git commit -m"
alias gp="git push"
alias gl="git pull"

# --- Abbreviations ---
abbr -a ge 'git merge'
abbr -a bd 'git branch -D'
abbr -a gn gnome-extensions

# --- Vim Mode Binds ---
bind -M visual y fish_clipboard_copy
bind -M normal yy fish_clipboard_copy
bind p fish_clipboard_paste

# opencode
fish_add_path /Users/jd/.opencode/bin

# ZVM
set -gx ZVM_INSTALL "$HOME/.zvm/self"
if test -d "$ZVM_INSTALL"
    set -gx PATH $PATH "$HOME/.zvm/bin"
    set -gx PATH $PATH "$ZVM_INSTALL"
end
