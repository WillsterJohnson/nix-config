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

  home.shellAliases = {
    b = "bun";
    c = "clear";
    cat = "bat";
    z = "zed";
    pd = "if [ -z $1 ]; then popd; else pushd $1; fi";
  };

  programs.bash.enable = true;
  programs.bash.bashrcExtra = ''
    eval "$(zoxide init bash --cmd cd)"
  '';

  programs.home-manager.enable = true;

  programs.git.enable = true;
  programs.git.aliases = {
    c = "commit -m";
    co = "checkout";
    chp = "cherry-pick";
    a = "add";
    undo-commit = "reset HEAD~";
  };
  programs.git.userName = "WillsterJohnson";
  programs.git.userEmail = "willster@willsterjohnson.com";
  programs.git.extraConfig = {
    init.defaultBranch = "trunk";
  };
}
