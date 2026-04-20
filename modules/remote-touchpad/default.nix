# Remote Touchpad configuration module
# Builds and configures Remote Touchpad from source
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.remote-touchpad;

  # Only restart the user service when the built unit / binary inputs change, not on every switch.
  restartStamp =
    builtins.hashString "sha256" (
      builtins.toJSON {
        pkg = pkgs.local.remote-touchpad.outPath;
        inherit (cfg) port secret keymap tailscaleHostname;
        tailscaleAuthKeyFile =
          if cfg.tailscaleAuthKeyFile != null then toString cfg.tailscaleAuthKeyFile else null;
      }
    );
in
{
  options.services.remote-touchpad = {
    enable = mkEnableOption "Remote Touchpad";

    user = mkOption {
      type = types.str;
      default = "r00t";
      description = "User to run Remote Touchpad and add to uinput group";
    };

    autoStart = mkOption {
      type = types.bool;
      default = false;
      description = "Automatically start Remote Touchpad on boot";
    };

    port = mkOption {
      type = types.port;
      default = 40999;
      description = "Port for Remote Touchpad web server";
    };

    keymap = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "de";
      description = "Keyboard layout for uinput (e.g., 'de' for German, 'us' for US). Set to null to use system default.";
    };

    secret = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "my-secret-password";
      description = "Shared secret for client authentication. If set, clients must provide this secret to connect (no QR code needed).";
    };

    tailscaleHostname = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "my-pc-remote-touchpad";
      description = ''
        If non-null and non-empty, Remote Touchpad joins your tailnet via tsnet with this
        MagicDNS hostname. If null or empty, Tailscale mode is disabled.
      '';
    };

    tailscaleAuthKeyFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = ''
        Path to a file containing the Tailscale device auth key (tskey-auth-…), e.g.
        `config.sops.secrets.tailscale-auth-key.path`. Required when tailscaleHostname is set.
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion =
          (cfg.tailscaleHostname == null || cfg.tailscaleHostname == "")
          || (cfg.tailscaleAuthKeyFile != null);
        message = "services.remote-touchpad: tailscaleAuthKeyFile must be set when tailscaleHostname is set.";
      }
    ];
    # Enable uinput kernel module
    boot.kernelModules = [ "uinput" ];

    # Configure uinput device permissions
    services.udev.extraRules = ''
      # Allow users in the uinput group to access uinput
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    # Create uinput group
    users.groups.uinput = {};

    # Add user to uinput group
    users.users.${cfg.user}.extraGroups = [ "uinput" ];

    # Firewall configuration for Remote Touchpad
    networking.firewall.allowedTCPPorts = [ cfg.port ];

    # User units are not restarted by `nixos-rebuild switch`. Activation runs too early; we watch
    # /run/current-system and run a oneshot after each switch, but the script compares a stamp to
    # the current config hash so we only daemon-reload+restart when this module’s inputs change.
    systemd.paths.remote-touchpad-after-nixos-switch = mkIf cfg.autoStart {
      description = "Watch /run/current-system for NixOS switch";
      wantedBy = [ "paths.target" ];
      pathConfig = {
        PathChanged = "/run/current-system";
        Unit = "remote-touchpad-after-nixos-switch.service";
      };
    };

    systemd.services.remote-touchpad-after-nixos-switch = mkIf cfg.autoStart {
      description = "Reload user systemd and restart Remote Touchpad after nixos-rebuild switch";
      serviceConfig.Type = "oneshot";
      script = ''
        set -eu
        stampFile=/var/lib/remote-touchpad/restart-stamp
        cur=${lib.escapeShellArg restartStamp}
        ${pkgs.coreutils}/bin/mkdir -p /var/lib/remote-touchpad
        if [ -f "$stampFile" ] && [ "$(${pkgs.coreutils}/bin/cat "$stampFile")" = "$cur" ]; then
          exit 0
        fi
        uid=$(${pkgs.glibc}/bin/getent passwd ${cfg.user} | ${pkgs.coreutils}/bin/cut -d: -f3)
        if [ -z "$uid" ] || [ ! -S "/run/user/$uid/systemd/private" ]; then
          exit 0
        fi
        rt_env() {
          if [ -S "/run/user/$uid/bus" ]; then
            ${pkgs.util-linux}/bin/runuser -u ${cfg.user} -- env \
              "XDG_RUNTIME_DIR=/run/user/$uid" \
              "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus" \
              "$@"
          else
            ${pkgs.util-linux}/bin/runuser -u ${cfg.user} -- env \
              "XDG_RUNTIME_DIR=/run/user/$uid" \
              "$@"
          fi
        }
        rt_env "${config.systemd.package}/bin/systemctl" --user daemon-reload
        rt_env "${config.systemd.package}/bin/systemctl" --user restart app-com.arcticowl.remote-touchpad.service
        printf '%s' "$cur" > "$stampFile"
      '';
    };

    # Systemd user service for Remote Touchpad
    # Name follows app-<app_id>.service so xdg-desktop-portal can identify it for "Control input device" permission
    systemd.user.services."app-com.arcticowl.remote-touchpad" = mkIf cfg.autoStart {
      description = "Remote Touchpad";
      wantedBy = [ "default.target" ];
      # Portal D-Bus is not ready at plain login.target; starting too early causes "No such interface".
      after = [
        "graphical-session.target"
        "xdg-desktop-portal.service"
      ];
      restartIfChanged = true;
      restartTriggers = [ pkgs.local.remote-touchpad ];
      serviceConfig = let
        # User services get a tiny default PATH. systemd: `systemctl`/`loginctl` (poweroff, reboot,
        # user units). bash: `sh` for custom button scripts. xdg-utils: `xdg-open` / desktop files
        # to start apps. coreutils: basic utilities. kbd: optional keymap tools.
        pathPackages =
          [
            config.systemd.package
            pkgs.coreutils
            pkgs.bash
            pkgs.xdg-utils
          ]
          ++ lib.optional (cfg.keymap != null) pkgs.kbd;
      in {
        ExecStart = let
          bin = "${pkgs.local.remote-touchpad}/bin/remote-touchpad";
          bind = "-bind :${toString cfg.port}";
          secretFlag = if cfg.secret != null then " -secret ${lib.escapeShellArg cfg.secret}" else "";
          tailscaleFlag =
            if (cfg.tailscaleHostname != null && cfg.tailscaleHostname != "") then
              " -tailscale ${lib.escapeShellArg cfg.tailscaleHostname} -tailscale-auth-key-file ${lib.escapeShellArg (toString cfg.tailscaleAuthKeyFile)}"
            else
              "";
        in "${bin} ${bind}${tailscaleFlag}${secretFlag}";
        Restart = "on-failure";
        RestartSec = "5s";
        Environment =
          [
            "PATH=${lib.makeBinPath pathPackages}"
          ]
          ++ lib.optional (cfg.keymap != null) "REMOTE_TOUCHPAD_UINPUT_KEYMAP=${cfg.keymap}";
      };
    };
  };
}

