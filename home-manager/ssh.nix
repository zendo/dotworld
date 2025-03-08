{ ... }:
{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        HostName ssh.github.com
        Port 443

      Host yoga
        HostName 192.168.1.118
        Port 22
        User root

      Host svp
        HostName 192.168.1.197
        Port 22
        User root

      Host rmt
        HostName 192.168.122.20
        Port 22
        User root

      #ProxyCommand nc -X 5 -x 127.0.0.1:7890 %h %p
    '';
  };
}
