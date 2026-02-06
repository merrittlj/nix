{ pkgs, config, ...}:

let
  personalKey = "/run/secrets/ssh_key/personal_git";
  workKey = "/run/secrets/ssh_key/andesite_git";
in
{
  programs.ssh = {
    enable = true;

    controlMaster = "auto";
    controlPath = "~/.ssh/master-%r@%n:%p";
    controlPersist = "10m";  # Keep connections alive for 10 minutes after last use

    extraConfig = ''
      Host github.com
        HostName ssh.github.com
        User git
        Port 443
        IdentityFile ${personalKey}
        IdentitiesOnly yes

      Host github.com-work
        HostName ssh.github.com
        User git
        Port 443
        IdentityFile ${workKey}
        IdentitiesOnly yes
    '';
  };
}
