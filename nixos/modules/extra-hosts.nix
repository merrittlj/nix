{ config, ... }:
{
  networking.extraHosts = ''
    127.0.0.1 localhost local.app.andesite.ai stream.local.app.andesite.ai auth.local.app.andesite.ai
    ::1 localhost
  '';
}
