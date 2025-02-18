{
  services.immich = {
    enable = true;
    port = 2283;
    openFirewall = true;
    user = "atp";
    group = "users";
    host = "192.168.6.173";
    mediaLocation = "/media";
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
