{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./willsterjohnson.nix
  ];
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
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
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
  };
  services.fwupd.enable = true;
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
  # todo: cursors don't work correctly - on rebuild the cursor icons are not set correctly
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./desktop.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      name = "Catppuccin-mocha-lavender";
      package = pkgs.catppuccin-cursors.mochaLavender;
      size = 36;
    };
    fonts = {
      monospace = {
        package = with pkgs; (nerdfonts.override {fonts = ["Meslo"];});
        name = "Meslo Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sizes = {
        applications = 11;
        terminal = 12;
        desktop = 11;
        popups = 11;
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 1.0;
    };
    polarity = "dark";
    targets = {
      grub.enable = false;
      gnome.enable = false;
      gtk.enable = true;
      nixos-icons.enable = true;
    };
  };
  system.stateVersion = "24.05";
  time.timeZone = "Europe/London";
}
