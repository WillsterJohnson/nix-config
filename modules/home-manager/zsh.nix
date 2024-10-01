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
      pd = "if [ -z $1 ]; then popd; else pushd $1; fi";
      z = "zed";
    };
    initExtra = builtins.readFile ./zshrc;
  };
}
