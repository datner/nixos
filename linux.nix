{
  pkgs,
  nix-index-database,
  lib,
  ...
} @ attrs: {
  system.stateVersion = "24.05";

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
  #
  # virtualisation.docker = {
  #   enable = true;
  #   enableOnBoot = true;
  #   autoPrune.enable = true;
  # };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix = {
    settings.trusted-users = [
      "root"
      "datner"
    ];
    settings.auto-optimise-store = true;

    extraOptions = "
    experimental-features = nix-command flakes
    ";

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
