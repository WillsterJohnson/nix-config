{
  config,
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    bat
    bun
    fzf
    gitmoji-cli
    gnome-tweaks
    nodejs_22
    rustc
    zed-editor
    zoxide
  ];
}
