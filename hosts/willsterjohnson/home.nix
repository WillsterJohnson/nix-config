{
  inputs,
  pkgs,
  ...
}: let
  autostartFile = builtins.listToAttrs (map
    (pkg: {
      name = ".config/autostart/" + pkg.pname + ".desktop";
      value =
        if pkg ? desktopItem
        then {text = pkg.desktopItem.text;}
        else {
          source = with builtins; let
            appsPath = "${pkg}/share/applications";
            filterFiles = dirContents: lib.attrsets.filterAttrs (_: fileType: elem fileType ["regular" "symlink"]) dirContents;
          in (
            if (pathExists "${appsPath}/${pkg.pname}.desktop")
            then "${appsPath}/${pkg.pname}.desktop"
            else
              (
                if pathExists "${appsPath}"
                then "${appsPath}/${head (attrNames (filterFiles (readDir "${appsPath}")))}"
                else throw "no desktop file for app ${pkg.pname}"
              )
          );
        };
    })
    [
      inputs.zen-browser.packages.x86_64-linux.specific
      pkgs.discord
      pkgs.xterm
    ]);
in {
  # https://nix-community.github.io/home-manager/options.xhtml
  imports = [
    ./programs/git.nix
    ./programs/zed-editor.nix
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
    gnome-shell = {
      enable = true;
      extensions = [
        {package = pkgs.gnomeExtensions.undecorate;}
      ];
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
    file =
      {
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
      }
      // autostartFile;
  };
  programs.home-manager.enable = true;
}
