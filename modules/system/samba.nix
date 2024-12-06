{
  config,
  lib,
  ...
}: {
  options = {
    samba = {
      serverName = lib.mkOption {
        default = "";
        description = ''
          name of the server to advertize.
        '';
      };
      storagePath = lib.mkOption {
        default = "";
        description = ''
          path to store the shared data.
        '';
      };
      shareUser = lib.mkOption {
        default = "";
      };
      shareGroup = lib.mkOption {
        default = "";
      };
    };
  };
  config = {
    services.samba = {
      enable = true;
      securityType = "user";
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "server %h (Samba %v)";
          "netbios name" = config.samba.serverName;
          "security" = "user";
          "use sendfile" = "yes";
          "hosts allow" = "192.168.1.1/24 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = config.samba.shareUser;
          "map to guest" = "bad user";
        };
        "public" = {
          "path" = config.samba.storagePath;
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = config.samba.shareUser;
          "force group" = config.samba.shareGroup;
        };
      };
    };

    services.samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}
