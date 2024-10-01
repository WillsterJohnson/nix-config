{...}: {
  programs.git = {
    enable = true;
    aliases = {
      c = "commit -m";
      co = "checkout";
      chp = "cherry-pick";
      a = "add";
      undo-commit = "reset HEAD~";
      unstage = "reset HEAD --";
    };
    userName = "WillsterJohnson";
    userEmail = "willster@willsterjohnson.com";
    extraConfig = {
      init.defaultBranch = "trunk";
    };
  };
}
