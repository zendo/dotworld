/*
  mkdir -p ~/.config/sops/age

  # Generate a new key [keyFile]
  age-keygen -o ~/.config/sops/age/keys.txt
  # or Using own private ssh key
  ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt
  # or Remote host [sshKeyPaths]
  cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age
  sudo ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key | age-keygen -y

  # Print out public key and add in .sops.yaml
  age-keygen -y ~/.config/sops/age/keys.txt

  # Update all secrets when add new key
  sops updatekeys nixos/secrets/secrets.yaml

  # Decrypt and show the real value
  sops --extract '["hello"]' --decrypt secrets/secrets.yaml
*/
{ inputs, username, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # keyFile = "/home/${username}/.config/sops/age/keys.txt";
    };
  };
}
