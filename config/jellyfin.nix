{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "atp";
    group = "users";
    dataDir = "/media";
    cacheDir = "/var/cache/jellyfin";
    configDir = "var/lib/jellyfin/config";
  };
}
