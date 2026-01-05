# Home Manager configuration for stardust
{ config, lib, pkgs, inputs, style, ... }:
{
  imports = [
    ../../home/scripts/default.nix

    ../../home/browser/brave.nix
    ../../home/browser/firefox.nix

    ../../home/cli/cli.nix
    ../../home/cli/git.nix

    ../../home/desktop/hyprland/hyprland.nix
    ../../home/desktop/wlogout.nix
    ../../home/desktop/hyprlock.nix
    ../../home/desktop/awww.nix
    ../../home/desktop/dankLinux/dankLinuxBar.nix
    ../../home/desktop/screenshot.nix
    
    ../../home/fileManager/nemo.nix
    
    ../../home/appLauncher/vicinae.nix

    ../../home/office/pdfViewer-Okular.nix
    ../../home/office/imageViewer-nomacs.nix
    ../../home/office/videoViewer-vlc.nix
    ../../home/office/office-onlyOffice.nix
    ../../home/office/email-thunderbird.nix

    #../../home/games/mangohud.nix
  ];

  home = {
    username = "r00t";
    homeDirectory = "/home/r00t";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # ============================================================================
  # Application Preferences - Change these to quickly switch default apps
  # ============================================================================
  # Find desktop file names in: /run/current-system/sw/share/applications/
  # or ~/.local/share/applications/
  # Common alternatives:
  #   Browser: "brave-browser.desktop", "firefox.desktop", "chromium.desktop"
  #   Image Viewer: "org.kde.gwenview.desktop", "feh.desktop", "imv.desktop"
  #   Code Editor: "cursor.desktop", "code.desktop", "nvim.desktop", "micro.desktop"
  #   PDF Viewer: "org.kde.okular.desktop", "org.pwmt.zathura.desktop", "firefox.desktop"
  #   Video Player: "vlc.desktop", "mpv.desktop", "org.kde.dragonplayer.desktop"
  #   Audio Player: "vlc.desktop", "mpv.desktop", "org.kde.elisa.desktop"
  #   Archive Manager: "org.kde.ark.desktop", "file-roller.desktop"
  # ============================================================================
  
  # Set default applications for MIME types
  # These associations are used by Dolphin and other file managers
  xdg.mimeApps.defaultApplications = let
    # Application preferences - change these variables to switch defaults
    webBrowser = "brave-browser.desktop";
    imageViewer = "org.kde.gwenview.desktop";
    codeEditor = "cursor.desktop";
    textEditor = "micro.desktop";
    pdfViewer = "org.kde.okular.desktop";
    videoPlayer = "vlc.desktop";
    audioPlayer = "vlc.desktop";
    archiveManager = "org.kde.ark.desktop";
  in {
    # TEXT TYPES (Official IANA registered)
    "text/plain" = codeEditor;
    "text/html" = webBrowser;
    "text/css" = codeEditor;
    "text/javascript" = codeEditor;
    "text/xml" = codeEditor;
    "text/csv" = codeEditor;
    "text/calendar" = codeEditor;
    "text/markdown" = codeEditor;
    "text/vcard" = codeEditor;
    "text/vtt" = codeEditor;
    "text/richtext" = codeEditor;
    "text/enriched" = codeEditor;
    "text/sgml" = codeEditor;
    "text/tab-separated-values" = codeEditor;
    "text/uri-list" = codeEditor;
    
    # APPLICATION TYPES (Official IANA registered)
    # Web/Internet
    "application/xhtml+xml" = webBrowser;
    "application/json" = codeEditor;
    "application/xml" = codeEditor;
    "application/javascript" = codeEditor;
    "application/ecmascript" = codeEditor;
    
    # Documents
    "application/pdf" = pdfViewer;
    "application/rtf" = codeEditor;
    "application/postscript" = pdfViewer;
    
    # Office Documents
    "application/msword" = codeEditor;
    "application/vnd.ms-excel" = codeEditor;
    "application/vnd.ms-powerpoint" = codeEditor;
    "application/vnd.ms-word" = codeEditor;
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = codeEditor;
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = codeEditor;
    "application/vnd.openxmlformats-officedocument.presentationml.presentation" = codeEditor;
    "application/vnd.oasis.opendocument.text" = codeEditor;
    "application/vnd.oasis.opendocument.spreadsheet" = codeEditor;
    "application/vnd.oasis.opendocument.presentation" = codeEditor;
    
    # Archives/Compression (Official)
    "application/zip" = archiveManager;
    "application/gzip" = archiveManager;
    
    # Fonts (Official)
    "font/ttf" = codeEditor;
    "font/otf" = codeEditor;
    "font/woff" = codeEditor;
    "font/woff2" = codeEditor;
    "application/font-woff" = codeEditor;
    "application/font-woff2" = codeEditor;
    
    # Other Application Types (Official)
    "application/octet-stream" = codeEditor;
    "application/java-archive" = codeEditor;
    "application/rss+xml" = webBrowser;
    "application/atom+xml" = webBrowser;
    "application/vnd.api+json" = codeEditor;
    "application/ld+json" = codeEditor;
    
    # IMAGE TYPES (Official IANA registered)
    "image/jpeg" = imageViewer;
    "image/png" = imageViewer;
    "image/gif" = imageViewer;
    "image/webp" = imageViewer;
    "image/svg+xml" = imageViewer;
    "image/bmp" = imageViewer;
    "image/tiff" = imageViewer;
    "image/vnd.microsoft.icon" = imageViewer;
    "image/apng" = imageViewer;
    "image/avif" = imageViewer;
    "image/heic" = imageViewer;
    "image/heif" = imageViewer;
    
    # AUDIO TYPES (Official IANA registered)
    "audio/mpeg" = audioPlayer;
    "audio/ogg" = audioPlayer;
    "audio/wav" = audioPlayer;
    "audio/wave" = audioPlayer;
    "audio/flac" = audioPlayer;
    "audio/aac" = audioPlayer;
    "audio/mp4" = audioPlayer;
    "audio/webm" = audioPlayer;
    "audio/opus" = audioPlayer;
    "audio/basic" = audioPlayer;
    "audio/midi" = audioPlayer;
    
    # VIDEO TYPES (Official IANA registered)
    "video/mp4" = videoPlayer;
    "video/mpeg" = videoPlayer;
    "video/ogg" = videoPlayer;
    "video/webm" = videoPlayer;
    "video/quicktime" = videoPlayer;
    "video/3gpp" = videoPlayer;
    "video/3gpp2" = videoPlayer;
    "video/h264" = videoPlayer;
    "video/h265" = videoPlayer;
    
    # MESSAGE TYPES (Official IANA registered)
    "message/rfc822" = codeEditor;
    "message/http" = webBrowser;
    
    # MULTIPART TYPES (Official IANA registered)
    "multipart/form-data" = webBrowser;
    "multipart/mixed" = codeEditor;
    "multipart/alternative" = codeEditor;
    
    # MODEL TYPES (Official IANA registered)
    "model/obj" = codeEditor;
    "model/stl" = codeEditor;
    "model/gltf+json" = codeEditor;
    "model/gltf-binary" = codeEditor;
    
    # URL SCHEME HANDLERS
    "x-scheme-handler/http" = webBrowser;
    "x-scheme-handler/https" = webBrowser;
    "x-scheme-handler/ftp" = webBrowser;
    "x-scheme-handler/file" = codeEditor;
    
    # ============================================================================
    # UNOFFICIAL/EXPERIMENTAL TYPES (Common but not IANA registered)
    # ============================================================================
    # Programming Languages (using x- prefix for experimental types)
    "text/x-python" = codeEditor;
    "text/x-shellscript" = codeEditor;
    "text/x-nix" = codeEditor;
    "text/x-markdown" = codeEditor;
    "text/x-html" = codeEditor;
    "text/x-css" = codeEditor;
    "text/x-javascript" = codeEditor;
    "text/x-typescript" = codeEditor;
    "text/x-php" = codeEditor;
    "text/x-java" = codeEditor;
    "text/x-c" = codeEditor;
    "text/x-cpp" = codeEditor;
    "text/x-c++" = codeEditor;
    "text/x-rust" = codeEditor;
    "text/x-go" = codeEditor;
    "text/x-ruby" = codeEditor;
    "text/x-perl" = codeEditor;
    "text/x-lua" = codeEditor;
    "text/x-sql" = codeEditor;
    "text/x-log" = codeEditor;
    "text/x-conf" = codeEditor;
    "text/x-ini" = codeEditor;
    "text/x-toml" = codeEditor;
    
    # Configuration/Data Formats (unofficial)
    "text/yaml" = codeEditor;
    "text/x-yaml" = codeEditor;
    "application/x-yaml" = codeEditor;
    "text/x-mysql" = codeEditor;
    "text/x-postgresql" = codeEditor;
    "text/x-sqlite" = codeEditor;
    "text/x-mongodb" = codeEditor;
    "text/x-redis" = codeEditor;
    "text/x-memcached" = codeEditor;
    "text/x-couchdb" = codeEditor;
    "text/x-solr" = codeEditor;
    "text/x-elasticsearch" = codeEditor;
    
    # Archive Types (unofficial - x- prefix)
    "application/x-tar" = archiveManager;
    "application/x-gzip" = archiveManager;
    "application/x-bzip2" = archiveManager;
    "application/x-7z-compressed" = archiveManager;
    "application/x-rar-compressed" = archiveManager;
    "application/x-zip-compressed" = archiveManager;
    "application/x-lzip" = archiveManager;
    "application/x-lzma" = archiveManager;
    "application/x-xz" = archiveManager;
    "application/x-compress" = archiveManager;
    "application/x-compressed-tar" = archiveManager;
    "application/x-bzip-compressed-tar" = archiveManager;
    "application/x-xz-compressed-tar" = archiveManager;
    "application/x-rar" = archiveManager;
    
    # Font Types (unofficial - x- prefix)
    "application/x-font-ttf" = codeEditor;
    "application/x-font-otf" = codeEditor;
    
    # Application Types (unofficial - x- prefix)
    "application/x-www-form-urlencoded" = webBrowser;
    "application/x-shockwave-flash" = webBrowser;
    
    # Image Types (unofficial)
    "image/jpg" = imageViewer;  # Alias for image/jpeg
    "image/x-icon" = imageViewer;  # Unofficial (official is image/vnd.microsoft.icon)
    
    # Video Types (unofficial - x- prefix)
    "video/x-msvideo" = videoPlayer;
    "video/x-ms-wmv" = videoPlayer;
    "video/x-matroska" = videoPlayer;
    "video/x-flv" = videoPlayer;
    "video/x-ms-asf" = videoPlayer;
    
    # Audio Types (unofficial - x- prefix)
    "audio/x-wav" = audioPlayer;  # Unofficial (official is audio/wav)
    "audio/x-midi" = audioPlayer;  # Unofficial (official is audio/midi)
    "audio/x-m4a" = audioPlayer;
    "audio/x-aac" = audioPlayer;
  };

  home.stateVersion = "25.11";
}

