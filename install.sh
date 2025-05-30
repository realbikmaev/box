#!/usr/bin/env bash
set -euo pipefail

REPO_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> checking prerequisites..."
if ! command -v nix &>/dev/null; then
    echo "==> installing nix..."
    curl -L https://nixos.org/nix/install | sh -s -- --daemon
fi

if [ "$(uname)" == "Darwin" ]; then
    if ! command -v darwin-rebuild &>/dev/null; then
        echo "==> installing nix-darwin..."
        nix run nix-darwin -- switch --flake "$REPO_PATH#bikmaev-mac"
    fi
    echo "==> applying darwin config..."
    darwin-rebuild switch --flake "$REPO_PATH#bikmaev-mac"
else
    echo "==> setting up ubuntu with nix..."
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
fi

echo "==> installing home-manager..."
nix run home-manager -- switch --flake "$REPO_PATH"
