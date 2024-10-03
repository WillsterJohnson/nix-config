{
  pkgs,
  config,
  lib,
  ...
}: let
  nur-no-pkgs =
    import (builtins.fetchTarball {
      # Get the revision by choosing a version from https://github.com/nix-community/NUR/commits/master
      url = "https://github.com/nix-community/NUR/archive/47d63dcaa78c3b29d0fecc96f07a0103d7a94f1d.tar.gz";
      # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
      sha256 = "1prwiwhj6fjwwmrdg82yzmr0j84vi8z0w2h59brn838ggyq25lfv";
    }) {
    };
in {
  nixpkgs.config.packageOverrides = pkgs: {
    nur =
      import (builtins.fetchTarball {
        # Get the revision by choosing a version from https://github.com/nix-community/NUR/commits/master
        url = "https://github.com/nix-community/NUR/archive/47d63dcaa78c3b29d0fecc96f07a0103d7a94f1d.tar.gz";
        # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
        sha256 = "1prwiwhj6fjwwmrdg82yzmr0j84vi8z0w2h59brn838ggyq25lfv";
      }) {
        inherit pkgs;
      };
  };
  # https://nix-community.github.io/home-manager/options.xhtml
  imports = [
    ../../modules/home-manager/bat.nix
    ../../modules/home-manager/bun.nix
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

  home = {
    username = "willsterjohnson";
    homeDirectory = "/home/willsterjohnson";
    stateVersion = "24.11";

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
