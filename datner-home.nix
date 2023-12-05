{
  pkgs,
  nix-index-database,
  ...
}: {
  home.username = "datner";
  home.homeDirectory = "/home/datner";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  pam.yubico.authorizedYubiKeys.ids = [
    "cccccbhlgflb"
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    nodejs-slim
    cachix
    dprint
  ];

  programs = {
    kitty.enable = true;
    bat.enable = true;
    gpg.enable = true;
    fzf.enable = true;
    lazygit.enable = true;
    bottom.enable = true;
    password-store.enable = true;

    broot = {
      enable = true;
      settings.modal = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
    };

    git = {
      enable = true;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
      signing = {
        key = "0x5F7D170B1A09B7F9";
        signByDefault = true;
      };
      userName = "Yuval Datner";
      userEmail = "22598347+datner@users.noreply.github.com";
    };

    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

    nix-index.enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
      # more at https://starship.rs/presets/nerd-font.html
      git_branch.symbol = " ";
      git_commit.tag_disabled = false;
      git_status = {
        ahead = ''⇡''${count}'';
        behind = ''⇣''${count}'';
        diverged = ''⇕⇡''${ahead_count}⇣''${behind_count}'';
        staged = "+$count";
      };
      kubernetes.disabled = false;
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        impure_msg = "ι";
        pure_msg = "﻿ρ";
        symbol = " ";
      };
      aws.symbol = "  ";
      lua.symbol = " ";
      directory.read_only = " ";
      rust.symbol = " ";
      nodejs.symbol = " ";
    };
  };
}
