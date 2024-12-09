{...}: {
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      api = {};

      entryPoints = {
        https = {
          address = ":443";
        };
      };

      certificatesResolvers = {
        tailscale.tailscale = {};
      };
    };

    dynamicConfigOptions = {
      http = {
        routers.dashboard = {
          entryPoints = ["https"];
          rule = "Host(`nascel.pirate-mintaka.ts.net`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))";
          service = "api@internal";
          tls.certResolver = "tailscale";
        };
      };
    };
  };
}
