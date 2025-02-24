/*
  # Deployment
  deploy -s .#svp
  or
  nixos-rebuild --target-host aaa@192.168.122.20 --flake .#rmt switch --ask-sudo-password
*/
{ inputs, ... }:
{
  flake.deploy = {
    # sudo = "doas -u";
    sshUser = "root";
    autoRollback = false;
    magicRollback = false;
    fastConnection = true; # copy from ssh
    nodes = {
      "svp" = {
        hostname = "192.168.1.197";
        profiles.system = {
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations."svp";
        };
      };

      "rmt" = {
        hostname = "192.168.122.78";
        profiles.system = {
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations."rmt";
        };
      };
    };
  };
}
