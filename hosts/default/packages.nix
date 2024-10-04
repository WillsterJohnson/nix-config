{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alejandra
    gitmoji-cli
    gnome-tweaks
    neofetch
    nodejs_22
    unzip
    zed-editor
  ];
  fonts.packages = with pkgs; [
    victor-mono
    (nerdfonts.override {fonts = ["Meslo"];})
  ];
}
