{ pkgs, config, ...}:

let
  personalKey = "/run/secrets/ssh_key/personal_git";
  workKey = "/run/secrets/ssh_key/andesite_git";
in
{
  programs.ssh = {
    enable = true;

    extraConfig = ''
      Host github.com-personal
        HostName github.com
        User git
        IdentityFile ${personalKey}
        IdentitiesOnly yes

      Host github.com-work
        HostName github.com
        User git
        IdentityFile ${workKey}
        IdentitiesOnly yes
    '';
  };
}
