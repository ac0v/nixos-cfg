{ options, config, lib, home-manager, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.flameshot;
in {
  options.modules.services.flameshot = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name}.services.flameshot = {
      enable = true;
      settings = {
        General = {
          savePath = "/home/${config.user.name}/";
          saveAsFileExtension = ".png";
          uiColor = "#92b6d6";
          showHelp = "false";
#          disabledTrayIcon = "true";
        };
      };
    };
  };
}
