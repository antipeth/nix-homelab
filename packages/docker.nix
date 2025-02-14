{
  config,
  pkgs,
  host,
  ...
}:
{
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    # alist = import ./docker/alist.nix;
    # alist = import ./docker/wakapi.nix;
  };
}
