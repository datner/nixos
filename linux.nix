{pkgs, nix-index-database, ...} @ attrs: {
  system.stateVersion = "23.05";

  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];
  environment.enableAllTerminfo = true;

  programs.zsh.enable = true;
  
  users.users.datner = {
    isNormalUser = true;
    shell = pkgs.zsh;

    extraGroups = [
      "wheel"
      "docker"
    ];

    openssh.authorizedKeys.keyFiles = [
      ./nano-id_rsa.pub
      ./general-id_ed25519.pub
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
