{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./packages.nix
  ];
  nixpkgs.config.packageOverrides = pkgs: {
    nur =
      import (builtins.fetchTarball {
        # Get the revision by choosing a version from https://github.com/nix-community/NUR/commits/master
        url = "https://github.com/nix-community/NUR/archive/47d63dcaa78c3b29d0fecc96f07a0103d7a94f1d.tar.gz";
        # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
        sha256 = "1prwiwhj6fjwwmrdg82yzmr0j84vi8z0w2h59brn838ggyq25lfv";
      }) {
        inherit pkgs;
      };
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.willsterjohnson = {
    isNormalUser = true;
    description = "Willster Johnson";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users.willsterjohnson = import ./home.nix;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  console.keyMap = "uk";
  hardware.pulseaudio.enable = false;
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;
  services.gnome.gnome-browser-connector.enable = true;
  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  security.rtkit.enable = true;
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  services.openssh.enable = true;
  system.stateVersion = "24.05";
  time.timeZone = "Europe/London";
}
