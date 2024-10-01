alias __nix-shell__original=nix-shell

nix-shell() {
    __nix-shell__original "$@" --run zsh
}
