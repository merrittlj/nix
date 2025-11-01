{ host, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  boot.extraModprobeConfig = { 
    laptop = ''
      options snd-hda-intel model=imac27_122
    '';

    desktop = '''';
  }.${host};
}
