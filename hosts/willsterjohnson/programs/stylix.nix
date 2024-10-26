{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    image = ./stylix.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    cursor = {
      name = "Catppuccin Mocha";
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
}
