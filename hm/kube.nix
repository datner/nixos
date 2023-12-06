{pkgs, ...}: {
  home.packages = with pkgs; [
    pkgs.kubernetes-helm-wrapped
  ];

  programs = {
    k9s.enable = true;
  };
}
