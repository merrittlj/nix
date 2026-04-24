{
  boot.loader.systemd-boot.extraEntries = {
    "macos_opencore.conf" = ''
      title macOS-OpenCore
      efi /EFI/OC/OpenCore.efi
      sort-key _a_macos_opencore
    '';
  };
}
