{ lib
, stdenv
, fetchFromGitHub
, libX11
, libXft
, inih
, fontconfig
, pkg-config
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "rpbar";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "merrittlj";
    repo = "upgraded-rpbar";
    rev = "v1.0.0";
    sha256 = "sha256-eaKNbKr1hkZTKXhypEBYELuc/RTy/8xY8gvhdWQbwc4=";
  };
  #src = /home/lucas/programming/upgraded-rpbar/code.tar.gz;

  buildInputs = [
    libX11
    libXft
    inih
    fontconfig
    pkg-config
  ];

  strictDeps = true;

  installPhase = ''
    mkdir -p $out/bin
    cp rpbar $out/bin/rpbar
	cp rpbarsend $out/bin/rpbarsend
	chmod +x $out/bin/rpbar
	chmod +x $out/bin/rpbarsend
  '';
  
  meta = {
    homepage = "https://github.com/merrittlj/upgraded-rpbar";
    description = "upgraded rpbar";
    mainProgram = "rpbar";
    inherit (libX11.meta) platforms;
  };
})
