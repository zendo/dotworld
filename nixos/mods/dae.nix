{ lib, config, ... }:
let
  cfg = config.mods.daeWithConfig;
in
{
  options.mods.daeWithConfig = {
    enable = lib.mkEnableOption ''
      my dae encryption config.
    '';
  };

  config = lib.mkIf cfg.enable {
    services.dae = {
      enable = true;
      # configFile = "/home/iab/dev/config.dae";
      configFile = config.sops.templates."config.dae".path;
    };

    sops.secrets = {
      dae-sub = { };
    };

    sops.templates."config.dae".content = ''
      global {
        # Bind to LAN and/or WAN as you want. Replace the interface name to your own.
        #lan_interface: docker0
        wan_interface: auto # Use "auto" to auto detect WAN interface.

        log_level: info
        allow_insecure: false
        auto_config_kernel_parameter: true
      }

      subscription {
        airport: '${config.sops.placeholder."dae-sub"}'
      }

      # See https://github.com/daeuniverse/dae/blob/main/docs/en/configuration/dns.md for full examples.
      dns {
        upstream {
          googledns: 'tcp+udp://dns.google:53'
          alidns: 'udp://dns.alidns.com:53'
        }
        routing {
          request {
            qtype(https) -> reject
            fallback: alidns
          }
          response {
            upstream(googledns) -> accept
            ip(geoip:private) && !qname(geosite:cn) -> googledns
            fallback: accept
          }
        }
      }

      group {
        proxy {
          #filter: name(keyword: HK, keyword: SG)
          policy: min_moving_avg
        }
      }

      # See https://github.com/daeuniverse/dae/blob/main/docs/en/configuration/routing.md for full examples.
      routing {
        pname(NetworkManager) -> direct
        dip(224.0.0.0/3, 'ff00::/8') -> direct

        ### Write your rules below.

        # Disable h3 because it usually consumes too much cpu/mem resources.
        l4proto(udp) && dport(443) -> block
        dip(geoip:private) -> direct
        dip(geoip:cn) -> direct
        domain(geosite:cn) -> direct

        fallback: proxy
      }
    '';
  };
}
