{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    autosuggestion.strategy = ["completion"];
    syntaxHighlighting.enable = true;
    shellAliases = {
      b = "bun";
      c = "clear";
      cat = "bat";
      nixup = "/etc/nixos/nixup";
      z = "zed";
    };
    initExtra = builtins.readFile ./zshrc;
  };
}
