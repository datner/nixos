{pkgs, ...}: {
  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server
  ];
  
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
    openFirewall = true;
  };
}

