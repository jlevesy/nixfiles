{pkgs, ...}: {
  home.packages = [pkgs.seafile-shared];

  systemd.user.services.seafile-client = {
    Unit = {
      Description = "Seafile Client";
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = "${pkgs.seafile-shared}/bin/seaf-cli start";
      Type = "forking";
    };
  };
}
