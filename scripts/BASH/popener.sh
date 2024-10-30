#!/bin/bash

# This script is used to open a project (Folder) in VSCode
function fj() {
    # Navigate to the project directory
    # p is an alias for cd $HOME/JDrive/Projects
    p

    selected_directory=$(fd --type d --exclude node_modules --exclude Lib | fzf --exit-0)

    if [[ -n $selected_directory ]]; then
        code "$selected_directory"
    fi
}

# This script is used to open a workspace (.code-workspace) in VSCode
function fw() {
    # Navigate to the project directory
    # p is an alias for cd $HOME/JDrive/Projects
    p

    # Find any .code-workspace files inside the project directory
    selected_workspace=$(fd --type f --extension code-workspace | fzf --exit-0)

    if [[ -n $selected_workspace ]]; then
        code "$selected_workspace"
    fi
}
