{ config, pkgs, ... }:

{
  home.username = "jlevesy";
  home.homeDirectory = "/home/jlevesy";
  home.stateVersion = "24.05";

  imports = [
    ../../modules/home/shell.nix
    ../../modules/home/git.nix
    ../../modules/home/neovim.nix
    ../../modules/home/zellij.nix
    ../../modules/home/gh.nix
  ];

  git = {
    username = "Julien Levesy";
    email = "453265+jlevesy@users.noreply.github.com";
  };

  programs.home-manager.enable = true;
}
