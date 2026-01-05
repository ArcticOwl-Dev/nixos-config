# Remote Touchpad configuration module
# Builds and configures Remote Touchpad from source
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.remote-touchpad;
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
  };

  config = mkIf cfg.enable {
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

    # Systemd user service for Remote Touchpad
    systemd.user.services.remote-touchpad = mkIf cfg.autoStart {
      description = "Remote Touchpad";
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = let
          secretFlag = if cfg.secret != null then "-secret ${lib.escapeShellArg cfg.secret}" else "";
        in "${pkgs.remote-touchpad}/bin/remote-touchpad -bind :${toString cfg.port} ${secretFlag}";
        Restart = "on-failure";
        RestartSec = "5s";
      } // lib.optionalAttrs (cfg.keymap != null) {
        # Add kbd package to PATH for loadkeys command (needed when keymap is set)
        Environment = [
          "REMOTE_TOUCHPAD_UINPUT_KEYMAP=${cfg.keymap}"
          "PATH=${pkgs.kbd}/bin:${pkgs.coreutils}/bin:/usr/bin:/bin"
        ];
      };
    };

    # Create a wrapper script that uses the configured port, keymap, and secret
    # This ensures the port is always fixed, even when running manually
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "remote-touchpad" ''
        ${if cfg.keymap != null then "export REMOTE_TOUCHPAD_UINPUT_KEYMAP=${cfg.keymap}" else ""}
        ${if cfg.secret != null then ''
          exec ${pkgs.remote-touchpad}/bin/remote-touchpad -bind :${toString cfg.port} -secret "${lib.replaceStrings ["\"" "\\" "$" "`"] ["\\\"" "\\\\" "\\$" "\\`"] cfg.secret}" "$@"
        '' else ''
          exec ${pkgs.remote-touchpad}/bin/remote-touchpad -bind :${toString cfg.port} "$@"
        ''}
      '')
    ];
  };
}

