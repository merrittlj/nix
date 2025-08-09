{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    set_status
  ];
}
