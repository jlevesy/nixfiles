{...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../modules/system/tailscale-server.nix
    ../../modules/system/zfs.nix
    ../../modules/system/samba.nix
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
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        2049 # NFS.
      ];
    };
  };

  users = {
    users.jlevesy = {
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    };
    users.share = {
      isSystemUser = true;
      group = "users";
    };
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

  services.nfs.server.enable = true;
  samba = {
    serverName = "nascel";
    storagePath = "/datatank/share";
    shareUser = "share";
    shareGroup = "users";
  };

  system.stateVersion = "24.05";
}