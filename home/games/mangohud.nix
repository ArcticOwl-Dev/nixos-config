{config, lib, pkgs, ...}:
{

  home.packages = with pkgs; [ goverlay ];
  
  programs.mangohud = {
    enable = true;
    enableSessionWide = false;
    settings = {
      # Removed fps_limit to avoid capping performance
      # fps_limit = 144;  # Commented out - was limiting FPS
      
      # Performance monitoring settings
      fps = true;
      frametime = true;
      gpu_stats = true;
      gpu_temp = true;
      cpu_stats = true;
      cpu_temp = true;
      vram = true;
      ram = true;
      
      # Position and style
      position = "top-left";
      text_color = "FFFFFF";
      background_alpha = "0.3";
    };
  };
}