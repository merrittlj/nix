{ pkgs, config, username, ... }:
let
  sopsFile = ../../secrets/secrets.yaml;
  format = "yaml";
  me = config.users.users.lucas;
  owner = me.name;

  keyringScript = pkgs.writeShellScriptBin "sops-keyring-script" ''
    #!/bin/sh
    ${pkgs.gnupg}/bin/gpg --import ${config.sops.secrets."gpg_key/andesite_git".path}
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

  systemd.user.services.sops-keyring = {
    description = "Load SOPS secrets into GNOME Keyring";
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${keyringScript}/bin/sops-keyring-script";
    };
    wantedBy = [ "graphical-session.target" ];
  };
}
