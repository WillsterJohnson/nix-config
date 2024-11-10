{
  pkgs,
  inputs,
  ...
}: {
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.willsterjohnson = {
    isNormalUser = true;
    description = "Willster Johnson";
    extraGroups = ["networkmanager" "wheel" "dialout"];
  };
  home-manager = {
    backupFileExtension = "backup"; # this needs to be changed occasionally I don't understand why
    extraSpecialArgs = {inherit inputs;};
    users.willsterjohnson = import ./home.nix;
  };
}
