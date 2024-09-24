{
  config,
  pkgs,
  ...
}: {
  home.username = "willsterjohnson";
  home.homeDirectory = "/home/willsterjohnson";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = "zed";
  };

  home.file = {
    ".homefiles" = {
      recursive = true;
      source = ./.homefiles;
    };
  };

  programs.zsh.enable = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.autosuggestion.strategy = ["completion"];
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.shellAliases = {
    b = "bun";
    c = "clear";
    cat = "bat";
    z = "zed";
    pd = "if [ -z $1 ]; then popd; else pushd $1; fi";
    nixup = "/etc/nixos/nixup";
  };
  programs.zsh.initExtra = ''
    eval "$(zoxide init zsh --cmd cd)"
    source ~/.homefiles/imports
  '';

  programs.oh-my-posh.enable = true;
  programs.oh-my-posh.enableZshIntegration = true;
  programs.oh-my-posh.useTheme = "catppuccin_mocha";

  programs.home-manager.enable = true;

  programs.git.enable = true;
  programs.git.aliases = {
    c = "commit -m";
    co = "checkout";
    chp = "cherry-pick";
    a = "add";
    undo-commit = "reset HEAD~";
    unstage = "reset HEAD --";
  };
  programs.git.userName = "WillsterJohnson";
  programs.git.userEmail = "willster@willsterjohnson.com";
  programs.git.extraConfig = {
    init.defaultBranch = "trunk";
  };
}
