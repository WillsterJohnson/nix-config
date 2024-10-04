{...}: {
  programs.chromium = {
    enable = true;
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
    ];
    #   bookmarks = [
    #     {
    #       url = "https://github.com/WillsterJohnson/nix-config";
    #       name = "Nix Config";
    #       tags = ["nixos" "nix"];
    #     }
    #   ];
    # };
  };
}
