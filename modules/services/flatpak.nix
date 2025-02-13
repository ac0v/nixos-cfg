{ options, config, lib, ... }:

with lib;
with lib.my;
let cfg = config.modules.services.flatpak;
in {
  options.modules.services.flatpak = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
