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
    # davinci-resolve # davinci resolve video editor
    deno # typescript runtime
    droidcam # phone as webcam
    gcc # required for rust toolchain
    gitmoji-cli # better git commit
    gnome-tweaks # gnome tweaks
    inotify-tools # fs watch and more
    jdk21 # jdk 21
    jetbrains-toolbox # jetbrains toolbox
    libzip # libzip
    nixd # nix lsp support
    nodejs_22 # node
    (pkgs.wrapOBS {
      # screen recording & streaming
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        droidcam-obs
      ];
    })
    obsidian # note taking app
    pkg-config # pkg-config
    prismlauncher # Prism launcher for Minecraft
    protontricks # protontricks
    python310 # required for terminal extension in 'obsidian' (for some reason)
    rustup # rust toolchain
    shellcheck # required for shell script support in 'zed-editor'
    stdenv.cc.cc.lib # libstdc++
    xorg.xprop # required for 'gnomeExtensions.unite'
    unzip # required for 'atool'
    inputs.zen-browser.packages.x86_64-linux.default # zen browser
  ];
  environment.variables = {
    JAVA_HOME = "${pkgs.jdk21}/lib/openjdk";
  };
  fonts.packages = with pkgs; [
    victor-mono
  ];
}
