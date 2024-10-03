{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    # enableGnomeExtensions = true;
    # policies = {};
    # profiles.default = {
    # bookmarks = [
    #   {
    #     url = "https://github.com/WillsterJohnson/nix-config";
    #     name = "Nix Config";
    #     tags = ["nixos" "nix"];
    #   }
    # ];
    # containers = {
    #   # example = {
    #   #   color = "blue"; # “blue”, “turquoise”, “green”, “yellow”, “orange”, “red”, “pink”, “purple”, “toolbar”
    #   #   icon = "fruit"; # “briefcase”, “cart”, “circle”, “dollar”, “fence”, “fingerprint”, “gift”, “vacation”, “food”, “fruit”, “pet”, “tree”, “chill”
    #   #   id = 1;
    #   #   name = "Example";
    #   # };
    # };
    # containersForce = true;
    # extensions = [];
    #   id = 0;
    #   name = "default";
    #   isDefault = true;
    # };
  };
}
