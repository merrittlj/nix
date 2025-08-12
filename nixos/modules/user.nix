{ pkgs, ... }: {
    users = {
      users.lucas = {
        isNormalUser = true;
	description = "Lucas Merritt";
        extraGroups = [ "wheel" "input" "audio" "video" "usb" "plugdev" "adbusers" "dialout" ];
        hashedPassword = "$y$j9T$.q.eQImtWfIheMb1x/O7y/$T3oF28nN3Lc3vABCB9YAvfjjgD5xdE/YxM7GZS3Bnj8";
      };
      mutableUsers = false;
    };
}
