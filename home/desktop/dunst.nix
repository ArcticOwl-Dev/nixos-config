{ config, lib, pkgs, style, ... }:
let
  nerdFont = style.nerdFont;
in
{
  services.dunst = {
    enable = true;
    waylandDisplay = "WAYLAND_DISPLAY";
    settings = {
      global = {
        ### Display ###
        monitor = 0;
        follow = "none";

        ### Geometry ###
        width = "(0, 600)";
        height = 300;
        origin = "bottom-right";
        offset = "10x50";
        scale = 0;
        notification_limit = 0;

        ### Progress bar ###
        progress_bar = true;
        progress_bar_height = 5;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        indicate_hidden = true;
        transparency = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        text_icon_padding = 0;
        frame_width = 1;
        frame_color = "#22272e";
        gap_size = 0;
        separator_color = "#2d333b";
        sort = true;

        ### Text ###
        font = "${nerdFont}:size=12";
        line_height = 12;
        markup = "full";
        format = "<span foreground='#a97594'>%s:</span> %b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;

        ### Icons ###
        enable_recursive_icon_lookup = true;
        icon_theme = "${nerdFont}";
        icon_position = "left";
        min_icon_size = 24;
        max_icon_size = 24;

        ### History ###
        sticky_history = true;
        history_length = 20;

        # ### Misc/Advanced ###
        # dmenu = "/usr/bin/dmenu -p dunst:";
        # browser = "/usr/bin/xdg-open";
        # always_run_script = true;
        # title = "Dunst";
        # class = "Dunst";
        # corner_radius = 5;
        # ignore_dbusclose = false;
        # force_xinerama = false;

        ### mouse
        mouse_right_click = "close_current";
        mouse_left_click = "open_url, do_action, close_current";
        mouse_middle_click = "close_all";
      };

      experimental = {
        per_monitor_dpi = false;
      };

      urgency_low = {
        background = "#22272e";
        foreground = "#ffffff";
        timeout = 10;
      };

      urgency_normal = {
        background = "#22272e";
        foreground = "#ffffff";
        timeout = 10;
      };

      urgency_critical = {
        background = "#22272e";
        foreground = "#ffffff";
        timeout = 0;
      };

      # Rules
      "spotify" = {
        appname = "Spotify";
      };

      "image_uploader" = {
        summary = "Image Uploader";
        body = "Uploaded: *";
      };
    };
  };
}