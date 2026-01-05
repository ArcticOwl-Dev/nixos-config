{config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
    nemo
    gnome-themes-extra  # Provides Adwaita-dark theme
    gvfs                # Virtual filesystem support (needed for Nemo)
  ];

  # Configure GTK to use dark theme
  # Note: icon theme is already set globally in dankLinuxBar.nix
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  # Set dark color scheme preference for GTK4/libadwaita apps
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";  # For libadwaita/GTK-4 apps
      gtk-theme = "Adwaita-dark";
    };
    "org/cinnamon/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
    };
  };

  # Set GTK_THEME environment variable for GTK3 apps like Nemo
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
  };

  # Create a desktop entry in ~/.local/share/applications/ so launchers can find it
  # This ensures vicinae and DankMaterialShell can discover Nemo
  # Using direct file creation for maximum compatibility and control
  home.file.".local/share/applications/nemo.desktop" = {
    text = ''
      [Desktop Entry]
      Version=1.0
      Type=Application
      Name=Nemo
      GenericName=File Manager
      Comment=Access and organize files
      Exec=nemo %U
      Icon=system-file-manager
      Terminal=false
      Categories=Utility;FileManager;GTK;
      MimeType=inode/directory;application/x-gnome-saved-search;
      Keywords=files;folders;filemanager;explorer;nemo;
      StartupNotify=false
    '';
  };
}