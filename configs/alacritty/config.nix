{ pkgs, prog }:
(prog {
  inherit pkgs;
  settings = {
    font.size = 20;
  };
})
