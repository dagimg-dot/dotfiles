function fj -d "open a project in vs code"
    p
    set selected_directory (fd --type d --exclude node_modules --exclude Lib | fzf --exit-0)
    if test -n "$selected_directory"
        code "$selected_directory"
    end
end

function cursor
    nohup /home/jd/AppImages/cursor.appimage $argv >/dev/null 2>&1 &
end

function fk
    set dir (fd --type d --exclude node_modules --exclude Lib | fzf --no-multi)
    if test -n "$dir"
        cd "$dir"
    end
end

function fw -d "open workspace in vscode"
    p
    set selected_workspace (fd --type f --extension code-workspace | fzf --exit-0)
    if test -n "$selected_workspace"
        code "$selected_workspace"
    end
end

function dent -d "login to a running docker container"
    set container (docker ps --format "table {{.ID}}\t{{.Names}}" | fzf --header="Select a running container")
    if test -n "$container"
        set container_id (echo $container | awk '{print $1}')
        docker exec -it "$container_id" bash
    else
        echo "No container selected."
    end
end

function pas -d "show password for saved wifi"
    # Select a WiFi connection using fzf
    set selected_wifi (nmcli connection show | grep wifi | fzf --prompt="Select WiFi: ")

    # Check if a WiFi is selected
    if test -z "$selected_wifi"
        echo "No WiFi selected."
        return 1
    end

    # Reverse the selected line
    set rev_line (echo $selected_wifi | awk '{ for (i=NF; i>0; i--) printf "%s ", $i; print "" }')

    # Extract the WiFi name from the reversed line
    set rev_wifi_name (echo $rev_line | awk -F' ' '{for (i=4; i<=NF; i++) printf "%s ", $i; print ""}')

    # Reverse again to get the correct order of the WiFi name
    set wifi_name (echo $rev_wifi_name | awk '{ for (i=NF; i>0; i--) printf "%s ", $i; print "" }')

    # Trim leading and trailing spaces
    set wifi_name (string trim $wifi_name)

    # Display the password for the selected WiFi
    sudo nmcli connection show "$wifi_name" -s | grep psk
end

function enc -d "encrypt and decrypt journal"
    set MOUNT_POINT /home/jd/JDrive/hmmd
    set ENCRYPTED_DIR /home/jd/JDrive/hmm

    # Ensure encfs and fusermount are installed
    if not command -v encfs &>/dev/null
        echo "Error: encfs is not installed. Please install it to proceed."
        return 1
    end

    if not command -v fusermount &>/dev/null
        echo "Error: fusermount is not installed. Please install it to proceed."
        return 1
    end

    # Check if MOUNT_POINT exists
    if not test -d "$MOUNT_POINT"
        echo "Error: Mount point directory '$MOUNT_POINT' does not exist. Please create it first."
        return 1
    end

    # Check if ENCRYPTED_DIR exists
    if not test -d "$ENCRYPTED_DIR"
        echo "Error: Encrypted directory '$ENCRYPTED_DIR' does not exist."
        return 1
    end

    if mountpoint -q "$MOUNT_POINT"
        echo "Unmounting 🚀"
        if fusermount -u "$MOUNT_POINT"
            echo "Unmounted 😁"
        else
            echo "Error: Failed to unmount '$MOUNT_POINT'."
            return 1
        end
    else
        # Check if the MOUNT_POINT is empty before mounting
        if test -n (ls -A "$MOUNT_POINT")
            rm -rf "$MOUNT_POINT/tes" # Clean the mount point
            echo Cleaned
        end

        echo "Mounting ✍️"
        if encfs "$ENCRYPTED_DIR" "$MOUNT_POINT"
            echo "Mounted 📃"
        else
            echo "Error: Failed to mount"
            return 1
        end
    end
end

function open -d "open a directory in nautilus"
    nohup nautilus -w "$argv" >/dev/null 2>&1 & disown
end

function cop --description "Run a command, pick an item with fzf, and copy it to the clipboard"
    # Check if a command was provided
    if test (count $argv) -eq 0
        echo "Usage: cop '<command>'"
        return 1
    end

    # Execute the command and pipe its output to fzf
    set selected_item (eval $argv | fzf)

    # If an item was selected, copy it to the clipboard
    if test -n "$selected_item"
        if type -q wl-copy
            echo -n $selected_item | wl-copy
        else
            echo "No clipboard utility found (wl-copy)."
            return 1
        end
        echo "Copied to clipboard: $selected_item"
    else
        echo "No selection made."
    end
end
