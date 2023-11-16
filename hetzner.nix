{modulesPath, ...}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  disko.devices = import ./disk-config.nix;

  boot.loader.systemd-boot.enable = true;
  services.openssh.enable = true;
  
  users.users.root.openssh.authorizedKeys.keys = [
    (builtins.readFile ./nano-id_rsa.pub)
  ];
}
