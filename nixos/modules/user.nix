{ pkgs, ... }: {
    users = {
      users.lucas = {
        isNormalUser = true;
	description = "Lucas Merritt";
        extraGroups = [ 
          "wheel" 
          "input" 
          "audio" 
          "video" 
          "usb" 
          "plugdev" 
          "adbusers" 
          "dialout" 
          "docker" 
          "cdrom"
        ];
        hashedPassword = "$y$j9T$.q.eQImtWfIheMb1x/O7y/$T3oF28nN3Lc3vABCB9YAvfjjgD5xdE/YxM7GZS3Bnj8";
        shell = pkgs.fish;
      };
      users.root.shell = pkgs.fish;
      mutableUsers = false;
    };
    nix.settings.trusted-users = [ "root" "lucas" ];

    security.wrappers = {
      cdrdao = {
        setuid = true;
        owner = "root";
        group = "cdrom";
        permissions = "u+wrx,g+x";
        source = "${pkgs.cdrdao}/bin/cdrdao";
      };
      cdrecord = {
        setuid = true;
        owner = "root";
        group = "cdrom";
        permissions = "u+wrx,g+x";
        source = "${pkgs.cdrtools}/bin/cdrecord";
      };
    };

    services.udisks2.enable = true;
}
