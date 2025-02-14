{
  config,
  pkgs,
  host,
  ...
}:
{
  services.sing-box = {
    enable = true;
    settings = {
      log = {
        level = "trace";
        timestamp = true;
      };
      inbounds = [
        {
          type = "vless";
          tag = "vless-in";
          listen = "::"; # 监听所有 IPv6 和 IPv4
          listen_port = 8443;
          users = [
            {
              name = "lockey";
              uuid = "2da2daf0-5837-4598-b6ce-11c00147f2e2";
              flow = "";
            }
          ];
          tls = {
            enabled = true;
            server_name = "gateway.icloud.com";
            reality = {
              enabled = true;
              handshake = {
                server = "gateway.icloud.com";
                server_port = 443;
              };
              private_key = "8Nvzywz25nEjoEAaSrB2zOpn5HnkZvszBqmSjkuVp2s";
              short_id = [
                "1b64346f"
              ];
            };
          };
        }
        {
          type = "hysteria2";
          tag = "hy2-in";
          listen = "::";
          listen_port = 30000;
          users = [
            {
              name = "lockey";
              password = "lockey";
            }
          ];
          ignore_client_bandwidth = false;
          tls = {
            enabled = true;
            server_name = "www.bing.com";
            alpn = [
              "h3"
            ];
            certificate_path = "/root/.config/hy/ca.crt";
            key_path = "/root/.config/hy/ca.key";
          };
        }
      ];
      outbounds = [
        {
          type = "direct";
          tag = "direct";
        }
      ];
      route = {
        rules = [
          {
            inbound = "vless-in";
            action = "resolve";
            strategy = "prefer_ipv4";
          }
          {
            inbound = "vless-in";
            action = "sniff";
            timeout = "1s";
          }
          {
            inbound = "hy2-in";
            action = "resolve";
            strategy = "prefer_ipv4";
          }
          {
            inbound = "hy2-in";
            action = "sniff";
            timeout = "1s";
          }
          # {
          #   rule_set = [
          #     "geoip-cn"
          #     "geosite-cn"
          #   ];
          #   action = "reject";
          # }
        ];
        final = "direct";
        # rule_set = [
        #   {
        #     tag = "geoip-cn";
        #     type = "remote";
        #     format = "binary";
        #     url = "https://github.com/MetaCubeX/meta-rules-dat/raw/sing/geo-lite/geoip/cn.srs";
        #   }
        #   {
        #     tag = "geosite-cn";
        #     type = "remote";
        #     format = "binary";
        #     url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs";
        #   }
        # ];
      };
      experimental = {
        cache_file = {
          enabled = true; # required to save rule-set cache
        };
      };
    };
  };
  networking.firewall = {
    allowedTCPPorts = [
      8443
    ];
    allowedUDPPorts = [ 30000 ];
  };
}
