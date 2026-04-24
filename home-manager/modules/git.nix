{
  programs.git = {
      enable = true;
      userName = "Lucas Merritt";
      userEmail = "merrittlj@protonmail.com";
      signing.signByDefault = false;

      includes = [
        {
          condition = "gitdir:~/work/";

          contents = {
            user = {
              name = "Lucas Merritt";
              email = "c.lucas.merritt@andesite.ai";
              signingKey = "c.lucas.merritt@andesite.ai";
            };

            commit.gpgSign = true;
            tag.gpgSign = true;
            gpg.format = "openpgp";

            url."git@github.com-work:".insteadOf = "git@github.com:";
          };

          
        }
      ];

    extraConfig = {
      safe = {
        directory = [
          "/etc/nixos"
          "/home/lucas/nix"
        ];
      };
    };
  };

  programs.gh = {
    enable = false;
  };
}
