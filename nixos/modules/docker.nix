{ config, ... }:
{
  virtualisation.docker = {
    enable = true;
    # rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };

  # Fix for Docker bridge networking on NixOS
  # Prevents reverse path filtering from blocking container→host connections
  # Required for k3d native backend development mode
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.rp_filter" = 0;
    "net.ipv4.conf.default.rp_filter" = 0;
  };
}
