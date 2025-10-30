# unlike wrappers/modules.nix, this is for the module configs
{ pkgs, mods }:
pkgs.lib.mapAttrs' (
  name: type: pkgs.lib.nameValuePair name (import ./configs/${name}/config.nix { inherit pkgs; prog = mods.${name}.apply; }).wrapper
) (pkgs.lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./configs))
