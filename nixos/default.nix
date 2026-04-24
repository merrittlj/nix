{ pkgs, inputs, hostname, host, helpers, ... }:
{
  imports = [
    ./packages.nix
  ] ++ (import ./bundle.nix { inherit host helpers; }); # bundles outside module evaluation

  # Hostname
  networking.hostName = "${hostname}";
  
  # Time zone.
  time.timeZone = "America/Denver";

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
