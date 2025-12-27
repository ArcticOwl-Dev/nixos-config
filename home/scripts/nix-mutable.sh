#!/usr/bin/env bash

# Check if a file path was provided
if [ -z "$1" ]; then
  echo "Usage: nix-mutable <path-to-config-file>"
  exit 1
fi

TARGET=$1

# Check if the file exists
if [ ! -e "$TARGET" ]; then
  echo "Error: File $TARGET does not exist."
  exit 1
fi

# Check if it's actually a symlink (Home-Manager uses symlinks)
if [ ! -L "$TARGET" ]; then
  echo "Note: $TARGET is not a symlink. It might already be mutable."
else
  echo "Converting Nix symlink to mutable file..."
  
  # Create a temporary copy of the content
  TMP_FILE=$(mktemp)
  cp --remove-destination "$(readlink -f "$TARGET")" "$TMP_FILE"
  
  # Remove the symlink and move the copy into its place
  rm "$TARGET"
  mv "$TMP_FILE" "$TARGET"
fi

# Set write permissions for the user
chmod +w "$TARGET"

echo "Success: $TARGET is now writable."
echo "To revert, run: home-manager switch"

