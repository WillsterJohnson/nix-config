{pkgs, ...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  environment.systemPackages = with pkgs; [
    alejandra
    gitmoji-cli
    gnome-tweaks
    neofetch
    zed-editor
  ];
  fonts.packages = with pkgs; [
    victor-mono
    (nerdfonts.override {fonts = ["Meslo"];})
  ];
}
