{
  config,
  pkgs,
  ...
}: {
  home.username = "jlevesy";
  home.homeDirectory = "/home/jlevesy";
  home.stateVersion = "24.05";

  imports = [
    ../../modules/home/shell.nix
    ../../modules/home/git.nix
    ../../modules/home/zellij.nix
    ../../modules/home/desktop.nix
    ../../modules/home/gh.nix
    ../../modules/home/neovim.nix
  ];

  git = {
    username = "Julien Levesy";
    email = "453265+jlevesy@users.noreply.github.com";
    signingKey = "/home/jlevesy/.ssh/id_github.pub";
  };

  hypr = {
    monitor = [
      "DP-3,2560x1440@143.998,1080x0,1.0"
      "DP-1,1920x1080@60.00,0x0,1.0"
      "DP-1,transform,1"
    ];
    wallpaper_preload = "~/.config/hypr/wallpaper.png";
    wallpaper = [
      "DP-1,~/.config/hypr/wallpaper.png"
      "DP-3,~/.config/hypr/wallpaper.png"
    ];
  };

  programs.home-manager.enable = true;
}
