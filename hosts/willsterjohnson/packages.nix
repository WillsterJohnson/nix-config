{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    atool # work with various files
    alejandra # format nix code
    bazecor # proprietary keyboard layout editor
    betterdiscordctl # better discord controller
    catppuccin-cursors.mochaLavender # mouse cursor theme
    discord # dicord app
    deno # typescript runtime
    gitmoji-cli # better git commit
    gnome-boxes # virtual machine manager
    gnome-tweaks # gnome tweaks
    nixd # nix lsp support
    nodejs_22 # required for 'zed-editor' due to temporary bug
    obsidian # note taking app
    python310 # required for terminal extension in 'obsidian' (for some reason)
    rustup # rust toolchain
    shellcheck # required for shell script support in 'zed-editor'
    steam # steam
    xorg.xprop # required for 'gnomeExtensions.unite'
    unzip # required for 'atool'
    inputs.zen-browser.packages.x86_64-linux.specific # zen browser
  ];
  fonts.packages = with pkgs; [
    victor-mono
    (nerdfonts.override {fonts = ["Meslo"];})
  ];
}
