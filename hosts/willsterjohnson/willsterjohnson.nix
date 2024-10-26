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
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };
  home-manager = {
    backupFileExtension = "backup2";
    extraSpecialArgs = {inherit inputs;};
    users.willsterjohnson = import ./home.nix;
  };
}
