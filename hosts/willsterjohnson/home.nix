{
  inputs,
  pkgs,
  lib,
  ...
}: let
  # https://github.com/nix-community/home-manager/issues/3447#issuecomment-2213029759
  autostartFile = builtins.listToAttrs (map
    (pkg: {
      name = ".config/autostart/${pkg.pname}.desktop";
      value =
        if pkg ? desktopItem
        then {text = pkg.desktopItem.text;}
        else {
          source = with builtins; let
            appsPath = "${pkg}/share/applications";
          in (
            if (pathExists "${appsPath}/${pkg.pname}.desktop")
            then "${appsPath}/${pkg.pname}.desktop"
            else throw "no desktop file for app ${pkg.pname}: ${pkg.pname} has no 'desktopItem' and no matching desktop file in ${appsPath}"
          );
        };
    })
    [
      # inputs.zen-browser.packages.x86_64-linux.default
    ]);
in {
  # https://nix-community.github.io/home-manager/options.xhtml
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
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
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
    git = {
      enable = true;
      aliases = {
        c = "commit -m";
        co = "checkout";
        chp = "cherry-pick";
        a = "add";
        undo-commit = "reset HEAD~";
        unstage = "reset HEAD --";
      };
      userName = "WillsterJohnson";
      userEmail = "willster@willsterjohnson.com";
      extraConfig = {
        init.defaultBranch = "trunk";
      };
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
    zed-editor = {
      enable = true;
      extensions = [
        "catppuccin"
        "catppuccin-icons"
        "csv"
        "emmet"
        "html"
        "nix"
        "rainbow-csv"
        "scheme"
        "scss"
        "svelte"
        "toml"
      ];
      userSettings = {
        autosave = {
          after_delay = {
            milliseconds = 500;
          };
        };
        restore_on_startup = "last_session";
        auto_update = false;
        base_keymap = "VSCode";
        buffer_font_family = "Victor Mono";
        buffer_font_features = {
          ss01 = false;
          ss02 = false;
          ss03 = false;
          ss04 = false;
          ss05 = true;
          ss06 = true;
        };
        format_on_save = "on";

        icon_theme = {
          mode = "system";
          dark = "Catppuccin Mocha";
          light = "Catppuccin Mocha";
        };
        languages = {
          JavaScript = {
            code_actions_on_format = {
              "source.organizeImports" = true;
            };
            formatter = {
              external = {
                command = "prettier";
                arguments = ["--stdin-filepath" "{buffer_path}"];
              };
            };
          };
          Svelte = {
            formatter = {
              external = {
                command = "prettier";
                arguments = ["--stdin-filepath" "{buffer_path}"];
              };
            };
          };
          TypeScript = {
            code_actions_on_format = {
              "source.organizeImports" = true;
            };
          };
        };
        preferred_line_length = 120;
        show_edit_predictions = true;
        show_whitespaces = "all";
        theme = "Base16 Catppuccin Mocha";
        wrap_guides = [100 120];
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      autosuggestion.strategy = ["completion"];
      envExtra = ''
        export PATH="/home/willsterjohnson/.deno/bin:$PATH"
      '';
      initExtra = builtins.readFile ./zshrc;
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
      ];
      shellAliases = {
        b = "bun";
        c = "clear";
        cat = "bat";
        ll = lib.mkForce "ls -lA --group-directories-first --git";
        nixup = "/etc/nixos/nixup";
        nixedit = "z /etc/nixos";
        plz = "sudo";
        z = "zeditor";
        list-firefox-addons = "nix flake show gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      };
      syntaxHighlighting.enable = true;
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
      autostartFile
      // {
        # files = {
        #   recursive = true;
        #   target = ".files";
        #   source = ./.files;
        # };
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
