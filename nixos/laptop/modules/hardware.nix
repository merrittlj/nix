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
  }; 
  #services.udev.extraRules = ''
  #  # Remove NVIDIA USB xHCI Host Controller devices, if present
  #  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
  #  # Remove NVIDIA USB Type-C UCSI devices, if present
  #  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
  #  # Remove NVIDIA Audio devices, if present
  #  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
  #  # Remove NVIDIA VGA/3D controller devices
  #  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  #'';
  systemd.services.poweroff-nvidia = {
    description = "Power off NVIDIA dGPU after Intel iGPU takeover";
    after = ["graphical.target"]; # Wait until graphics is up
    wantedBy = ["graphical.target"];
    serviceConfig.Type = "oneshot";
    script = "
    ";
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
      
