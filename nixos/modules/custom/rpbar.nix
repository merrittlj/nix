{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.rpbar;
in
{
  ###### interface
  options = {
    programs.rpbar = {
      enable = mkEnableOption "rpbar";
	};
  };

  ###### implementation
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.rpbar ];
  };
}
