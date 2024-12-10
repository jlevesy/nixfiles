{pkgs, ...}: let
  fileserver = pkgs.buildGoModule {
    pname = "fileserver";
    version = "0.0.1";
    vendorHash = null;
    src = ../../extras/fileserver;
  };
  dataDir = "/datatank/seaf";
  serviceOptions = {
    ProtectHome = true;
    PrivateUsers = true;
    PrivateDevices = true;
    PrivateTmp = true;
    ProtectSystem = "strict";
    ProtectClock = true;
    ProtectHostname = true;
    ProtectProc = "invisible";
    ProtectKernelModules = true;
    ProtectKernelTunables = true;
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    RestrictNamespaces = true;
    RemoveIPC = true;
    LockPersonality = true;
    RestrictRealtime = true;
    RestrictSUIDSGID = true;
    NoNewPrivileges = true;
    MemoryDenyWriteExecute = true;
    SystemCallArchitectures = "native";
    RestrictAddressFamilies = [
      "AF_UNIX"
      "AF_INET"
    ];
    User = "seafile";
    Group = "seafile";
    StateDirectory = "seafile";
    RuntimeDirectory = "seafile";
    LogsDirectory = "seafile";
    ConfigurationDirectory = "seafile";
    ReadWritePaths = dataDir;
  };
  serviceUrl = "https://nascel.pirate-mintaka.ts.net";
in {
  systemd.services.seafile-asset-server = {
    description = "Seafile asset server";
    wantedBy = ["seafile.target"];
    serviceConfig =
      serviceOptions
      // {
        Type = "simple";
        ExecStart = "${fileserver}/bin/fileserver -address 127.0.0.1:38084 -dir /var/lib/seafile/seahub/media";
      };
  };

  services.seafile = {
    enable = true;

    ccnetSettings.General.SERVICE_URL = "${serviceUrl}/seafile";
    adminEmail = "admin@seafile.com";
    initialAdminPassword = "changeme";

    seafileSettings = {
      history.keep_days = "14"; # Remove deleted files after 14 days
      fileserver = {
        host = "127.0.0.1";
        port = 38082;
        enable_access_log = true;
      };
    };

    seahubAddress = "127.0.0.1:38083";
    seahubExtraConf = ''
      SITE_TITLE = 'Juju\'s file sharing'
      SITE_ROOT = '/seafile/'
      MEDIA_URL = '/seafile/media/'
      COMPRESS_URL = MEDIA_URL
      STATIC_URL = MEDIA_URL + 'assets/'
      LOGIN_URL = '/seafile/accounts/login/'
      FILE_SERVER_ROOT = '${serviceUrl}/seafhttp'
    '';

    dataDir = dataDir;
  };
}
