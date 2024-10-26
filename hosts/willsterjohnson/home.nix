{inputs, ...}: {
  # https://nix-community.github.io/home-manager/options.xhtml
  imports = [
    ./programs/firefox.nix
    ./programs/git.nix
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

  programs = {
    bat.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    lsd = {
      enable = true;
      enableAliases = true;
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      useTheme = "catppuccin_mocha";
    };
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
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
      files = {
        recursive = true;
        target = ".files";
        source = ./.files;
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
