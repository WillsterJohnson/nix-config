{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    atool # work with various files
    alejandra # format nix code
    bazecor # proprietary keyboard layout editor
    deno # typescript runtime
    gitmoji-cli # better git commit
    gnome-tweaks # gnome tweaks
    nodejs_22 # required for 'zed-editor' due to temporary bug
    obsidian # note taking app
    rustup # rust toolchain
    shellcheck # required for shell script support in 'zed-editor'
    unzip # required for 'atool'
    zed-editor # text editor
  ];
  fonts.packages = with pkgs; [
    victor-mono
    (nerdfonts.override {fonts = ["Meslo"];})
  ];
}
