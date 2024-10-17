final: prev: {
  stm32cubeprog = let
    pkgs = prev.callPackage ./stm32cubeprog/default.nix {};
  in
  {
    installerEnv = pkgs.installerEnv;
    progEnv = pkgs.progEnv;
  };
}
