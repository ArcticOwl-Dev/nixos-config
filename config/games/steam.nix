# Steam gaming configuration
# This should be in NixOS (not Home Manager) because Steam requires:
# - System-level OpenGL/Vulkan setup
# - Hardware access (GPU, input devices)
# - Firewall rules at system level
{ config, lib, pkgs, ... }:
{
  # Enable hardware acceleration (OpenGL/Vulkan)
  # This is required for Steam games to work properly
  # Note: hardware.opengl was renamed to hardware.graphics in NixOS 24.11+
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # Required for 32-bit games (replaces driSupport32Bit)
  };

  # AMD GPU configuration for better performance
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  # AMD GPU performance settings
  boot.kernelParams = [
    "amdgpu.ppfeaturemask=0xffffffff"  # Enable all AMD GPU features
    "amdgpu.gpu_recovery=1"            # Enable GPU recovery
  ];

  # CPU performance governor (set to performance mode for gaming)
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    # Enable gamescope for better performance and frame pacing
    gamescopeSession.enable = true;
  };

  # Enable AppImage support (many games use AppImages)
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Performance monitoring and optimization tools
  environment.systemPackages = with pkgs; [
    protonup-qt
    heroic
    vkbasalt  # Vulkan post-processing for better visuals
    steamtinkerlaunch
      # MangoHud configuration GUI
  ];

  # Environment variables for better gaming performance
  environment.sessionVariables = {
    # Vulkan settings
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
    # Disable vsync for lower latency (can be overridden per-game)
    __GL_SYNC_TO_VBLANK = "0";
    # AMD GPU performance
    AMD_VULKAN_ICD = "RADV";
    RADV_PERFTEST = "gpl";  # Enable RADV performance features
  };



}

