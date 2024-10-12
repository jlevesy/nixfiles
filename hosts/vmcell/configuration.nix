{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/system/core.nix
    ../../modules/system/sound.nix
    ../../modules/system/hyprland.nix
  ];

  core = {
    hostname = "vmcell";
    user = {
      name = "jlevesy";
      groups = ["wheel"];
      homeConfig = import ./home.nix;
    };
  };

  system.stateVersion = "24.05";
}
