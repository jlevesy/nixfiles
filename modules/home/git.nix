{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    git = {
      username = lib.mkOption {
        default = "unknown";
        description = ''
          Git Username
        '';
      };

      email = lib.mkOption {
        default = "unknown@unknown.com";
        description = ''
          Git Username
        '';
      };

      signingKey = lib.mkOption {
        default = null;
        description = ''
          Signing key to use
        '';
      };
    };
  };

  config = {
    programs.git = {
      enable = true;
      userName = config.git.username;
      userEmail = config.git.email;

      signing = lib.mkIf (config.git.signingKey != null) {
        key = config.git.signingKey;
        signByDefault = true;
      };

      diff-so-fancy = {
        enable = true;
      };

      aliases = {
        st = "status";
        br = "branch";
        co = "checkout";
        l = "log --pretty='%C(yellow)%h -%Creset %s%Creset' --abbrev-commit --graph";
        lg = "log --graph --pretty=format:'%C(yellow)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        lgs = "log --graph --pretty=format:'%C(yellow)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --stat";
        lgsp = "log --graph --pretty=format:'%C(yellow)%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --stat -p";
        la = "!git l --all";
        lga = "!git lg --all";
        lgsa = "!git lgs --all";
        lgspa = "!git lgsp --all";
      };

      extraConfig = {
        ui = {
          color = true;
        };
        core = {
          whitespace = "trailing-space,space-before-tab";
        };
        pull = {
          rebase = false;
          ff = "only";
        };
        push = {
          default = "simple";
        };
        rerere = {
          enabled = true;
        };
        gpg = lib.mkIf (config.git.signingKey != null) {
          format = "ssh";
        };
      };
    };
  };
}
