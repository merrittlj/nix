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
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "merrittlj";
    repo = "rpbar";
    rev = "v1.0.1";
    sha256 = "sha256-9IqjyOPH5F3DjAH6JWxGE/Nn6ScuyNZozn5h39VL2bE=";
  };

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
    homepage = "https://github.com/merrittlj/rpbar";
    description = "upgraded rpbar";
    mainProgram = "rpbar";
    inherit (libX11.meta) platforms;
  };
})
