{
  inputs,
  pkgs,
  ...
}: {
  # https://nix-community.github.io/home-manager/options.xhtml
  imports = [
    ./programs/bat.nix
    # ./programs/betterdiscord.nix
    ./programs/bun.nix
    ./programs/firefox.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/lsd.nix
    ./programs/oh-my-posh.nix
    ./programs/ssh.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };
  # gtk.cursorTheme = {
  #   package = pkgs.catppuccin-cursors.mochaLavender;
  #   name = "mochaLavender";
  # };
  home = {
    username = "willsterjohnson";
    homeDirectory = "/home/willsterjohnson";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nano";
    };
    file = {
      BetterDiscord_plugins = {
        recursive = true;
        target = ".files/BetterDiscord/plugins";
        source = ./programs/BetterDiscord/plugins;
      };
      BetterDiscord_themes = {
        recursive = true;
        target = ".files/BetterDiscord/themes";
        source = ./programs/BetterDiscord/themes;
      };
      homefiles = {
        recursive = true;
        target = ".homefiles";
        source = ./.homefiles;
      };
      fonts = {
        recursive = true;
        target = ".fonts";
        source = ./.fonts;
      };
    };
  };
  programs.home-manager.enable = true;
}
