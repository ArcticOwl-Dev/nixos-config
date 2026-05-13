{ pkgs, ... }: {

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];

  # Ensure your user is in the correct groups
  #users.users.YOUR_USERNAME.extraGroups = [ "scanner" "lp" ];

  # Open firewall ports for network discovery (mDNS/Avahi)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}