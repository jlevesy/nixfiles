{...}: {
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "server";
    permitCertUid = "traefik";
  };
}
