{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    atool # work with various files
    alejandra # format nix code
    gitmoji-cli # better git commit
    gnome-tweaks # gnome tweaks
    nodejs_22 # required for zed-editor due to temporary bug
    shellcheck # required for shell script support in zed-editor
    zed-editor # text editor
  ];
  fonts.packages = with pkgs; [
    victor-mono
    (nerdfonts.override {fonts = ["Meslo"];})
  ];
}
