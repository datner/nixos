{pkgs, nix-index-database, ...} @ attrs: {
  system.stateVersion = "23.05";
  security.pam.enableSSHAgentAuth = true;
  security.sudo.wheelNeedsPassword = false;

  programs.ssh.startAgent = true;
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
      (builtins.readFile ./nano-id_rsa.pub)
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

    # package = pkgs.nixVersions.stable;
    # extraOptions = ''
    #   experimental-features = nix-command flakes
    # '';

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
