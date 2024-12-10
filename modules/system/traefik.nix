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
        middlewares = {
          stripseafilepath = {
            stripPrefix = {
              prefixes = [
                "/seafhttp"
                "/seafile/media"
              ];
            };
          };
        };

        services = {
          seafile = {
            loadBalancer.servers = [{url = "http://localhost:38082";}];
          };

          seahub = {
            loadBalancer.servers = [{url = "http://localhost:38083";}];
          };

          seahub-assets = {
            loadBalancer.servers = [{url = "http://localhost:38084";}];
          };
        };
        routers = {
          seafile = {
            entryPoints = ["https"];
            rule = "Host(`nascel.pirate-mintaka.ts.net`) && PathPrefix(`/seafhttp`)";
            service = "seafile";
            tls.certResolver = "tailscale";
            middlewares = ["stripseafilepath"];
          };
          seahub = {
            entryPoints = ["https"];
            rule = "Host(`nascel.pirate-mintaka.ts.net`) && (PathPrefix(`/seafile`))";
            service = "seahub";
            tls.certResolver = "tailscale";
          };
          seahub-assets = {
            entryPoints = ["https"];
            rule = "Host(`nascel.pirate-mintaka.ts.net`) && (PathPrefix(`/seafile/media`))";
            service = "seahub-assets";
            tls.certResolver = "tailscale";
            middlewares = ["stripseafilepath"];
          };
          dashboard = {
            entryPoints = ["https"];
            rule = "Host(`nascel.pirate-mintaka.ts.net`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))";
            service = "api@internal";
            tls.certResolver = "tailscale";
          };
        };
      };
    };
  };
}
