{ lib
, stdenv
, fetchFromGitHub
, cmake
, python3
, qt6
, curaengine
, plugins ? []
}:

stdenv.mkDerivation (finalAttrs: rec {
  pname = "cura";
  version = "5.8.1";

  src = fetchFromGitHub {
    owner = "Ultimaker";
    repo = "Cura";
    rev = version;
    sha256 = "sha256-gaUjTcdyvVj7mzbtO1jG+FBM5U6YsjtsYBvzWcJKqac=";
  };

  materials = fetchFromGitHub {
    owner = "Ultimaker";
    repo = "fdm_materials";
    rev = version;
    sha256 = "sha256-vY6T2MLJ6vDubwHyQh5wbUj/bdLR22dWGpqzmAGmqEk=";
  };

  buildInputs = [ qt6.qtbase ];
  propagatedBuildInputs = with python3.pkgs; [
    libsavitar numpy-stl pyserial requests uranium zeroconf pynest2d
    sentry-sdk trimesh keyring
    pyqt6
  ] ++ plugins;
  nativeBuildInputs = [ cmake python3.pkgs.wrapPython qt6.wrapQtAppsHook ];

  cmakeFlags = [
    "-DURANIUM_DIR=${python3.pkgs.uranium.src}"
    "-DCURA_VERSION=${version}"
  ];

  makeWrapperArgs = [
    # hacky workaround for https://github.com/NixOS/nixpkgs/issues/59901
    "--set OMP_NUM_THREADS 1"
  ];

  postPatch = ''
    sed -i 's,/python''${PYTHON_VERSION_MAJOR}/dist-packages,/python''${PYTHON_VERSION_MAJOR}.''${PYTHON_VERSION_MINOR}/site-packages,g' CMakeLists.txt
    sed -i 's, executable_name = .*, executable_name = "${curaengine}/bin/CuraEngine",' plugins/CuraEngineBackend/CuraEngineBackend.py
  '';

  postInstall = ''
    echo "---IDCURABIN--- $(ls .)"
    echo "---IDCURABIN--- $(ls ${src})"
    echo "---IDCURABIN--- $(ls ${src}/cura)"
    echo "---IDCURASEARCH--- $(find ${src} -perm -111 -type f)"
    mkdir -p $out/bin
    cp ${src}/cura_app.py $out/bin/cura
    mkdir -p $out/share/cura/resources/materials
    cp ${materials}/*.fdm_material $out/share/cura/resources/materials/
    mkdir -p $out/lib/cura/plugins
    for plugin in ${toString plugins}; do
      ln -s $plugin/lib/cura/plugins/* $out/lib/cura/plugins
    done
  '';

  postFixup = ''
    wrapPythonPrograms
    wrapQtApp $out/bin/cura
  '';

  meta = with lib; {
    description = "3D printer / slicing GUI built on top of the Uranium framework";
    mainProgram = "cura";
    homepage = "https://github.com/Ultimaker/Cura";
    license = licenses.lgpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ abbradar gebner ];
  };
})
