{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {

    bind = [

      # Window Control
      "SUPER, Q, killactive"                                                                   # Close window (Super + Q)
      "SUPER SHIFT, Q, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"      # Quit active window and all open instances

      "SUPER, F, fullscreen, 0"                                                                # Set active window to fullscreen
      "SUPER, M, fullscreen, 1"                                                                # Maximize Window
      "SUPER, T, togglefloating"                                                               # Toggle active windows into floating mode
      "SUPER SHIFT, T, workspaceopt, allfloat"                                                 # Toggle all windows into floating mode
      "SUPER, J, togglesplit"                                                                  # Toggle split

      "SUPER SHIFT, right, resizeactive, 100 0"                                                # Increase window width with keyboard
      "SUPER SHIFT, left, resizeactive, -100 0"                                                # Reduce window width with keyboard
      "SUPER SHIFT, down, resizeactive, 0 100"                                                 # Increase window height with keyboard
      "SUPER SHIFT, up, resizeactive, 0 -100"                                                  # Reduce window height with keyboard

      "SUPER, G, togglegroup"                                                                  # Toggle window group
      "SUPER, K, swapsplit"                                                                    # Swapsplit

      "SUPER ALT, left, swapwindow, l"                                                         # Swap tiled window left
      "SUPER ALT, right, swapwindow, r"                                                        # Swap tiled window right
      "SUPER ALT, up, swapwindow, u"                                                           # Swap tiled window up
      "SUPER ALT, down, swapwindow, d"                                                         # Swap tiled window down

      "SUPER, left, movefocus, l"                                                              # Move focus left
      "SUPER, right, movefocus, r"                                                             # Move focus right
      "SUPER, up, movefocus, u"                                                                # Move focus up
      "SUPER, down, movefocus, d"                                                              # Move focus down 

      # Workspaces
      "SUPER, 1, workspace, 1"                                                                 # Open workspace 1
      "SUPER, 2, workspace, 2"                                                                 # Open workspace 2
      "SUPER, 3, workspace, 3"                                                                 # Open workspace 3
      "SUPER, 4, workspace, 4"                                                                 # Open workspace 4
      "SUPER, 5, workspace, 5"                                                                 # Open workspace 5
      "SUPER, 6, workspace, 6"                                                                 # Open workspace 6
      "SUPER, 7, workspace, 7"                                                                 # Open workspace 7
      "SUPER, 8, workspace, 8"                                                                 # Open workspace 8
      "SUPER, 9, workspace, 9"                                                                 # Open workspace 9

      "SUPER SHIFT, 1, movetoworkspacesilent, 1"                                                     # Move active window to workspace 1
      "SUPER SHIFT, 2, movetoworkspacesilent, 2"                                                     # Move active window to workspace 2
      "SUPER SHIFT, 3, movetoworkspacesilent, 3"                                                     # Move active window to workspace 3
      "SUPER SHIFT, 4, movetoworkspacesilent, 4"                                                     # Move active window to workspace 4
      "SUPER SHIFT, 5, movetoworkspacesilent, 5"                                                     # Move active window to workspace 5
      "SUPER SHIFT, 6, movetoworkspacesilent, 6"                                                     # Move active window to workspace 6
      "SUPER SHIFT, 7, movetoworkspacesilent, 7"                                                     # Move active window to workspace 7
      "SUPER SHIFT, 8, movetoworkspacesilent, 8"                                                     # Move active window to workspace 8
      "SUPER SHIFT, 9, movetoworkspacesilent, 9"                                                     # Move active window to workspace 9

      # Actions
      "SUPER, SPACE, exec, vicinae toggle"                                                     # Launch appLauncher vicinae (Super + Space)
      "SUPER, ENTER, exec, foot"                                                              # Launch terminal (Super + ENTER)
      "SUPER, B, exec, firefox"                                                                   # Launch browser (Super + B)
      "SUPER, E, exec, foot"                                                                   # Launch Filemanager (Super + E) TODO: Add filemanager
      "SUPER, V, exec, $SCRIPTS/cliphist.sh"                                                    # Open clipboard manager

      "SUPER SHIFT, S, exec, notify-send 'FIXME: SCREENSHOT'"                                 # Take a screenshot (Super + Shift + S) TODO: Add screenshot
      "SUPER CTRL, K, exec, $HYPRSCRIPTS/keybindings.sh"                                      # Show keybindings
      "SUPER CTRL, B, exec, ~/.config/waybar/toggle.sh"                                       # Toggle waybar
      "SUPER ALT, G, exec, $HYPRSCRIPTS/gamemode.sh"                                          # Toggle game mode

      # Fn keys
#      "XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"             # Increase volume by 5% (max 100% limit also added hold to raise volume)
#      "XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"                  # Reduce volume by 5% (min 0% limit also added hold to lower volume)
#      "XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"                         # Toggle mute
#      "XF86AudioPlay, exec, playerctl play-pause"                                              # Audio play pause
#      "XF86AudioPause, exec, playerctl pause"                                                  # Audio pause
#      "XF86AudioNext, exec, playerctl next"                                                    # Audio next
#      "XF86AudioPrev, exec, playerctl previous"                                                # Audio previous

    ];

    binde = [
      "SUPER, Tab, cyclenext"                                                                       # Cycle between windows
      "SUPER, Tab, bringactivetotop"                                                                # Bring active window to the top
    ];

    bindm = [
      "SUPER, mouse:272, movewindow"                                                           # Move window with the mouse (left mouse button)
      "SUPER, mouse:273, resizewindow"                                                         # Resize window with the mouse (right mouse button)
    ];
  };
}