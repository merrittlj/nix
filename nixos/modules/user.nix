{ pkgs, ... }: {
    users = {
      users.lucas = {
        isNormalUser = true;
	description = "Lucas Merritt";
        extraGroups = [ "wheel" "input" "audio" ];
        hashedPassword = "$y$j9T$LACAriqXNenBZMQd6BaCE0$RpigRrSBjUklzTEzAtapiyz3yonTwAmoyTN7hUxaUG2";
      };
      mutableUsers = false;
    };
}
