{
  inputs,
  pkgs,
  ...
}: {
  # https://nix-community.github.io/home-manager/options.xhtml
  imports = [
    ./programs/home-manager/bat.nix
    ./programs/home-manager/bun.nix
    ./programs/home-manager/firefox.nix
    ./programs/home-manager/fzf.nix
    ./programs/home-manager/git.nix
    ./programs/home-manager/lsd.nix
    ./programs/home-manager/oh-my-posh.nix
    ./programs/home-manager/ssh.nix
    ./programs/home-manager/zoxide.nix
    ./programs/home-manager/zsh.nix
  ];
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };
  gtk.cursorTheme = {
    package = pkgs.catppuccin-cursors.mochaLavender;
  };
  home = {
    username = "willsterjohnson";
    homeDirectory = "/home/willsterjohnson";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nano";
    };
    file = {
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
