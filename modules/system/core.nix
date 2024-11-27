{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options = {
    core = {
      hostname = lib.mkOption {
        default = "unknowncell";
        description = ''
          Hostname.
        '';
      };

      user = lib.mkOption {
        default = {
          name = "jlevesy";
          groups = ["wheel"];
          homeConfig = {};
        };
        description = ''
          User configuration.
        '';
      };

      timezone = lib.mkOption {
        default = "Europe/Paris";
        description = ''
          Timezone of the system.
        '';
      };

      locale = lib.mkOption {
        default = "en_US.UTF-8";
        description = ''
          Locale of the system.
        '';
      };
    };
  };

  config = {
    boot.loader.systemd-boot.enable = true;

    networking = {
      hostName = config.core.hostname;
      networkmanager.enable = true;
      firewall.enable = false;
    };

    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };

    nixpkgs.config.allowUnfree = true;

    time.timeZone = config.core.timezone;
    i18n.defaultLocale = config.core.locale;

    programs.zsh.enable = true;
    users.users.${config.core.user.name} = {
      isNormalUser = true;
      extraGroups = config.core.user.groups;
      description = "Main user of this system";
      shell = pkgs.zsh;
    };

    home-manager = {
      extraSpecialArgs = {inherit inputs;};

      users = {
        "${config.core.user.name}" = config.core.user.homeConfig;
      };
    };

    environment.systemPackages = with pkgs; [
      neovim
      git
    ];
  };
}
