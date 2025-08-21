{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pulseaudio = {
    enable = false;
    support32Bit = true;
    
    extraConfig = ''
      set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
    '';
  };
}
