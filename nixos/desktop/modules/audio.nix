{
  security.rtkit.enable = true;
  sound.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
  #};
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    
    extraConfig = ''
      set-default-sink alsa_output.pci-0000_30_00.6.analog-stereo
    '';
  };
}
