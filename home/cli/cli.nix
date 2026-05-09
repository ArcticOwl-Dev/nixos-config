{
  lib,
  pkgs,
  style,
  ...
}:
let
  nerdFont = style.nerdFont;
in
{
  # Install NixOS packages with home-manager
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.noto
    curlFull
    wget
    jq # json processor
    brightnessctl # brightness control
    nh # nix helper
    comma # run commands by temporary install nix packages ", cowsay neato"
    nix-index
    unrar
  ];
  programs.fish = {
    enable = true; # fish (shell)
    
    generateCompletions = true;
    interactiveShellInit = ''
      # syntax: bash
      set -g fish_greeting # remove fish greeting
    '';
    # Auto-reload fish when config was switched (home-manager or nixos-rebuild)
    shellInit = ''
      # syntax: bash
      function __hm_reload_check --on-event fish_prompt
        if not set -q _hm_reload_initialized
          set -g _hm_reload_initialized 1
          if test -f $HOME/.hm-reload-trigger
            stat -c %Y $HOME/.hm-reload-trigger > $HOME/.hm-reload-seen 2>/dev/null || true
          end
        end
        if test -f $HOME/.hm-reload-trigger && test -f $HOME/.hm-reload-seen
          set -l trigger_mtime (stat -c %Y $HOME/.hm-reload-trigger 2>/dev/null)
          set -l seen_mtime (cat $HOME/.hm-reload-seen 2>/dev/null)
          if test -n "$trigger_mtime" && test -n "$seen_mtime" && test $trigger_mtime -gt $seen_mtime
            exec fish
          end
        end
      end
    '';
    # cd then ls (eza if fish integration is on)
    functions = {
      cd = ''
        # syntax: bash
        builtin cd $argv
        and ls
      '';
      # Re-apply Nix/home-manager env in current shell (run after nix-rebuild switch / home-manager switch)
      nix-refresh-env = ''
        # syntax: bash
        if test -f ~/.nix-profile/etc/profile.d/hm-session-vars.fish
          source ~/.nix-profile/etc/profile.d/hm-session-vars.fish
          echo "nix-refresh-env: session vars reloaded from current profile."
        else
          echo "nix-refresh-env: ~/.nix-profile/etc/profile.d/hm-session-vars.fish not found."
        end
        # Ensure profile bin is on PATH so new symlinked binaries are visible
        set -l profile_bin "$HOME/.nix-profile/bin"
        if test -d "$profile_bin"
          set -l path_copy $PATH
          set -e PATH
          set -gx PATH "$profile_bin"
          for p in $path_copy
            if test "$p" != "$profile_bin"
              set -gx PATH $PATH $p
            end
          end
        end
      '';
    };
  };
  programs.eza = {
    # eza (file explorer)
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    colors = "auto";
    extraOptions = [
      "--group-directories-first"
      "--hyperlink"
    ];
  };
  programs.micro = {
    # micro (text editor)
    enable = true; 
    settings = {
      editor = {
        font = nerdFont;
        font_size = 12;
        line_height = 1.5;
        line_width = 120;
        line_width_chars = 120;
      };
      clipboard = "external";
    };
  };

  programs.fastfetch.enable = true; # fastfetch (system information)
  programs.btop.enable = true; # btop (system monitor)
  services.cliphist.enable = true; # cliphist (clipboard history)
  programs.fd.enable = true; # fd (file finder)
  programs.lazygit.enable = true; # lazygit (git client)
  programs.lazygit.enableFishIntegration = true;

  programs.starship = {
    # starship (prompt)
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$package"
        "$haskell"
        "$python"
        "$rust"
        "$nix_shell"
        "$line_break"
        "$jobs"
        "$character"
      ];
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      nix_shell.symbol = "❄️ ";
    };
  };
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
    # how to use:
    # echo "use flake" > .envrc
    # direnv allow
  };
  
}
