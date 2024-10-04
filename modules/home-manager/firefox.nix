{...}: {
  programs.firefox = {
    enable = true;
    enableGnomeExtensions = true;
    # https://mozilla.github.io/policy-templates/
    policies = {
    };
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
      extensions = [];
    };
  };
}
