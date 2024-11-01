{...}: {
  programs.zed-editor = {
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
      vertical_scroll_margin = 9;
      wrap_guides = [80 100 120];
    };
  };
}
