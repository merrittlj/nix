{ lib
, stdenvNoCC
, buildFHSEnv
, fetchzip
, jdk17
, dejavu_fonts
, libXext
, libX11
, libXrender
, libXtst
, libXi
}:

let
  package = stdenvNoCC.mkDerivation (finalAttrs: rec {
    pname = "stm32cubeprog";
    version = "2.17.0";

    src = fetchzip {
      url = "https://www.dropbox.com/scl/fi/cpz096lsdwjd5i0vk8msc/stm32cubeprog-2-17-0.zip?rlkey=zx4bkyoa7ukbeq9wudivhfrbz&st=j1pnhlv6&dl=1";
      sha256 = "sha256-krvECbtNGs01Zjdx6PqddmfnVZg1pM6upaMc2rwa0EQ=";
      extension = "zip";
      stripRoot = false;
    };

    buildCommand = ''
      mkdir -p $out/{bin,opt}

      cp -r $src/jre/ $out/opt
      cp $src/SetupSTM32CubeProgrammer-${version}.linux $out/opt
      cp $src/SetupSTM32CubeProgrammer-${version}.exe $out/opt
      ln -s /cube $out/prog

      cat << EOF > $out/bin/${pname}_installer
      #!${stdenvNoCC.shell}
      $out/opt/SetupSTM32CubeProgrammer-${version}.linux
      EOF
      chmod +x $out/bin/${pname}_installer

      cat << EOF > $out/bin/${package.pname}_run
      #!${stdenvNoCC.shell}
      export LD_LIBRARY_PATH="$out/prog/lib:$LD_LIBRARY_PATH"

      SO_FILES=$(find "$out/prog/lib" -name "*.so" | tr '\n' ' ')
      echo $SO_FILES
      export LD_PRELOAD="$SO_FILES"

      cd $out/prog/bin || exit 1 # Necessary for file path resolution(mainly for STLinkUpgrade.jar)
      ./jre/bin/java -Djdk.gtk.version=2 -jar ./STM32CubeProgrammerLauncher
      EOF
      chmod +x $out/bin/${package.pname}_run
    '';

    meta = {
      homepage = "https://www.st.com/en/development-tools/stm32cubeprog.html";
      description = "STM32CubeProgrammer software";
    };
   });
in
{
installerEnv = buildFHSEnv {
  pname = "${package.pname}_installer";
  inherit (package) version meta;
  runScript = "${package.outPath}/bin/${package.pname}_installer";

  targetPkgs = pkgs: (with pkgs; [
    dejavu_fonts
    alsa-lib
    at-spi2-atk
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libGL
    libudev0-shim
    libxkbcommon
    mesa
    nspr
    nss
    pango
  ]) ++ (with pkgs.xorg; [
    libX11
    libxcb
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
    libXrender
    libXtst
    libXi
  ]);
};

progEnv = buildFHSEnv {
  pname = "${package.pname}";
  inherit (package) version meta;
  runScript = "${package.outPath}/bin/${package.pname}_run";

  targetPkgs = pkgs: (with pkgs; [
    dejavu_fonts
    alsa-lib
    at-spi2-atk
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libGL
    libudev0-shim
    libxkbcommon
    mesa
    nspr
    nss
    pango

    libusb1
    pcsclite
    zlib
    krb5
  ]) ++ (with pkgs.xorg; [
    libX11
    libxcb
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
    libXrender
    libXtst
    libXi
  ]);
};
}
