#!/usr/bin/env bash
# Update flake inputs, build, show diff, then (s)witch / (k)eep / (r)evert.
set -euo pipefail

CONFIG_DIR=""
HOST=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      echo "Usage: nix-update [CONFIG_DIR]"
      echo "       nix-update --path PATH [--host HOST]"
      echo "  --path PATH   Config directory (default: \$HOME/nixos-config)"
      echo "  --host HOST   NixOS hostname (default: current hostname)"
      exit 0
      ;;
    --path)
      [[ $# -lt 2 ]] && { echo "Error: --path requires an argument"; exit 1; }
      CONFIG_DIR="$2"
      shift 2
      ;;
    --host)
      [[ $# -lt 2 ]] && { echo "Error: --host requires an argument"; exit 1; }
      HOST="$2"
      shift 2
      ;;
    *)
      CONFIG_DIR="$1"
      shift
      break
      ;;
  esac
done

CONFIG_DIR="${CONFIG_DIR:-$HOME/nixos-config}"
HOST="${HOST:-$(hostname)}"

if [[ ! -f "$CONFIG_DIR/flake.nix" ]]; then
  echo "Error: flake.nix not found in $CONFIG_DIR"
  exit 1
fi

cd "$CONFIG_DIR"
FLAKE_REF=".#$HOST"

# 1. Update the flake.lock
echo "Updating flake.lock..."
nix flake update

# 2. Build the new configuration (without switching)
echo "Building new system derivation..."
if ! nh os build . --hostname "$HOST" --out-link ./result; then
  echo "Error: Build failed! Reverting flake.lock..."
  [[ -d .git ]] && git checkout flake.lock
  exit 1
fi

# 3. Show the difference using nvd (strip fish-completions from version lists for readability)
echo ""
echo "Comparing changes:"
nix run nixpkgs#nvd -- --color always diff /run/current-system ./result \
  | sed -E 's/, [0-9][0-9._-]*[-_]fish-completions( x[0-9]+)?//g; s/  +/ /g'

# 4. Ask to Apply, Keep, or Revert
echo ""
read -p "Do you want to (s)witch to this update, (k)eep the lockfile but don't switch, or (r)evert everything? [s/k/r]: " choice

case "$choice" in
  s|S)
    echo "Applying updates..."
    nh os switch . --hostname "$HOST"
    rm -f ./result
    ;;
  k|K)
    echo "Lockfile updated. To apply later, run: nh os switch . --hostname $HOST"
    ;;
  r|R|*)
    echo "Reverting changes..."
    [[ -d .git ]] && git checkout flake.lock || echo "Warning: Not a git repository. Revert flake.lock manually if needed."
    rm -f ./result
    ;;
esac