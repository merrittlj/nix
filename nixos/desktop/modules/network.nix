{
    networking.firewall.extraCommands = ''
        iptables -A nixos-fw -p tcp --source 192.168.1.0/24 --dport 1714 -j nixos-fw-accept
        iptables -A nixos-fw -p udp --source 192.168.1.0/24 --dport 1714 -j nixos-fw-accept
    '';
}
