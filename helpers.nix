{ lib }:
{
  bundleFiles = 
    path:
    if builtins.pathExists path then 
      let
        files = lib.filterAttrs 
          (name: type: lib.hasSuffix ".nix" name && type == "regular") 
          (builtins.readDir path);
      in
        map (name: path + "/${name}") (builtins.attrNames files)
    else [];
}
