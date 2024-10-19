{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    autosuggestion.strategy = ["completion"];
    initExtra =
      builtins.readFile ./zshrc
      + ''
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
      '';
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
      c = "clear ; echo \"$(echo $prompt | sed 's/%{//g; s/%}//g')\" ; ll";
      cat = "bat";
      ll = lib.mkForce "ls -lA --group-directories-first --git";
      nixup = "/etc/nixos/nixup";
      nixedit = "z /etc/nixos";
      z = "zed";
    };
    syntaxHighlighting.enable = true;
  };
}
