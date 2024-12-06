{
  config,
  lib,
  pkgs,
  ...
}: let
  makeArgs = devices: builtins.foldl' (acc: dev: acc + " -a ${dev.drive} -i ${builtins.toString (dev.delay)}") "" devices;
in {
  options = {
    hd-idle = {
      drives = lib.mkOption {
        default = [];
        description = ''
          List of drives to spin down.
        '';
      };
    };
  };
  config = {
    environment.systemPackages = [pkgs.hd-idle];

    systemd.services.hd-idle = {
      description = "External HD spin down daemon";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hd-idle}/bin/hd-idle -i 0" + makeArgs (config.hd-idle.drives);
      };
    };
  };
}
