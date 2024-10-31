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
    backupFileExtension = "backu2p";
    extraSpecialArgs = {inherit inputs;};
    users.willsterjohnson = import ./home.nix;
  };
}
