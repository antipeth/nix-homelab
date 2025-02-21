{
  services.immich = {
    enable = true;
    port = 2283;
    openFirewall = true;
    host = "192.168.6.173";
    mediaLocation = "/media/immich";
    machine-learning.enable = false;
    redis = {
      enable = true;
    };
    database = {
      enable = true;
      port = 5432;
    };
  };
}
