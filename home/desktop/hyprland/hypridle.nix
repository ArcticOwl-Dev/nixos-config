{ config, lib, pkgs, ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
    {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        # 10 minutes - lock screen
        {
          timeout = 600; 
          on-timeout = "hyprlock";
        }
        # 15 minutes - lower brightness to 50%
        {
          timeout = 900;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        # 20 minutes - turn off display
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
        }
        # 60 minutes - suspend pc
        {
          timeout = 1800;                                  
          on-timeout = "systemctl suspend && rgb:kbd_backlight set 0";                
        }
      ];
    }
    };
  };
}



