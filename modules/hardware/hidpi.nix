{ options, config, lib, home-manager, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.hardware.hidpi;
    configDir = config.dotfiles.configDir;
in {
  options.modules.hardware.hidpi = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name}.home.pointerCursor = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
      size = 96;
    };
  };
}
