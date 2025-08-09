{
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot = {
    enable = true;
    sortKey = "_z_nixos";
    extraEntries = {
      "macos_opencore.conf" = ''
        title macOS-OpenCore
        efi /EFI/OC/OpenCore.efi
        sort-key _a_macos_opencore
      '';
    };
  };
}
