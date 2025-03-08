{ lib, config, ... }:
{
  networking = {
    networkmanager = {
      enable = true; # conflict with `networking.wireless`
      # dns = "none"; # for Transparent Proxy
      wifi.backend = "iwd"; # replace "wpa_supplicant"
      plugins = lib.mkForce [ ]; # include openconnect(webkitgtk)
    };

    nameservers = [
      "8.8.8.8"
      "1.1.1.1"
    ];

    firewall = {
      enable = false;
      # allowedUDPPorts = [ 53317 ];
      # allowedTCPPorts = [ 53317 ];
    };

    # ping github.com
    # hosts = {
    #   "20.205.243.166" = ["github.com"];
    # };
  };

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = lib.mkDefault false;
    };

    # Use systemd-resolved for DNS
    resolved = {
      enable = true;
      # fallbackDns = config.networking.nameservers;
    };

    # opensnitch.enable = true;

    # Enable CUPS to print documents.
    # printing.enable = true;

    # Publish this server and its address on the network
    avahi = {
      enable = true;
      nssmdns4 = true;
      # publish = {
      #   enable = true;
      #   domain = true;
      #   addresses = true;
      #   workstation = true;
      # };
    };
  };
}
