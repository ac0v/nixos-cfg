# When I'm stuck in the terminal and suffer all shiny editors I go for nano

{ config, options, lib, pkgs, ... }:

with lib;
with lib.my;
let cfg = config.modules.editors.clion;
in {
  options.modules.editors.clion = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [
      jetbrains.clion
    ];
  };
}
