{ config, pkgs, lib, ...}:

{
  xdg.configFile."zellij/config.kdl" = {
    text = builtins.readFile ./zellij/config.kdl;
  };

  programs = {
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
