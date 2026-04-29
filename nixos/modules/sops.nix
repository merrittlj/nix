{ pkgs, config, username, ... }:
let
  sopsFile = ../../secrets/secrets.yaml;
  format = "yaml";
  me = config.users.users.lucas;
  owner = me.name;
in {
  sops = {
    defaultSopsFile = sopsFile;
    defaultSopsFormat = format;

    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      "ssh_key/andesite_git" = { inherit owner; mode = "0600"; };
      "ssh_key/personal_git" = { inherit owner; mode = "0600"; };
      "gpg_key/andesite_git" = { inherit owner; };
    };
  };
}
