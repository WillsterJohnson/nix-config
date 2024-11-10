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
      inputs.zen-browser.packages.x86_64-linux.specific
      pkgs.discord
      pkgs.xterm
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
        "csv"
        "deno"
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
        assistant = {
          default_model = {
            provider = "copilot_chat";
            model = "gpt-4o";
          };
          version = "2";
        };
        autosave = "on_focus_change";
        buffer_font_family = "Victor Mono";
        buffer_font_size = 16;
        buffer_font_weight = 500;
        code_actions_on_format = {
          "source.organizeImports" = true;
        };
        copy_on_select = true;
        current_line_highlight = "gutter";
        experimental.theme_overrides = {
          syntax = {
            # https://gist.github.com/WillsterJohnson/13d6e60f59842188cd756c839a93acd0
            # https://github.com/catppuccin/zed/blob/main/zed.tera
            constant = {
              color = "#F38BA8";
            };
          };
        };
        formatter = "language_server";
        file_scan_exclusions = [
          "**/.git"
          "**/.svn"
          "**/.hg"
          "**/CVS"
          "**/.DS_Store"
          "**/Thumbs.db"
          "**/.classpath"
          "**/.settings"
          "**/node_modules"
          "**/.turbo"
        ];
        format_on_save = "on";
        hard_tabs = true;
        inlay_hints = {
          enabled = true;
          show_type_hints = false;
          show_parameter_hints = false;
          show_other_hints = false;
        };
        languages = {
          TypeScript = {
            language_servers = ["deno" "!typescript-language-server" "!vtsls" "!eslint"];
          };
          TSX = {
            language_servers = ["deno" "!typescript-language-server" "!vtsls" "!eslint"];
          };
        };
        lsp = {
          deno = {
            settings = {
              deno = {
                enable = true;
              };
            };
          };
        };
        preferred_line_length = 120;
        show_whitespaces = "boundary";
        tab_size = 4;
        tabs = {
          git_status = true;
        };
        terminal = {
          shell = {
            program = "zsh";
          };
        };
        theme = {
          mode = "system";
          light = "One Light";
          dark = "Catppuccin Mocha";
        };
        ui_font_size = 16;
        ui_font_family = "Victor Mono";
        ui_font_weight = 500;
        vertical_scroll_margin = 100;
        wrap_guides = [80 100 120];
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
        export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib"
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
