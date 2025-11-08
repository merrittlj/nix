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
      "ssh_key/andesite_git" = { inherit owner; };
      "ssh_key/personal_git" = { inherit owner; };
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

  systemd.user.services.sops-ssh-key = {
    description = "Add sops-managed SSH key to ssh-agent";
    after = [ "ssh-agent.service" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.openssh}/bin/ssh-add ${config.sops.secrets."ssh_key/andesite_git".path}
        ${pkgs.openssh}/bin/ssh-add ${config.sops.secrets."ssh_key/personal_git".path}
      '';
      Restart = "on-failure";
    };
    wantedBy = [ "default.target" ];
  };
}
