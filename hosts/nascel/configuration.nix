{...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../modules/system/tailscale-server.nix
    ../../modules/system/zfs.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      efiSupport = false;
    };
  };

  zfs.extraPools = ["datatank"];

  networking = {
    hostId = "cbcb6a1c";
    hostName = "nascel"; # Define your hostname.
    firewall.enable = true;
  };

  users.users.jlevesy = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["jlevesy"];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
}
