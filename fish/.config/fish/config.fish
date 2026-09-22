set fish_cursor_insert line
set fish_greeting

# ===== Init =====
starship init fish | source
atuin init fish | source
zoxide init --cmd cd fish | source
# SSH agent via systemd socket (one agent per session, no zombies)
set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
fnm env --use-on-cd --shell fish | source

# Enable vim mode
fish_vi_key_bindings

# Custom
source $__fish_config_dir/custom/functions.fish

set -g __sdkman_custom_dir ~/.sdkman

# ===== Environment Variables =====
set -x CHROME_EXECUTABLE /var/lib/flatpak/app/com.google.Chrome/x86_64/stable/active/export/bin/com.google.Chrome
set -x EDGE_PATH /var/lib/flatpak/app/com.google.Chrome/x86_64/stable/active/export/bin/com.google.Chrome
set -x DOCKER_HOST unix:///var/run/docker.sock
set -x XDG_DATA_DIRS "$XDG_DATA_DIRS:/home/jd/Personal/.local/share/flatpak/exports/share"
set -x ANDROID_SDK_HOME ~/.android
set -x ANDROID_AVD_HOME ~/.android/avd
set -x ANDROID_HOME ~/Android/Sdk
set -x ZSH_CUSTOM $HOME/.oh-my-zsh/custom
set -x ATUIN_CONFIG_DIR $HOME/dotfiles/atuin/.config/atuin
set -Ux EDITOR nvim
set -x DENO_INSTALL "/home/jd/.deno"
set --export BUN_INSTALL "$HOME/.bun"
set -gx ZVM_INSTALL "$HOME/.zvm/self"
set -gx PNPM_HOME "/home/jd/.local/share/pnpm"

# ===== PATH =====
fish_add_path --append /var/lib/flatpak/app/com.google.Chrome/x86_64/stable/active/export/bin
fish_add_path --append $HOME/Apps/flutter/bin
fish_add_path --append $HOME/.pub-cache/bin
fish_add_path --append $HOME/.local/bin
fish_add_path --append $HOME/.cargo/bin
fish_add_path --append /home/jd/.spicetify
fish_add_path --append (go env GOPATH)/bin
fish_add_path --append /usr/pgsql-15/bin
fish_add_path $DENO_INSTALL/bin
fish_add_path $BUN_INSTALL/bin
fish_add_path --append "$HOME/.zvm/bin"
fish_add_path --append "$ZVM_INSTALL/"
fish_add_path "$PNPM_HOME"
fish_add_path /home/jd/.opencode/bin
fish_add_path "/home/jd/.local/share/fnm/node-versions/v25.9.0/installation/bin"

# ===== Aliases =====
alias zshconfig="nvim ~/.zshrc"
alias fishconfig="nvim ~/.config/fish/config.fish"
alias rlc='. ~/.config/fish/config.fish'
alias lj="cdi"
alias mk="mkdir -p"
alias dp="rm -rf"
alias ff="fd --type f --exclude node_modules --exclude Lib | fzf --preview 'bat --style=numbers --color=always {}' --preview-window=right:60%"
alias p="cd /home/jd/JDrive/Projects"
alias i="cd .."
alias j="clear -x"
alias sl="clear"
alias gs="git switch"
alias gi="git status"
alias gb="git branch"
alias gbw="git-branch-exclude"
alias gbd="git branch -D"
alias gk="git checkout -b"
alias gsp="git stash apply"
alias gsa="git stash -u"
alias gso="git stash pop"
alias gsl="git stash list"
alias gss="git stash push -m"
alias gm="git commit -m"
alias gp="git push"
alias gl="git pull"
alias lg="lazygit"
alias ss="scrcpy"
alias f="cd -"
alias r="cd"
alias l="exit"
alias ls="lsd"
alias vi="nvim"
alias dkd="docker compose down"
alias ld=lazydocker
alias zz=7zz
alias tt='date "+%b %d %Y %H:%M"'
alias chx="chmod +x"
alias cb="wl-copy"
alias fl="yazi"
alias explore='opencode ~/exploree'
alias oc='opencode'

# ===== Abbreviations =====
abbr ge 'git merge'
abbr bd 'git branch -D'
abbr gn gnome-extensions
abbr c. codium .
abbr grn 'git clean -n '
abbr grf 'git clean -f '

# ===== Completions & Bindings =====
uv generate-shell-completion fish | source

bind -M visual y fish_clipboard_copy
bind -M normal yy fish_clipboard_copy
bind p fish_clipboard_paste
