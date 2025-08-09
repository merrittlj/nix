{
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot = {
    enable = true;
    sortKey = "_z_nixos";
    extraEntries = {
      "windows.conf" = ''
        title Windows
        efi /EFI/Microsoft/Boot/bootmgfw.efi
        sort-key _a_windows
      '';
      "gentoo.conf" = ''
        title Gentoo
        efi /EFI/gentoo/grubx64.efi
        sort-key _b_gentoo
      '';
    };
  };
}
