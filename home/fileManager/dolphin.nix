{config, lib, pkgs, ...}:
{
    home.packages = with pkgs; [ 
    kdePackages.dolphin 
    kdePackages.qtsvg             # for svg support
    kdePackages.kio               
    kdePackages.kio-extras        # extra protocols support (sftp, fish and more)     
    kdePackages.kio-fuse          # to mount remote filesystems via FUSE
  ];

  # Configure Dolphin settings via dolphinrc
  # You can customize these settings as needed
  home.file.".config/dolphinrc".text = ''
    [General]
    ShowFullPath=false
    EditableUrl=true
    ShowSpaceInfo=true
    FilterBar=false
    GlobalViewProps=true
    BrowseThroughArchives=false
    ConfirmClosingMultipleTabs=true
    ConfirmClosingTerminal=true
    RenameInline=true
    ShowToolbar=true
    ShowMenubar=true
    ShowStatusBar=true
    
    [DetailsMode]
    PreviewSize=22
    
    [IconsMode]
    IconSize=48
    
    [CompactMode]
    MaximumTextLines=1
    
    [MainWindow]
    ToolBarsMovable=Disabled
  '';

  # Configure Dolphin view properties (optional)
  # This sets default view settings for folders
  home.file.".config/dolphin/view_properties/global/.directory".text = ''
    [Settings]
    ViewMode=1
    IconSize=48
    PreviewSize=22
  '';
}
