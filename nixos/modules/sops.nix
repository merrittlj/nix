{ pkgs, config, username, ... }:
let
  sopsFile = ../../secrets/secrets.yaml;
  format = "yaml";
  owner = config.users.users.lucas.name;
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

  systemd.user.services.importGPGKey = {
    description = "Import GPG key from sops-nix secrets";
    after = [ "network.target" ];
    serviceConfig.ExecStart = ''
      gpg --batch --import ${config.sops.secrets."gpg_key/andesite_git".path}
    '';
    wantedBy = [ "default.target" ];
  };

  programs.ssh.startAgent = true;
}
