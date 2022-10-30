{ config, options, lib, pkgs, my, ... }:

with lib;
with lib.my;
let devCfg = config.modules.dev;
    cfg = devCfg.jdk;
in {
  options.modules.dev.jdk = {
    enable = mkBoolOpt false;
    xdg.enable = mkBoolOpt devCfg.xdg.enable;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [
        jdk8
      ];
    })

    (mkIf cfg.xdg.enable {
      # TODO
    })
  ];
}
