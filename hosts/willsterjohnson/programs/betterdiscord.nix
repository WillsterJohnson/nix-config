{...}: {
  home.file = {
    BetterDiscord_plugins = {
      recursive = true;
      target = ".config/BetterDiscord/plugins/";
      source = ./BetterDiscord/plugins;
    };
    BetterDiscord_themes = {
      recursive = true;
      target = ".config/BetterDiscord/themes/";
      source = ./BetterDiscord/themes;
    };
  };
}
