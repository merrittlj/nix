{
  security.rtkit.enable = true;
  sound.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
  #};
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=imac27_122
  '';
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    
    extraConfig = ''
      set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
    '';
  };
}
