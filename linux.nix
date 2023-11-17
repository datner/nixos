{pkgs, nix-index-database, ...} @ attrs: {
  system.stateVersion = "23.05";
  security.pam.enableSSHAgentAuth = true;
  security.sudo.wheelNeedsPassword = false;

  programs.ssh.startAgent = true;
  programs.gnupg.agent.enableSSHSupport = true;
  
  programs.zsh.enable = true;

  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];
  environment.enableAllTerminfo = true;

  users.users.datner = {
    isNormalUser = true;
    shell = pkgs.zsh;

    extraGroups = [
      "wheel"
      "docker"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9CFk0y9omvKabcg8Y/RUKLhuNzlp0VlhFP+VmcYTg5mElrCsiR+jdUDk+7TamFvrhRwQOG77WiwdDmST0mpISC4zhZxFS8XMEKYPD/q4babp55ogq+irzjWMWABLx//c8Foz+xXRgtq9aKHF5hpOWfEGCx2hxo7yXh+g0esvDVQRdZW95vpZEEw8ZTpKRPjne4WPBX6czxWG5l+Rj91+Z+ygbzwmExISBQ1suAHq2bnOyrvpNI/g6kNTj8/KuWwuhadiukYe2KdWRuQRV2ILQpUgYKTErcHtBaLJHU4nQm6Zw48+Gi32c4Ti29ND6UwzPq+DqDPUKwPXZxyXKLKysx6+k2CaFGO+3jP2Bseid8FabeBR38D0+WiDxr8zs9XsAaGdDUxTOlMa6kI8Kr4ro23s7Jkw/oebTK7sSWS/04ZacOzCISnFizL8pgRpVUtNCcESVTo99dMSzR5ufVI2ppZdAHPV6G1YjU2+LhrVuc4iHjie59zFuzgS3sv/6xpX9CaZjZa+kJQm991EXkMwtkQFBjjdZMwwPDmXmo8cIC+o01uh84r/fJAYZCXHCeayRifeRp8SHFt2/F7bS6IQ4mLllIeQoINn6MQnVmK3xDneRrJHW5AykVASu3DdQ+pXnyCJQB9Jb7NP1LiZOeR1vIb5dF26xJr1ItOnAHIrogw== cardno:23_745_697"
    ];
  };

  # home-manager = {
  #   extraSpecialArgs = attrs;
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #
  #   users.datner = {
  #     imports = [./datner-home.nix];
  #   };
  # };

  # virtualisation.docker = {
  #   enable = true;
  #   enableOnBoot = true;
  #   autoPrune.enable = true;
  # };

  nix = {
    settings = {
      trusted-users = [
        "root"
        "datner"
      ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
