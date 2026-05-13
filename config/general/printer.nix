{ pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];  

  # Ensure your user is in the correct groups
  #users.users.YOUR_USERNAME.extraGroups = [ "lp" ];
}