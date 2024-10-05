{
  inputs,
  lib,
  ...
}: {
  # https://nix-community.github.io/home-manager/options.xhtml
  imports = [
    ../../modules/home-manager/bat.nix
    ../../modules/home-manager/bun.nix
    ../../modules/home-manager/chromium.nix
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/fzf.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/lsd.nix
    ../../modules/home-manager/oh-my-posh.nix
    ../../modules/home-manager/ssh.nix
    ../../modules/home-manager/thefuck.nix
    ../../modules/home-manager/zoxide.nix
    ../../modules/home-manager/zsh.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "willsterjohnson";
    homeDirectory = "/home/willsterjohnson";
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "nano";
    };

    file = {
      ".homefiles" = {
        recursive = true;
        source = ./.homefiles;
      };
    };
  };
  programs.home-manager.enable = true;
}
