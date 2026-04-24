{ host, ... }:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      sortKey = "_z_nixos";

      extraEntries = {
        macbook = {
          "macos_opencore.conf" = ''
            title macOS-OpenCore
            efi /EFI/OC/OpenCore.efi
            sort-key _a_macos_opencore
          '';
        };
        
        desktop = {
          "windows.conf" = ''
            title Windows
            efi /EFI/Microsoft/Boot/bootmgfw.efi
            sort-key _a_windows
          '';
        };
      }.${host};
    };
  };
}
