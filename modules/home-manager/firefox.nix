{
  inputs,
  pkgs,
  ...
}: {
  home.file."firefox-gnome-theme" = {
    target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
    source = fetchTarball {
      url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz";
      sha256 = "1qxxnmv3718hcp7f8k4wlwd9j7wwnzadrrvhlwmr0kbr8kyv9zwx";
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
      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";

        # For Firefox GNOME theme:
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.drawInTitlebar" = true;
        "svg.context-properties.content.enabled" = true;
      };
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
        @import "firefox-gnome-theme/theme/colors/dark.css";
      '';
    };
  };
}
