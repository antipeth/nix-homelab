{
  pkgs,
  host,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./disko-config.nix
    # ../../packages/caddy.nix
    # ../../packages/cockpit.nix
    # ../../packages/dn42
    # ../../packages/netdata.nix
    # ../../packages/podman.nix
    # ../../packages/syncthing.nix
    # ../../packages/sing-box.nix
    # ../../packages/traefik.nix
    # ../../packages/uptime-kuma.nix

    ../../config/blacklist.nix
    # ../../config/cockpit.nix
    # ../../config/home-assistant.nix
    ../../config/immich.nix
    # ../../config/jellyfin.nix
    # ../../config/nfs.nix
    ../../config/postgres.nix
    ../../config/power-management.nix
    # ../../config/redis.nix
    ../../config/samba.nix
    # ../../config/syncthing.nix
    ../../config/user.nix
    # ../../config/webdav.nix
    ../../config/zfs.nix
  ];

  boot = {
    # Kernel
    kernelModules = [ "tcp_bbr" ];
    kernel = {
      sysctl = {
        # bbr
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.default_qdisc" = "fq";
        "net.core.wmem_max" = 1073741824;
        "net.core.rmem_max" = 1073741824;
        "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
        "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
      };
    };

    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # loader.grub = {
    #   enable = true;
    #   device = "/dev/vda";
    #   useOSProber = true;
    # };
  };

  # Enable networking
  networking = {
    hostName = host;
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  users = {
    mutableUsers = false;
    users.root = {
      hashedPassword = "$y$j9T$C2J6aO1jUHb3OHBwIFk8a/$L92R8BMd/.XSlEXGz/r.eawijb9t.8otEbkLyQ1lwK5";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP4QAvLJJuxAaayqIBU8n6P0D0KHHSEjnqe3Ey7GZvFK"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    btop
    curl
    fastfetch
    git
    lm_sensors
    lsof
    vim
    wget
  ];

  environment.variables = {
    # KUBECONFIG = /etc/rancher/k3s/k3s.yaml;
  };

  # Services to start
  services.openssh = {
    enable = true;
    ports = [ 222 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "root" ]; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = false;
      X11Forwarding = false;
      PermitRootLogin = "yes"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      222
      443
    ];
  };

  system.stateVersion = "25.05";
}
