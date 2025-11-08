{
  programs.git = {
      enable = true;
      userName = "Lucas Merritt";
      # userEmail = "merrittlj@protonmail.com";
      userEmail = "c.lucas.merritt@andesite.ai";
      signing = {
        format = "openpgp";
        signByDefault = true;
        key = "c.lucas.merritt@andesite.ai";
      };
  };

  programs.gh = {
    enable = true;
	gitCredentialHelper.enable = true;
  };
}
