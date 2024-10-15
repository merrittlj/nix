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
      #url = "https://www.st.com/content/ccc/resource/technical/software/utility/group0/3a/d7/87/bd/1a/54/4b/2f/stm32cubeprg-lin-v2-16-0/files/stm32cubeprg-lin-v2-16-0.zip/jcr:content/translations/en.stm32cubeprg-lin-v${builtins.replaceStrings ["."] ["-"] version}.zip";
      url = "https://www.st.com/content/ccc/resource/technical/software/utility/group0/3f/99/f1/92/bd/74/4f/5f/stm32cubeprg-lin-v2-17-0/files/stm32cubeprg-lin-v2-17-0.zip/jcr:content/translations/en.stm32cubeprg-lin-v2-17-0.zip";
      sha256 = "sha256-krvECbtNGs01Zjdx6PqddmfnVZg1pM6upaMc2rwa0EQ=";
      curlOpts = "--compressed --user-agent \"Firefox/131.0\"";
      stripRoot = false;
    };

    buildCommand = ''
      mkdir -p $out/{bin,opt}

      cp -r $src/jre/ $out/opt
      cp $src/SetupSTM32CubeProgrammer-${version}.linux $out/opt
      cp $src/SetupSTM32CubeProgrammer-${version}.exe $out/opt

      cat << EOF > $out/bin/${pname}_installer
      #!${stdenvNoCC.shell}
      $out/opt/SetupSTM32CubeProgrammer-${version}.linux
      EOF
      chmod +x $out/bin/${pname}_installer
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
  runScript = "/home/lucas/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32CubeProgrammer";

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
