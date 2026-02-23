{ config, lib, pkgs, ... }:
{
  programs.plasma = {
    enable = true;

    # ==========================================================================
    # Shortcuts - Global keybindings
    # ==========================================================================
    shortcuts = {
      # --- Activity & Keyboard ---
      ActivityManager.switch-to-activity-fce0d3ca-65e9-47c4-b468-1de82c0b1622 = [ ];
      "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Meta+Alt+K";
      kaccess."Toggle Screen Reader On and Off" = "Meta+Alt+S";

      # --- Audio (kmix) ---
      kmix.decrease_microphone_volume = "Microphone Volume Down";
      kmix.decrease_volume = "Volume Down";
      kmix.decrease_volume_small = "Shift+Volume Down";
      kmix.increase_microphone_volume = "Microphone Volume Up";
      kmix.increase_volume = "Volume Up";
      kmix.increase_volume_small = "Shift+Volume Up";
      kmix.mic_mute = ["Microphone Mute" "Meta+Volume Mute"];
      kmix.mute = "Volume Mute";

      # --- Session (Lock, Log out, etc.) ---
      ksmserver."Halt Without Confirmation" = [ ];
      ksmserver."Lock Session" = ["Meta+L" "Screensaver"];
      ksmserver."Log Out" = "Ctrl+Alt+Del";
      ksmserver."Log Out Without Confirmation" = [ ];
      ksmserver.LogOut = [ ];
      ksmserver.Reboot = [ ];
      ksmserver."Reboot Without Confirmation" = [ ];
      ksmserver."Shut Down" = [ ];

      # --- Window Manager (KWin) ---
      kwin."Activate Window Demanding Attention" = "Meta+Ctrl+A";
      kwin."Cycle Overview" = [ ];
      kwin."Cycle Overview Opposite" = [ ];
      kwin."Decrease Opacity" = [ ];
      kwin."Edit Tiles" = "Meta+T";
      kwin.Expose = "Ctrl+F9";
      kwin.ExposeAll = ["Ctrl+F10" "Launch (C)"];
      kwin.ExposeClass = "Ctrl+F7";
      kwin.ExposeClassCurrentDesktop = [ ];
      kwin."Grid View" = "Meta+G";
      kwin."Increase Opacity" = [ ];
      kwin."KZones: Activate layout 1" = "Meta+Num+1";
      kwin."KZones: Activate layout 2" = "Meta+Num+2";
      kwin."KZones: Activate layout 3" = "Meta+Num+3";
      kwin."KZones: Activate layout 4" = "Meta+Num+4";
      kwin."KZones: Activate layout 5" = "Meta+Num+5";
      kwin."KZones: Activate layout 6" = "Meta+Num+6";
      kwin."KZones: Activate layout 7" = "Meta+Num+7";
      kwin."KZones: Activate layout 8" = "Meta+Num+8";
      kwin."KZones: Activate layout 9" = "Meta+Num+9";
      kwin."KZones: Cycle layouts" = "Ctrl+Alt+D";
      kwin."KZones: Cycle layouts (reversed)" = "Ctrl+Alt+Shift+D";
      kwin."KZones: Move active window down" = [ ];
      kwin."KZones: Move active window left" = [ ];
      kwin."KZones: Move active window right" = [ ];
      kwin."KZones: Move active window to next zone" = "Ctrl+Alt+Right";
      kwin."KZones: Move active window to previous zone" = "Ctrl+Alt+Left";
      kwin."KZones: Move active window to zone 1" = "Ctrl+Alt+Num+1";
      kwin."KZones: Move active window to zone 2" = "Ctrl+Alt+Num+2";
      kwin."KZones: Move active window to zone 3" = "Ctrl+Alt+Num+3";
      kwin."KZones: Move active window to zone 4" = "Ctrl+Alt+Num+4";
      kwin."KZones: Move active window to zone 5" = "Ctrl+Alt+Num+5";
      kwin."KZones: Move active window to zone 6" = "Ctrl+Alt+Num+6";
      kwin."KZones: Move active window to zone 7" = "Ctrl+Alt+Num+7";
      kwin."KZones: Move active window to zone 8" = "Ctrl+Alt+Num+8";
      kwin."KZones: Move active window to zone 9" = "Ctrl+Alt+Num+9";
      kwin."KZones: Move active window up" = [ ];
      kwin."KZones: Snap active window" = "Meta+Shift+Space";
      kwin."KZones: Snap all windows" = [ ];
      kwin."KZones: Switch to next window in current zone" = "Ctrl+Alt+Up";
      kwin."KZones: Switch to previous window in current zone" = "Ctrl+Alt+Down";
      kwin."KZones: Toggle zone overlay" = "Ctrl+Alt+C";
      kwin."Kill Window" = "Meta+Ctrl+Esc";
      kwin."Move Tablet to Next LogicalOutput" = [ ];
      kwin."Move Tablet to Next Output" = [ ];
      kwin.MoveMouseToCenter = "Meta+F6";
      kwin.MoveMouseToFocus = "Meta+F5";
      kwin.MoveZoomDown = [ ];
      kwin.MoveZoomLeft = [ ];
      kwin.MoveZoomRight = [ ];
      kwin.MoveZoomUp = [ ];
      kwin.Overview = "Meta+W";
      kwin."Remember Window Positions: Show Config" = "Meta+Ctrl+W";
      kwin."Setup Window Shortcut" = [ ];
      kwin."Show Desktop" = "Meta+D";
      kwin."Switch One Desktop Down" = "Meta+Ctrl+Down";
      kwin."Switch One Desktop Up" = "Meta+Ctrl+Up";
      kwin."Switch One Desktop to the Left" = "Meta+Ctrl+Left";
      kwin."Switch One Desktop to the Right" = "Meta+Ctrl+Right";
      kwin."Switch Window Down" = "Meta+Alt+Down";
      kwin."Switch Window Left" = "Meta+Alt+Left";
      kwin."Switch Window Right" = "Meta+Alt+Right";
      kwin."Switch Window Up" = "Meta+Alt+Up";
      kwin."Switch to Desktop 1" = "Ctrl+F1";
      kwin."Switch to Desktop 10" = [ ];
      kwin."Switch to Desktop 11" = [ ];
      kwin."Switch to Desktop 12" = [ ];
      kwin."Switch to Desktop 13" = [ ];
      kwin."Switch to Desktop 14" = [ ];
      kwin."Switch to Desktop 15" = [ ];
      kwin."Switch to Desktop 16" = [ ];
      kwin."Switch to Desktop 17" = [ ];
      kwin."Switch to Desktop 18" = [ ];
      kwin."Switch to Desktop 19" = [ ];
      kwin."Switch to Desktop 2" = "Ctrl+F2";
      kwin."Switch to Desktop 20" = [ ];
      kwin."Switch to Desktop 21" = [ ];
      kwin."Switch to Desktop 22" = [ ];
      kwin."Switch to Desktop 23" = [ ];
      kwin."Switch to Desktop 24" = [ ];
      kwin."Switch to Desktop 25" = [ ];
      kwin."Switch to Desktop 3" = "Ctrl+F3";
      kwin."Switch to Desktop 4" = "Ctrl+F4";
      kwin."Switch to Desktop 5" = [ ];
      kwin."Switch to Desktop 6" = [ ];
      kwin."Switch to Desktop 7" = [ ];
      kwin."Switch to Desktop 8" = [ ];
      kwin."Switch to Desktop 9" = [ ];
      kwin."Switch to Next Desktop" = [ ];
      kwin."Switch to Next Screen" = [ ];
      kwin."Switch to Previous Desktop" = [ ];
      kwin."Switch to Previous Screen" = [ ];
      kwin."Switch to Screen 0" = [ ];
      kwin."Switch to Screen 1" = [ ];
      kwin."Switch to Screen 2" = [ ];
      kwin."Switch to Screen 3" = [ ];
      kwin."Switch to Screen 4" = [ ];
      kwin."Switch to Screen 5" = [ ];
      kwin."Switch to Screen 6" = [ ];
      kwin."Switch to Screen 7" = [ ];
      kwin."Switch to Screen Above" = [ ];
      kwin."Switch to Screen Below" = [ ];
      kwin."Switch to Screen to the Left" = [ ];
      kwin."Switch to Screen to the Right" = [ ];
      kwin."Toggle Night Color" = [ ];
      kwin."Toggle Window Raise/Lower" = [ ];
      kwin."Walk Through Windows" = ["Meta+Tab" "Alt+Tab"];
      kwin."Walk Through Windows (Reverse)" = ["Meta+Shift+Tab" "Alt+Shift+Tab"];
      kwin."Walk Through Windows Alternative" = [ ];
      kwin."Walk Through Windows Alternative (Reverse)" = [ ];
      kwin."Walk Through Windows of Current Application" = ["Meta+`" "Alt+`"];
      kwin."Walk Through Windows of Current Application (Reverse)" = ["Meta+~" "Alt+~"];
      kwin."Walk Through Windows of Current Application Alternative" = [ ];
      kwin."Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
      kwin."Window Above Other Windows" = [ ];
      kwin."Window Below Other Windows" = [ ];
      kwin."Window Close" = "Alt+F4";
      kwin."Window Custom Quick Tile Bottom" = [ ];
      kwin."Window Custom Quick Tile Left" = [ ];
      kwin."Window Custom Quick Tile Right" = [ ];
      kwin."Window Custom Quick Tile Top" = [ ];
      kwin."Window Fullscreen" = [ ];
      kwin."Window Grow Horizontal" = [ ];
      kwin."Window Grow Vertical" = [ ];
      kwin."Window Lower" = [ ];
      kwin."Window Maximize" = "Meta+PgUp";
      kwin."Window Maximize Horizontal" = [ ];
      kwin."Window Maximize Vertical" = [ ];
      kwin."Window Minimize" = "Meta+PgDown";
      kwin."Window Move" = [ ];
      kwin."Window Move Center" = [ ];
      kwin."Window No Border" = [ ];
      kwin."Window On All Desktops" = [ ];
      kwin."Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
      kwin."Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
      kwin."Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
      kwin."Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
      kwin."Window One Screen Down" = [ ];
      kwin."Window One Screen Up" = [ ];
      kwin."Window One Screen to the Left" = [ ];
      kwin."Window One Screen to the Right" = [ ];
      kwin."Window Operations Menu" = "Alt+F3";
      kwin."Window Pack Down" = [ ];
      kwin."Window Pack Left" = [ ];
      kwin."Window Pack Right" = [ ];
      kwin."Window Pack Up" = [ ];
      kwin."Window Quick Tile Bottom" = "Meta+Down";
      kwin."Window Quick Tile Bottom Left" = [ ];
      kwin."Window Quick Tile Bottom Right" = [ ];
      kwin."Window Quick Tile Left" = "Meta+Left";
      kwin."Window Quick Tile Right" = "Meta+Right";
      kwin."Window Quick Tile Top" = "Meta+Up";
      kwin."Window Quick Tile Top Left" = [ ];
      kwin."Window Quick Tile Top Right" = [ ];
      kwin."Window Raise" = [ ];
      kwin."Window Resize" = [ ];
      kwin."Window Shrink Horizontal" = [ ];
      kwin."Window Shrink Vertical" = [ ];
      kwin."Window to Desktop 1" = [ ];
      kwin."Window to Desktop 10" = [ ];
      kwin."Window to Desktop 11" = [ ];
      kwin."Window to Desktop 12" = [ ];
      kwin."Window to Desktop 13" = [ ];
      kwin."Window to Desktop 14" = [ ];
      kwin."Window to Desktop 15" = [ ];
      kwin."Window to Desktop 16" = [ ];
      kwin."Window to Desktop 17" = [ ];
      kwin."Window to Desktop 18" = [ ];
      kwin."Window to Desktop 19" = [ ];
      kwin."Window to Desktop 2" = [ ];
      kwin."Window to Desktop 20" = [ ];
      kwin."Window to Desktop 3" = [ ];
      kwin."Window to Desktop 4" = [ ];
      kwin."Window to Desktop 5" = [ ];
      kwin."Window to Desktop 6" = [ ];
      kwin."Window to Desktop 7" = [ ];
      kwin."Window to Desktop 8" = [ ];
      kwin."Window to Desktop 9" = [ ];
      kwin."Window to Next Desktop" = [ ];
      kwin."Window to Next Screen" = "Meta+Shift+Right";
      kwin."Window to Previous Desktop" = [ ];
      kwin."Window to Previous Screen" = "Meta+Shift+Left";
      kwin."Window to Screen 0" = [ ];
      kwin."Window to Screen 1" = [ ];
      kwin."Window to Screen 2" = [ ];
      kwin."Window to Screen 3" = [ ];
      kwin."Window to Screen 4" = [ ];
      kwin."Window to Screen 5" = [ ];
      kwin."Window to Screen 6" = [ ];
      kwin."Window to Screen 7" = [ ];
      kwin.disableInputCapture = "Meta+Shift+Esc";
      kwin.view_actual_size = "Meta+0";
      kwin.view_zoom_in = ["Meta++" "Meta+="];
      kwin.view_zoom_out = "Meta+-";

      # --- Media ---
      mediacontrol.mediavolumedown = [ ];
      mediacontrol.mediavolumeup = [ ];
      mediacontrol.nextmedia = "Media Next";
      mediacontrol.pausemedia = "Media Pause";
      mediacontrol.playmedia = [ ];
      mediacontrol.playpausemedia = "Media Play";
      mediacontrol.previousmedia = "Media Previous";
      mediacontrol.seekbackwardmedia = "Media Rewind";
      mediacontrol.seekbackwardmedialong = [ ];
      mediacontrol.seekforwardmedia = "Media Fast Forward";
      mediacontrol.seekforwardmedialong = [ ];
      mediacontrol.stopmedia = "Media Stop";

      # --- Chromium (app-specific) ---
      "org.chromium.Chromium"."16D989E3604A35AED4B3FEDA3BBBA356-+" = [ ];
      "org.chromium.Chromium"."16D989E3604A35AED4B3FEDA3BBBA356--" = [ ];
      "org.chromium.Chromium"."16D989E3604A35AED4B3FEDA3BBBA356-16:9" = [ ];
      "org.chromium.Chromium"."16D989E3604A35AED4B3FEDA3BBBA356-18:9" = [ ];
      "org.chromium.Chromium"."16D989E3604A35AED4B3FEDA3BBBA356-21:9" = [ ];
      "org.chromium.Chromium"."16D989E3604A35AED4B3FEDA3BBBA356-32:9" = [ ];
      "org.chromium.Chromium"."16D989E3604A35AED4B3FEDA3BBBA356-mode_off" = [ ];
      "org.chromium.Chromium"."16D989E3604A35AED4B3FEDA3BBBA356-mode_stretch" = [ ];
      "org.chromium.Chromium"."16D989E3604A35AED4B3FEDA3BBBA356-mode_zoom" = [ ];
      "org.chromium.Chromium".C08C84200E6F19CA348F15C03B7DFF11-autofill_card = [ ];
      "org.chromium.Chromium".C08C84200E6F19CA348F15C03B7DFF11-autofill_identity = [ ];
      "org.chromium.Chromium".C08C84200E6F19CA348F15C03B7DFF11-autofill_login = [ ];
      "org.chromium.Chromium".C08C84200E6F19CA348F15C03B7DFF11-generate_password = [ ];
      "org.chromium.Chromium".C08C84200E6F19CA348F15C03B7DFF11-lock_vault = [ ];
      "org.chromium.Chromium".E98923DAF57DBFE4AE17FA09BDEC327E-SkipScripts = [ ];
      "org.chromium.Chromium".E98923DAF57DBFE4AE17FA09BDEC327E-dashboard = [ ];
      "org.chromium.Chromium".E98923DAF57DBFE4AE17FA09BDEC327E-newScript = [ ];
      "org.chromium.Chromium".E98923DAF57DBFE4AE17FA09BDEC327E-settings = [ ];
      "org.chromium.Chromium".E98923DAF57DBFE4AE17FA09BDEC327E-toggleInjection = [ ];
      "org.chromium.Chromium".E98923DAF57DBFE4AE17FA09BDEC327E-updateScripts = [ ];
      "org.chromium.Chromium".E98923DAF57DBFE4AE17FA09BDEC327E-updateScriptsInTab = [ ];

      # --- Power & Brightness ---
      org_kde_powerdevil."Decrease Keyboard Brightness" = "Keyboard Brightness Down";
      org_kde_powerdevil."Decrease Screen Brightness" = "Monitor Brightness Down";
      org_kde_powerdevil."Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
      org_kde_powerdevil.Hibernate = "Hibernate";
      org_kde_powerdevil."Increase Keyboard Brightness" = "Keyboard Brightness Up";
      org_kde_powerdevil."Increase Screen Brightness" = "Monitor Brightness Up";
      org_kde_powerdevil."Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
      org_kde_powerdevil.PowerDown = "Power Down";
      org_kde_powerdevil.PowerOff = "Power Off";
      org_kde_powerdevil.Sleep = "Sleep";
      org_kde_powerdevil."Toggle Keyboard Backlight" = "Keyboard Light On/Off";
      org_kde_powerdevil."Turn Off Screen" = [ ];
      org_kde_powerdevil.powerProfile = ["Battery" "Meta+B"];

      # --- Plasma Shell & Launchers ---
      plasmashell."Slideshow Wallpaper Next Image" = [ ];
      plasmashell."activate application launcher" = ["Meta" "Alt+F1"];
      plasmashell."activate task manager entry 1" = "Meta+1";
      plasmashell."activate task manager entry 10" = [ ];
      plasmashell."activate task manager entry 2" = "Meta+2";
      plasmashell."activate task manager entry 3" = "Meta+3";
      plasmashell."activate task manager entry 4" = "Meta+4";
      plasmashell."activate task manager entry 5" = "Meta+5";
      plasmashell."activate task manager entry 6" = "Meta+6";
      plasmashell."activate task manager entry 7" = "Meta+7";
      plasmashell."activate task manager entry 8" = "Meta+8";
      plasmashell."activate task manager entry 9" = "Meta+9";
      plasmashell.clear-history = [ ];
      plasmashell.clipboard_action = "Meta+Ctrl+X";
      plasmashell.cycle-panels = "Meta+Alt+P";
      plasmashell.cycleNextAction = [ ];
      plasmashell.cyclePrevAction = [ ];
      plasmashell.edit_clipboard = [ ];
      plasmashell."manage activities" = [ ];
      plasmashell."next activity" = "Meta+A";
      plasmashell."previous activity" = "Meta+Shift+A";
      plasmashell.repeat_action = [ ];
      plasmashell."show dashboard" = "Ctrl+F12";
      plasmashell.show-barcode = [ ];
      plasmashell.show-on-mouse-pos = "Meta+V";
      plasmashell."switch to next activity" = [ ];
      plasmashell."switch to previous activity" = [ ];
      plasmashell."toggle do not disturb" = [ ];
      "services/kitty.desktop"._launch = "Meta+Return";
      "services/org.kde.plasma-systemmonitor.desktop"._launch = ["Ctrl+Shift+Esc" "Meta+Esc"];
      "services/ulauncher.desktop"._launch = "Meta+Space";
    };

    # ==========================================================================
    # Config Files - Application .rc / .conf settings
    # ==========================================================================
    configFile = {
      # --- Baloo (file search) ---
      baloofilerc.General.dbVersion = 2;
      baloofilerc.General."exclude filters" = "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.tfstate*,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,.terraform,.venv,venv,core-dumps,lost+found";
      baloofilerc.General."exclude filters version" = 9;

      # --- Dolphin ---
      dolphinrc.DetailsMode.PreviewSize = 32;
      dolphinrc.General.ViewPropsTimestamp = "2026,1,1,23,26,35.384";
      dolphinrc."KFileDialog Settings"."Places Icons Auto-resize" = false;
      dolphinrc."KFileDialog Settings"."Places Icons Static Size" = 32;
      dolphinrc.PlacesPanel.IconSize = 32;
      kactivitymanagerdrc.activities.fce0d3ca-65e9-47c4-b468-1de82c0b1622 = "Default";
      kactivitymanagerdrc.main.currentActivity = "fce0d3ca-65e9-47c4-b468-1de82c0b1622";

      # --- Input (mouse, keyboard) ---
      kcminputrc."Libinput/1133/16500/Logitech G305".PointerAccelerationProfile = 1;
      kcminputrc.Mouse.cursorTheme = "breeze_cursors";
      kded5rc.Module-browserintegrationreminder.autoload = false;
      kded5rc.Module-device_automounter.autoload = false;

      # --- KDE Globals (theme, fonts, terminal) ---
      kdeglobals.General.TerminalApplication = "foot";
      kdeglobals.General.TerminalService = "foot.desktop";
      kdeglobals.General.XftHintStyle = "hintslight";
      kdeglobals.General.XftSubPixel = "none";
      kdeglobals.General.fixed = "NotoMono Nerd Font,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      kdeglobals.Icons.Theme = "Papirus-Dark";
      kdeglobals.KDE.AnimationDurationFactor = 0.25;
      kdeglobals."KFileDialog Settings"."Allow Expansion" = false;
      kdeglobals."KFileDialog Settings"."Automatically select filename extension" = true;
      kdeglobals."KFileDialog Settings"."Breadcrumb Navigation" = true;
      kdeglobals."KFileDialog Settings"."Decoration position" = 2;
      kdeglobals."KFileDialog Settings"."Show Full Path" = false;
      kdeglobals."KFileDialog Settings"."Show Inline Previews" = true;
      kdeglobals."KFileDialog Settings"."Show Preview" = false;
      kdeglobals."KFileDialog Settings"."Show Speedbar" = true;
      kdeglobals."KFileDialog Settings"."Show hidden files" = false;
      kdeglobals."KFileDialog Settings"."Sort by" = "Name";
      kdeglobals."KFileDialog Settings"."Sort directories first" = true;
      kdeglobals."KFileDialog Settings"."Sort hidden files last" = false;
      kdeglobals."KFileDialog Settings"."Sort reversed" = false;
      kdeglobals."KFileDialog Settings"."Speedbar Width" = 140;

      kdeglobals."KFileDialog Settings"."View Style" = "DetailTree";
      kdeglobals.WM.activeBackground = "39,44,49";
      kdeglobals.WM.activeBlend = "252,252,252";
      kdeglobals.WM.activeForeground = "252,252,252";
      kdeglobals.WM.inactiveBackground = "32,36,40";
      kdeglobals.WM.inactiveBlend = "161,169,177";
      kdeglobals.WM.inactiveForeground = "161,169,177";

      # --- File operations, KRunner, Screen lock ---
      kiorc.Confirmations.ConfirmDelete = true;
      kiorc.Confirmations.ConfirmEmptyTrash = true;
      kiorc.Confirmations.ConfirmTrash = false;
      kiorc."Executable scripts".behaviourOnLaunch = "alwaysAsk";
      krunnerrc.General.FreeFloating = true;
      kscreenlockerrc.Daemon.Autolock = false;
      kscreenlockerrc.Daemon.Timeout = 0;
      kservicemenurc.Show.forgetfileitemaction = true;
      kservicemenurc.Show.kactivitymanagerd_fileitem_linking_plugin = true;
      kservicemenurc.Show.movetonewfolderitemaction = true;
      kservicemenurc.Show.setfoldericonitemaction = true;
      kservicemenurc.Show.tagsfileitemaction = true;

      # --- Session, Trash, KWallet ---
      ksmserverrc.General.confirmLogout = false;
      ksmserverrc.General.loginMode = "emptySession";
      ktrashrc."\\/home\\/r00t\\/.local\\/share\\/Trash".Days = 7;
      ktrashrc."\\/home\\/r00t\\/.local\\/share\\/Trash".LimitReachedAction = 0;
      ktrashrc."\\/home\\/r00t\\/.local\\/share\\/Trash".Percent = 10;
      ktrashrc."\\/home\\/r00t\\/.local\\/share\\/Trash".UseSizeLimit = true;
      ktrashrc."\\/home\\/r00t\\/.local\\/share\\/Trash".UseTimeLimit = false;
      kwalletrc.Wallet."First Use" = false;

      # --- KWin (window manager, tiling, night color) ---
      kwinrc.Desktops.Id_1 = "ce07d945-d687-47d5-aa6c-24589e83f5ca";
      kwinrc.Desktops.Id_2 = "01b8814f-f3dc-4938-b9e6-0b8d03838314";
      kwinrc.Desktops.Name_1 = "Default";
      kwinrc.Desktops.Name_2 = "Stream";
      kwinrc.Desktops.Number = 2;
      kwinrc.Desktops.Rows = 1;
      kwinrc.NightColor.Active = true;
      kwinrc.NightColor.Mode = "Constant";
      kwinrc.Plugins.kzonesEnabled = true;
      kwinrc.Plugins.mousetilerEnabled = false;
      kwinrc.Plugins.rememberwindowpositionsEnabled = false;
      kwinrc.Script-kzones."[Tiling][01b8814f-f3dc-4938-b9e6-0b8d03838314][]" = "";
      kwinrc.Script-kzones.edgeSnappingTriggerDistance = 0;
      kwinrc.Script-kzones.enableEdgeSnapping = true;
      kwinrc.Script-kzones.layoutsJson = "[\n    {\n        \"name\": \"2x Prio + Video\",\n        \"padding\": 0,\n        \"zones\": [\n            {\n                \"x\": 0,\n                \"y\": 0,\n                \"height\": 100,\n                \"width\": 40\n            },\n            {\n                \"x\": 40,\n                \"y\": 0,\n                \"height\": 100,\n                \"width\": 40\n            },\n            {\n                \"x\": 80,\n                \"y\": 0,\n                \"height\": 100,\n                \"width\": 20\n            }\n        ]\n    },\n    {\n        \"name\": \"Quadrant Grid\",\n        \"zones\": [\n            {\n                \"x\": 0,\n                \"y\": 0,\n                \"height\": 50,\n                \"width\": 50\n            },\n            {\n                \"x\": 0,\n                \"y\": 50,\n                \"height\": 50,\n                \"width\": 50\n            },\n            {\n                \"x\": 50,\n                \"y\": 50,\n                \"height\": 50,\n                \"width\": 50\n            },\n            {\n                \"x\": 50,\n                \"y\": 0,\n                \"height\": 50,\n                \"width\": 50\n            }\n        ]\n    }\n]";
      kwinrc.Script-kzones.tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      kwinrc."Tiling/01b8814f-f3dc-4938-b9e6-0b8d03838314/9868fbee-cb47-41a1-9cf5-b2dd74a6ffdc"."[Tiling][ce07d945-d687-47d5-aa6c-24589e83f5ca][]" = "";
      kwinrc."Tiling/01b8814f-f3dc-4938-b9e6-0b8d03838314/9868fbee-cb47-41a1-9cf5-b2dd74a6ffdc".padding = 4;
      kwinrc."Tiling/01b8814f-f3dc-4938-b9e6-0b8d03838314/9868fbee-cb47-41a1-9cf5-b2dd74a6ffdc".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      kwinrc."Tiling/ce07d945-d687-47d5-aa6c-24589e83f5ca/2a889de5-41d8-4fb5-bf56-053b7bcd09bd".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.3431640625},{\"width\":0.16171875000000002},{\"width\":0.49511718749999667}]}";
      kwinrc."Tiling/ce07d945-d687-47d5-aa6c-24589e83f5ca/9868fbee-cb47-41a1-9cf5-b2dd74a6ffdc".padding = 4;
      kwinrc."Tiling/ce07d945-d687-47d5-aa6c-24589e83f5ca/9868fbee-cb47-41a1-9cf5-b2dd74a6ffdc".tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.3484375},{\"width\":0.39941406249999994},{\"width\":0.25214843750000004}]}";
      kwinrc.Windows.BorderSnapZone = 0;
      kwinrc.Windows.DelayFocusInterval = 0;
      kwinrc.Xwayland.Scale = 1;
      kwinrc."org.kde.kdecoration2".ButtonsOnLeft = "";
      kwinrc."org.kde.kdecoration2".ButtonsOnRight = "";
      kwinrc."org.kde.kdecoration2".theme = "Breeze";
      kwinrc.Plugins.closeUnderCursorEnabled = true;

      # --- KWin Rules (ulauncher, etc.) ---
      kwinrulesrc."27736c95-7660-4871-87eb-2159ae68abc1".Description = "ulauncher";
      kwinrulesrc."27736c95-7660-4871-87eb-2159ae68abc1".noborder = true;
      kwinrulesrc."27736c95-7660-4871-87eb-2159ae68abc1".noborderrule = 2;
      kwinrulesrc."27736c95-7660-4871-87eb-2159ae68abc1".placement = 6;
      kwinrulesrc."27736c95-7660-4871-87eb-2159ae68abc1".placementrule = 2;
      kwinrulesrc."27736c95-7660-4871-87eb-2159ae68abc1".wmclass = "ulauncher";
      kwinrulesrc."27736c95-7660-4871-87eb-2159ae68abc1".wmclassmatch = 3;
      kwinrulesrc."4979aef1-c72f-4744-8f48-c9684198428a".Description = "no title bar";
      kwinrulesrc."4979aef1-c72f-4744-8f48-c9684198428a".Enabled = false;
      kwinrulesrc."4979aef1-c72f-4744-8f48-c9684198428a".noborder = true;
      kwinrulesrc."4979aef1-c72f-4744-8f48-c9684198428a".noborderrule = 3;
      kwinrulesrc."4979aef1-c72f-4744-8f48-c9684198428a".wmclass = ".*";
      kwinrulesrc."4979aef1-c72f-4744-8f48-c9684198428a".wmclassmatch = 3;
      kwinrulesrc.General.count = 2;
      kwinrulesrc.General.rules = "4979aef1-c72f-4744-8f48-c9684198428a,27736c95-7660-4871-87eb-2159ae68abc1";
      kwinrulesrc.a4c8f387-5697-4377-93ff-b3138140c15a.Description = "No title bar";
      kwinrulesrc.a4c8f387-5697-4377-93ff-b3138140c15a.noborder = true;
      kwinrulesrc.a4c8f387-5697-4377-93ff-b3138140c15a.noborderrule = 3;
      kwinrulesrc.a4c8f387-5697-4377-93ff-b3138140c15a.wmclass = ".*";
      kwinrulesrc.a4c8f387-5697-4377-93ff-b3138140c15a.wmclassmatch = 3;

      # --- Plasma theme, Spectacle ---
      plasma-localerc.Formats.LANG = "en_US.UTF-8";
      plasmanotifyrc."Applications/brave-browser".Seen = true;
      plasmanotifyrc."Applications/io.ulauncher.Ulauncher".Seen = true;
      plasmarc.Theme.name = "breeze-dark";
      plasmarc.Wallpapers.usersWallpapers = "/nix/store/gxn3s7509c31qfvdi090fiaihzyjwxgs-plasma-workspace-wallpapers-6.5.4/share/wallpapers/Altai/";
      spectaclerc.Annotations.annotationToolType = 9;
      spectaclerc.ImageSave.translatedScreenshotsFolder = "Screenshots";
      spectaclerc.VideoSave.translatedScreencastsFolder = "Screencasts";
    };
  };

  # Manually create the KWin script structure
  home.file.".local/share/kwin/scripts/closeUnderCursor/contents/code/main.js".text = ''
    // syntax: javascript
    registerShortcut("Close Window Under Cursor", "Close Window Under Cursor", "Meta+Q", function() {
      var windows = workspace.windowAt(workspace.cursorPos);
      if (windows && windows.length > 0) {
          const win = windows[0]
          print("Closing Window Under Cursor: Win: " + win + " WindowTitle: " + win.title)
          if (win.normalWindow) {
              if (typeof win.closeWindow === "function") {
                  win.closeWindow();
              } else if (typeof workspace.slotWindowClose === "function") {
                  workspace.slotWindowClose();
              }
          } else {
              print("Closing Window Under Cursor: Window is not a normal window -> not closing")
          }
      }
    });
  '';

  home.file.".local/share/kwin/scripts/closeUnderCursor/metadata.json".text = builtins.toJSON {
    KPackageStructure = "KWin/Script";
    X-Plasma-API = "javascript";
    X-Plasma-MainScript = "code/main.js";
    KPlugin = {
      Name = "Close Under Cursor";
      Description = "Closes the window currently under the mouse pointer. Shortcut: Meta+Q";
      Icon = "window-close";
      Id = "closeUnderCursor";
      Version = "1.0";
      License = "GPLv3";
      Authors = [ { Name = "NixOS Config"; } ];
      ServiceTypes = [ "KWin/Script" ];
    };
  };
}