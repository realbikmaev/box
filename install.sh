#!/usr/bin/env bash
set -euo pipefail

# detect os
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="darwin"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    echo "unsupported os: $OSTYPE"
    exit 1
fi

# colors
GREEN='\033[0;32m'
NC='\033[0m'

log() {
    echo -e "${GREEN}==>${NC} $1"
}

# install nix if needed (only this needs sudo)
if ! command -v nix &>/dev/null; then
    log "installing nix (needs sudo)..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sudo sh -s -- install
    # reload shell
    if [[ "$OS" == "darwin" ]]; then
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    else
        source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
    fi
fi

# enable flakes
if [[ ! -f ~/.config/nix/nix.conf ]]; then
    log "enabling flakes..."
    mkdir -p ~/.config/nix
    echo "experimental-features = nix-command flakes" >>~/.config/nix/nix.conf
fi

# clone or update repo
REPO_PATH="$HOME/.config/nixpkgs"
if [[ ! -d "$REPO_PATH" ]]; then
    log "cloning box..."
    git clone https://github.com/bikmaev/box.git "$REPO_PATH"
else
    log "updating box..."
    cd "$REPO_PATH"
    git pull
fi

cd "$REPO_PATH"

# apply config
if [[ "$OS" == "darwin" ]]; then
    log "applying darwin config..."
    # first run installs nix-darwin
    darwin-rebuild switch --flake .#bikmaev-mac || nix run nix-darwin -- switch --flake .#bikmaev-mac
else
    log "setting up ubuntu with nix..."
    # just install packages via home-manager standalone
    export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
    nix run home-manager/master -- switch --flake .#bikmaev-linux
fi

log "done! ${GREEN}restart your shell to apply changes${NC}"
