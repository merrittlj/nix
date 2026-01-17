{ pkgs, config, username, ... }:
let
  sopsFile = ../../secrets/secrets.yaml;
  format = "yaml";
  owner = config.users.users.lucas.name;

  startSSHAgents = pkgs.writeScript "start-ssh-agents.sh" ''
    #!/bin/sh

    # Work agent
    eval "$(${pkgs.openssh}/bin/ssh-agent -a /run/user/1000/ssh-agent-work.sock)"
    ${pkgs.openssh}/bin/ssh-add /run/secrets/ssh_key/andesite_git

    # Personal agent
    eval "$(${pkgs.openssh}/bin/ssh-agent -a /run/user/1000/ssh-agent-personal.sock)"
    ${pkgs.openssh}/bin/ssh-add /run/secrets/ssh_key/personal_git

    # Keep the service alive
    exec sleep infinity
  '';
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

  # programs.ssh.startAgent = true;
  systemd.user.services.sshAgents = {
    description = "SSH agents for work and personal";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${startSSHAgents}";
    };
    wantedBy = [ "default.target" ];
  };
}
