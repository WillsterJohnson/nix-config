{
  inputs,
  pkgs,
  ...
}: {
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/extensions/catppuccin-mocha-mauve";
    source = builtins.fetchurl {
      url = "https://github.com/catppuccin/firefox/releases/download/old/catppuccin_mocha_mauve.xpi";
      sha256 = "1gkv12034d2dbbvr2fmxbqifmgmfv0lh58my1gmkcvfpxrap6ad5";
    };
  };
  programs.firefox = {
    enable = true;
    # https://mozilla.github.io/policy-templates/
    policies = {
    };
    # https://github.com/nix-community/home-manager/issues/5924
    profiles.default = {
      bookmarks = [
        {
          name = "Nix Config";
          toolbar = true;
          bookmarks = [
            {
              url = "https://github.com/WillsterJohnson/nix-config";
              name = "Nix Config";
              tags = ["nixos" "nix"];
            }
            {
              url = "https://search.nixos.org/packages?channel=unstable";
              name = "Nix Packages";
              tags = ["nixos" "nix" "packages"];
            }
            {
              url = "https://nix-community.github.io/home-manager/options.xhtml";
              name = "Home Manager Options";
              tags = ["nixos" "home-manager" "options"];
            }
          ];
        }
      ];
      containers = {
        default = {
          id = 0;
          name = "Default";
        };
      };
      containersForce = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        catppuccin-gh-file-explorer
        enhancer-for-youtube
        honey
        tree-style-tab
        ublock-origin
      ];
      id = 0;
      isDefault = true;
      name = "Default";
      path = "default";
    };
  };
}
