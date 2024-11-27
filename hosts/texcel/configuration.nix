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
    ../../modules/system/gaming.nix
    ../../modules/system/inputs.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable32Bit = true;
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  core = {
    hostname = "texcel";
    user = {
      name = "jlevesy";
      groups = ["wheel" "networkmanager"];
      homeConfig = import ./home.nix;
    };
  };

  system.stateVersion = "24.05";
}
