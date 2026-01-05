{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {

    bindd = [
      # Window Control
      "SUPER, Q, Close active window, killactive"
      "SUPER SHIFT, Q, Quit active window and all instances, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"

      "SUPER, F, Toggle fullscreen, fullscreen, 0"
      "SUPER, M, Maximize window, fullscreen, 1"
      "SUPER, T, Toggle floating mode, togglefloating"
      "SUPER SHIFT, T, Toggle all windows floating, workspaceopt, allfloat"
      "SUPER, J, Toggle split, togglesplit"

      "SUPER, G, Toggle window group, togglegroup"
      "SUPER, K, Swap split, swapsplit"

      "SUPER ALT, left, Swap window left, swapwindow, l"
      "SUPER ALT, right, Swap window right, swapwindow, r"
      "SUPER ALT, up, Swap window up, swapwindow, u"
      "SUPER ALT, down, Swap window down, swapwindow, d"

      "SUPER, left, Move focus left, movefocus, l"
      "SUPER, right, Move focus right, movefocus, r"
      "SUPER, up, Move focus up, movefocus, u"
      "SUPER, down, Move focus down, movefocus, d"

      # Workspaces
      "SUPER, 1, Switch to workspace 1, workspace, 1"
      "SUPER, 2, Switch to workspace 2, workspace, 2"
      "SUPER, 3, Switch to workspace 3, workspace, 3"
      "SUPER, 4, Switch to workspace 4, workspace, 4"
      "SUPER, 5, Switch to workspace 5, workspace, 5"
      "SUPER, 6, Switch to workspace 6, workspace, 6"
      "SUPER, 7, Switch to workspace 7, workspace, 7"
      "SUPER, 8, Switch to workspace 8, workspace, 8"
      "SUPER, 9, Switch to workspace 9, workspace, 9"

      "SUPER SHIFT, 1, Move window to workspace 1, movetoworkspacesilent, 1"
      "SUPER SHIFT, 2, Move window to workspace 2, movetoworkspacesilent, 2"
      "SUPER SHIFT, 3, Move window to workspace 3, movetoworkspacesilent, 3"
      "SUPER SHIFT, 4, Move window to workspace 4, movetoworkspacesilent, 4"
      "SUPER SHIFT, 5, Move window to workspace 5, movetoworkspacesilent, 5"
      "SUPER SHIFT, 6, Move window to workspace 6, movetoworkspacesilent, 6"
      "SUPER SHIFT, 7, Move window to workspace 7, movetoworkspacesilent, 7"
      "SUPER SHIFT, 8, Move window to workspace 8, movetoworkspacesilent, 8"
      "SUPER SHIFT, 9, Move window to workspace 9, movetoworkspacesilent, 9"

      # Actions
      "SUPER, SPACE, Launch application launcher, exec, vicinae toggle"
      "SUPER, Return, Launch terminal, exec, foot"
      "SUPER, B, Launch browser, exec, brave"
      "SUPER, E, Launch file manager, exec, nemo"
      "SUPER, V, Open clipboard manager, exec, vicinae vicinae://extensions/vicinae/clipboard/history"

      "SUPER SHIFT, S, Take screenshot with satty, exec, ~/.config/satty/screenshot-satty"
      "SUPER CTRL, B, Toggle taskbar, exec, dms ipc call bar toggle index 0"
      "SUPER ALT, G, Toggle game mode, exec, FIXME: GAMEMODE"
      "SUPER, L, Lock screen, exec, hyprlock"

      #scrolling Layout
      "SUPER, period, move colum right, layoutmsg, move +col"
      "SUPER, comma, move colum left, layoutmsg, move -col"

      # Fn keys (commented out)
#      "XF86AudioRaiseVolume, Increase volume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
#      "XF86AudioLowerVolume, Decrease volume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
#      "XF86AudioMute, Toggle mute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
#      "XF86AudioPlay, Play/Pause audio, exec, playerctl play-pause"
#      "XF86AudioPause, Pause audio, exec, playerctl pause"
#      "XF86AudioNext, Next track, exec, playerctl next"
#      "XF86AudioPrev, Previous track, exec, playerctl previous"
    ];

    binded = [
      "SUPER SHIFT, right, Increase window width, resizeactive, 100 0"
      "SUPER SHIFT, left, Decrease window width, resizeactive, -100 0"
      "SUPER SHIFT, down, Increase window height, resizeactive, 0 100"
      "SUPER SHIFT, up, Decrease window height, resizeactive, 0 -100"
      "SUPER, Tab, Cycle between windows, cyclenext"
      "SUPER, Tab, Bring active window to top, bringactivetotop"
    ];

    bindmd = [
      "SUPER, mouse:272, Move window, movewindow"
      "SUPER, mouse:273, Resize window, resizewindow"
    ];
  };
}