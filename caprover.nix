{pkgs, ...}: {
  networking.firewall.allowedTCPPorts = [
    3000
  ];
  
  users.users.datner.extraGroups = [ "docker" ];
  
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers.caprover = {
    image = "caprover/caprover";
    ports = [
      "127.0.0.1:80:80"
      "127.0.0.1:443:443"
      "127.0.0.1:3000:3000"
    ];
    environment = {
      ACCEPTED_TERMS = "true";
    };
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/captain:/captain"
    ];
  };
}


