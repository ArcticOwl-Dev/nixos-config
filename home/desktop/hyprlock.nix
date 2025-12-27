{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Copy wallpaper to a standard location
  home.file.".local/share/wallpapers/tf2.png" = {
    source = ./../../assets/wallpaper/tf2.png;
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        immediate_render = true;
        hide_cursor = false;
        no_fade_in = true;
        grace = 0;
      };

      animation = [
        "inputFieldDots, 1, 2, linear"
        "fadeIn, 0"
      ];

      background = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/.local/share/wallpapers/tf2.png";
        }
      ];

      label = [
        # TIME
        {
          monitor = "";
          text = "$TIME";
          font_size = 150;
          color = "rgb(b6c4ff)";
          font_family = "profont";

          position = "4%, 30%";

          valign = "center";
          halign = "left";

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
        # DATE
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          font_size = 20;
          color = "rgb(b6c4ff)";
          font_family = "profont";

          position = "4%, 38%";

          valign = "center";
          halign = "left";

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 20;
          shadow_passes = 2;
          shadow_boost = 0.3;
        }
        # USERNAME
        # {
        #   monitor = "";
        #   text = "Hi $USER";
        #   font_size = 28;
        #   color = "rgb(b6c4ff)";

        #   position = "5%, 14%";

        #   valign = "bottom";
        #   halign = "left";

        #   shadow_color = "rgba(0, 0, 0, 0.2)";
        #   shadow_size = 10;
        #   shadow_passes = 2;
        #   shadow_boost = 0.3;
        # }
      ];
      input-field = [
        # PASSWORD
        {
          monitor = "";

          size = "300, 50";

          valign = "bottom";
          halign = "left";
          position = "6%, 10%";

          outline_thickness = 1;

          font_color = "rgb(b6c4ff)";
          outer_color = "rgba(180, 180, 180, 0.5)";
          inner_color = "rgba(200, 200, 200, 0.1)";
          check_color = "rgba(247, 193, 19, 0.5)";
          fail_color = "rgba(255, 106, 134, 0.5)";

          font_family = "NotoMonoNF";
          fade_on_empty = false;
          placeholder_text = "  Password";
          hide_input = false;

          dots_spacing = 0.2;
          dots_center = true;
          dots_fade_time = 100;

          shadow_color = "rgba(0, 0, 0, 0.1)";
          shadow_size = 7;
          shadow_passes = 2;
        }
      ];
    };
  };
}
