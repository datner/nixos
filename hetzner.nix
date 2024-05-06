{
  modulesPath,
  lib,
  config,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  disko.devices = import ./disk-config.nix;
  boot.loader = {
    grub.enable = true;
    grub.efiSupport = true;
    grub.devices = ["/dev/sda" "/dev/sdb"];
  };
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.swraid.mdadmConf = "MAILADDR root@mydomain.tld"; # doesn't matter

  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "devbox";
  networking.networkmanager.enable = true;

  security.pam.enableSSHAgentAuth = true;
  security.sudo.wheelNeedsPassword = false;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.openssh = {
    enable = true;
    banner = "Welcome to Datners Devbox";
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "yes";
  };

  services.yubikey-agent.enable = true;

  # Can either have this or the gnupg agent
  # programs.ssh.startAgent = true;
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.root.openssh.authorizedKeys.keyFiles = [
    ./nano-id_rsa.pub
    ./general-id_ed25519.pub
  ];
}
