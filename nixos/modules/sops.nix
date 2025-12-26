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

  systemd.user.services.ssh-add-keys = {
    description = "Add SSH keys to agent";
    wantedBy = [ "default.target" ];
    after = [ "ssh-agent.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "ssh-add-keys" ''
        ${pkgs.openssh}/bin/ssh-add ${config.sops.secrets."ssh_key/andesite_git".path}
        ${pkgs.openssh}/bin/ssh-add ${config.sops.secrets."ssh_key/personal_git".path}
      '';
      Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
    };
  };
}
