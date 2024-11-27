{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./alacritty.nix
    ./wofi.nix
    ./waybar.nix
    ./mako.nix
    ./firefox.nix
    ./seafile.nix
  ];

  home.packages = with pkgs; [
    keepassxc
    vesktop
    piper
  ];
}
