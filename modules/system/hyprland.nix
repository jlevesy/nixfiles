{pkgs, ...}: {
  programs.hyprland.enable = true;
  hardware.graphics.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.inconsolata
  ];
}
