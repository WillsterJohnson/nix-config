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
    corepack_22 # pnpm support
    discord # dicord app
    deno # typescript runtime
    eclipses.eclipse-java # eclipse ide - the worst ide ever (but it supports old java so...)
    gcc # required for rust toolchain
    gitmoji-cli # better git commit
    gnome-tweaks # gnome tweaks
    inotify-tools # fs watch and more
    jetbrains.idea-community # intellij idea community edition
    jdk21 # jdk21
    nixd # nix lsp support
    nodejs_22 # required for 'zed-editor' due to temporary bug
    obsidian # note taking app
    pkg-config # pkg-config
    protontricks # protontricks
    python310 # required for terminal extension in 'obsidian' (for some reason)
    rustup # rust toolchain
    shellcheck # required for shell script support in 'zed-editor'
    xorg.xprop # required for 'gnomeExtensions.unite'
    unzip # required for 'atool'
    # zulu8 # zulu8
    # zulu17 # zulu17
    inputs.zen-browser.packages.x86_64-linux.specific # zen browser

    # (pkgs.callPackage ../../pkgs/minecraft/default.nix {})
    prismlauncher
  ];
  environment.variables = {
    # JAVA_HOME_JDK17 = "${pkgs.zulu17}";
    # JAVA_HOME_JDK8 = "${pkgs.zulu8}";
  };
  fonts.packages = with pkgs; [
    victor-mono
    (nerdfonts.override {fonts = ["Meslo"];})
  ];
}
