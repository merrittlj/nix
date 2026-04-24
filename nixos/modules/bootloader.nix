{ host, ... }:
{
  boot.loader = {
    efi.canTouchEfiVariables = true;

    systemd-boot = {
      enable = true;
      sortKey = "_z_nixos";
    };
  };
}
