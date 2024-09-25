{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options = {
    environment.binbash = mkOption {
      default = null;
      type = types.nullOr types.path;
      description = ''
        Include a /bin/zsh in the system.
      '';
    };
  };
  config = {
    system.activationScripts.binbash =
      if config.environment.binbash != null
      then ''
        mkdir -m 0755 -p /bin
        ln -sfn ${config.environment.usrbinenv} /bin/.zsh.tmp
        mv /bin/.zsh.tmp /usr/bin/zsh # atomically replace /usr/bin/env
      ''
      else ''
        rm -f /bin/zsh
        rmdir -p /bin || true
      '';
  };
}
