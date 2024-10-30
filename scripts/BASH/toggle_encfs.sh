#!/bin/bash

function enc() {
  MOUNT_POINT="/home/jd/JDrive/hmmd"
  ENCRYPTED_DIR="/home/jd/JDrive/hmm"

  # Ensure encfs and fusermount are installed
  if ! command -v encfs &>/dev/null; then
    echo "Error: encfs is not installed. Please install it to proceed."
    return 1
  fi

  if ! command -v fusermount &>/dev/null; then
    echo "Error: fusermount is not installed. Please install it to proceed."
    return 1
  fi

  # Check if MOUNT_POINT exists
  if [[ ! -d "$MOUNT_POINT" ]]; then
    echo "Error: Mount point directory '$MOUNT_POINT' does not exist. Please create it first."
    return 1
  fi

  # Check if ENCRYPTED_DIR exists
  if [[ ! -d "$ENCRYPTED_DIR" ]]; then
    echo "Error: Encrypted directory '$ENCRYPTED_DIR' does not exist."
    return 1
  fi

  if mountpoint -q "$MOUNT_POINT"; then
    echo "Unmounting 🚀"
    if fusermount -u "$MOUNT_POINT"; then
      echo "Unmounted 😁"
    else
      echo "Error: Failed to unmount '$MOUNT_POINT'."
      return 1
    fi
  else
    # Check if the MOUNT_POINT is empty before mounting
    if [ "$(ls -A "$MOUNT_POINT")" ]; then
      rm -rf "$MOUNT_POINT/tes" # Clean the mount point
      echo "Cleaned"
    fi

    echo "Mounting ✍️"
    if encfs "$ENCRYPTED_DIR" "$MOUNT_POINT"; then
      echo "Mounted 📃"
    else
      echo "Error: Failed to mount"
      return 1
    fi
  fi
}
