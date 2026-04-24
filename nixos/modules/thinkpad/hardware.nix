{ config, lib, pkgs, ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  services.xserver.videoDrivers = [ "modesetting" ];

  environment.variables = { };

  console.keyMap = "dvorak-programmer";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.enableAllFirmware = true;
}
