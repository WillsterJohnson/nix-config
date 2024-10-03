{pkgs, ...}: {
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
