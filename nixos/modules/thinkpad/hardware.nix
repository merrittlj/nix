{ config, lib, pkgs, ... }:
{
  # ThinkPad-specific hardware configuration
  # Adjust based on your specific ThinkPad model

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  # Most ThinkPads use Intel graphics
  services.xserver.videoDrivers = [ "modesetting" ];

  environment.variables = { };

  console.keyMap = "us";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.enableAllFirmware = true;
}
