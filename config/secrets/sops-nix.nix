# sops-nix — store encrypted secrets in git, decrypt at boot / login.
# https://github.com/Mic92/sops-nix
#
# Bootstrap (once per machine/repo):
#   1) age-keygen -o secrets/age.key   # gitignored; back it up safely
#   2) Put the matching public key in `.sops.yaml` under `creation_rules` → `age`.
#   3) sudo install -D -m600 secrets/age.key /var/lib/sops-nix/key.txt
#   4) sudo env SOPS_AGE_KEY_FILE=/var/lib/sops-nix/key.txt \ sops /home/r00t/nixos-config/config/secrets/secrets.yaml
#
{ inputs, pkgs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  environment.systemPackages = [
    pkgs.sops
    pkgs.age
    pkgs.ssh-to-age
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";

    # Decryption key on the NixOS host (copy from secrets/age.key once).
    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = false;
    };

    # Avoid requiring the age key on the machine where you run `nix build`.
    validateSopsFiles = false;

    secrets = {
      # Tailscale pre-auth key from https://login.tailscale.com/admin/settings/keys
      # (type "auth", starts with tskey-auth-). Not the Tailscale API key.
      # Readable by r00t for Remote Touchpad (user systemd); root (tailscaled) can read too.
      tailscale-auth-key = {
        owner = "r00t";
        mode = "0400";
      };
    };
  };
}
