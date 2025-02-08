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
    corepack_22 # pnpm support
    deno # typescript runtime
    eclipses.eclipse-java # eclipse ide - the worst ide ever (but it supports old java so...)
    gcc # required for rust toolchain
    gitmoji-cli # better git commit
    gnome-tweaks # gnome tweaks
    inotify-tools # fs watch and more
    jdk21 # jdk 21
    jetbrains.idea-ultimate # intellij idea community edition
    nixd # nix lsp support
    nodejs_22 # required for 'zed-editor' due to temporary bug
    obsidian # note taking app
    pkg-config # pkg-config
    prismlauncher # Prism launcher for Minecraft
    protontricks # protontricks
    python310 # required for terminal extension in 'obsidian' (for some reason)
    rustup # rust toolchain
    shellcheck # required for shell script support in 'zed-editor'
    xorg.xprop # required for 'gnomeExtensions.unite'
    unzip # required for 'atool'
    inputs.zen-browser.packages.x86_64-linux.specific # zen browser
  ];
  environment.variables = {
    FOO = "beans";
    JAVA_HOME = "${pkgs.jdk21}/lib/openjdk";
  };
  fonts.packages = with pkgs; [
    victor-mono
    (nerdfonts.override {fonts = ["Meslo"];})
  ];
}
