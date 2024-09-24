{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    bat
    bun
    fzf
    gitmoji-cli
    gnome-tweaks
    google-chrome
    neofetch
    nodejs_22
    rustc
    zed-editor
    zoxide
  ];
  fonts.packages = with pkgs; [
    victor-mono
    (nerdfonts.override {fonts = ["Meslo"];})
  ];
}
