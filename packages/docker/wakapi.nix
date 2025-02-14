{
  image = "ghcr.io/muety/wakapi:latest";

  volumes = [
    "/etc/wakapi:/data"
    "/etc/localtime:/etc/localtime:ro"
  ];

  ports = [
    "127.0.0.1:3000:3000"
  ];

  environment = {
    WAKAPI_PASSWORD_SALT = "xxxxxxxxxxxx";
  };

  restartPolicy = "unless-stopped";
}
