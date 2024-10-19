{
  pkgs,
  lib,
  ...
} @ attrs: {
  system.stateVersion = "24.05";

  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];
  environment.enableAllTerminfo = true;

  environment.systemPackages = [
    pkgs.openssl
    pkgs.wget
    pkgs.curl
  ];

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = {
      datner = {
        imports = [
          ./datner-home.nix
        ];
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nix = {
    package = pkgs.nixFlakes;
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
