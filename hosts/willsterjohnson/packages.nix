{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    atool # work with various files
    alejandra # format nix code
    bazecor # proprietary keyboard layout editor
    catppuccin-cursors.mochaLavender # mouse cursor theme
    deno # typescript runtime
    gitmoji-cli # better git commit
    gnome-tweaks # gnome tweaks
    kitty # terminal emulator
    libnotify # required for 'mako'
    mako # notification daemon
    nixd # nix lsp support
    nodejs_22 # required for 'zed-editor' due to temporary bug
    obsidian # note taking app
    rofi-wayland # application launcher
    rustup # rust toolchain
    shellcheck # required for shell script support in 'zed-editor'
    # swww # wallpaper manager
    unzip # required for 'atool'
    waybar # status bar
    zed-editor # text editor
    inputs.zen-browser.packages.x86_64-linux.specific # zen browser
  ];
  fonts.packages = with pkgs; [
    victor-mono
    (nerdfonts.override {fonts = ["Meslo"];})
  ];
}
