{...}: {
  programs.firefox = {
    enable = true;
    profiles = {
      aies = {};
    };
    # profiles.lorem = {
    #   bookmarks = [
    #     {
    #       url = "https://github.com/WillsterJohnson/nix-config";
    #       name = "Nix Config";
    #       tags = ["nixos" "nix"];
    #     }
    #   ];
    #   extensions = [];
    # };
  };
}
