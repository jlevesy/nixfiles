{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    silver-searcher
    htop
  ];

  services.ssh-agent = {
    enable = true;
  };

  programs.lsd = {
    enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 20000;
      size = 20000;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "systemd"
        "docker"
        "golang"
        "kubectl"
      ];
    };

    shellAliases = {
      vim = "nvim";
      vi = "nvim";
      sl = "ls";
      b = "gh repo view --web";
      tree = "ls --tree -A --blocks name";
      ip = "ip --color";
      ipb = "ip --color --brief";
      ls = "lsd --all";
      cat = "bat";
    };
  };
}
