{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  disko.devices = import ./disk-config.nix;
  boot.loader.systemd-boot.enable = true;
  
  security.pam.enableSSHAgentAuth = true;
  security.sudo.wheelNeedsPassword = false;
  
  services.openssh = {
    enable = true;
    banner = "Welcome to Datners Devbox";
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "yes";
  };
  
  programs.ssh.startAgent = true;
  
  users.users.root.openssh.authorizedKeys.keyFiles = [
    ./nano-id_rsa.pub
    ./general-id_ed25519.pub
  ];
}
