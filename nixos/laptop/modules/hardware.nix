{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

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

  systemd.services.poweroff-nvidia = {
    description = "Power off NVIDIA dGPU after Intel iGPU takeover";
    after = ["graphical.target"]; # Wait until graphics is up
    wantedBy = ["graphical.target"];
    serviceConfig.Type = "oneshot";
  };

  systemd.services.set-bridge-control = {
    description = "Set proper PCI bridge control to keep backlight working with NVIDIA dGPU disabled";
    after = ["graphical.target"]; # Wait until graphics is up
    wantedBy = ["graphical.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.pciutils}/bin/setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0";
    };
  };

  nixpkgs.config.allowUnfree = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-label/NIXSWAP"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
      
