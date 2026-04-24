{ config, lib, pkgs, ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sdhci_pci" ];
      kernelModules = [ "wl" ];
    };

    kernelModules = [ "kvm-intel" "wl" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    blacklistedKernelModules = [ "b43" "ssb" "brcmfmac" "brcmsmac" "bcma" "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];

    extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    # FOR PROPER BACKLIGHT:
    # do not set acpi_backlight or similar kernel params
    # do not disable apple_gmux kernel module
    # /sys/class/backlight should just be gmux_backlight
    # setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0
  };

  hardware.nvidia = {
    modesetting.enable = false;
    powerManagement.enable = false;
  };

  services.xserver.videoDrivers = [ "intel" ];

  environment.variables = {
    GSK_RENDERER = "gl";
  };

  console = {
    earlySetup = true;
    useXkbConfig = true;
    keyMap = "dvorak-programmer";
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.enableAllFirmware = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-label/NIXSWAP"; }
  ];
}
