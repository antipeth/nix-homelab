{
  services = {
    syncthing = {
      enable = true;
      user = "atp";
      group = "users";
      openDefaultPorts = true;
      cert = "Path to the cert.pem file";
      key = "Path to the key.pem file";
    };
  };
}
