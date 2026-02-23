{config, lib, pkgs, style, ...}:

{
  programs.kitty = {
    enable = true;
    font = { name = "NotoMono Nerd Font"; size = 12; };
    shellIntegration.enableFishIntegration = true;
    settings = {
      shell = "${pkgs.fish}/bin/fish";
    };
    extraConfig = ''
      # Basic Colors
      foreground #ffffff
      # background #242424
      background #111111

      # Cursor & Selection (Estimated based on colors)
      selection_foreground #ffffff
      selection_background #24acd4

      # Standard Colors
      color0  #242424
      color1  #f62b5a
      color2  #47b413
      color3  #e3c401
      color4  #24acd4
      color5  #f2affd
      color6  #13c299
      color7  #e6e6e6

      # Bright Colors
      color8  #616161
      color9  #ff4d51
      color10 #35d450
      color11 #e9e836
      color12 #5dc5f8
      color13 #feabf2
      color14 #24dfc4
      color15 #ffffff

      # Keybinds
      map ctrl+c copy_to_clipboard
      map ctrl+v paste_from_clipboard
      # Map Ctrl+Shift+C to send the interrupt signal (SIGINT)
      map ctrl+shift+c send_text all \x03

    '';
  };
}