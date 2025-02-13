{ options, config, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.apps.remotedesktopmanager;
in
{
  options.modules.desktop.apps.remotedesktopmanager = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.gnome.at-spi2-core.enable = true;
    user.packages = with pkgs; [
      my.remotedesktopmanager
    ];
  };
}
