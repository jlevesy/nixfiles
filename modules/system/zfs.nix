{
  config,
  lib,
  ...
}: {
  options = {
    zfs = {
      extraPools = lib.mkOption {
        default = [];
        description = ''
          List of pools to import and mount at boot time;
        '';
      };
      devNodes = lib.mkOption {
        default = "/dev/disk/by-id";
        description = ''
          devNodes to use when importing the pool.
        '';
      };
    };
  };
  config = {
    boot = {
      supportedFilesystems = ["zfs"];

      zfs = {
        forceImportRoot = false;
        devNodes = config.zfs.devNodes;
        extraPools = config.zfs.extraPools;
      };
    };
  };
}
