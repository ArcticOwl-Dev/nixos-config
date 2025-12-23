{ config, lib, pkgs, ... }:
{
  programs.fish.enable = true;                               # fish (shell)
  programs.fish.shellAliases = {
    ls = "ls --color=auto";
    ll = "ls -l";
    la = "ls -la";
    lt = "ls -lt";
    lr = "ls -lrt";
    lrt = "ls -lrt";
    lrt = "ls -lrt";
  };
  programs.eza.enable = true;                                # eza (ls replacement)
  programs.eza.settings = {
    icons = true;
    color = true;
    color_mode = "auto";
    group_directories_first = true;
    long = true;
    all = true;
    hidden = true;
  };
  programs.micro.enable = true;                             # micro (text editor)
  programs.micro.settings = {
    editor = {
      font = "JetBrains Mono";
      font_size = 12;
      line_height = 1.5;
      line_width = 120;
      line_width_chars = 120;
      line_width_chars = 120;
    }
  };

  programs.fastfetch.enable = true;                         # fastfetch (system information)
  programs.btop.enable = true;                              # btop (system monitor)
  programs.curl.enable = true;                              # curl (http client)
  programs.wget.enable = true;                              # wget (download manager)
  services.cliphist.enable = true;                          # cliphist (clipboard history)
  programs.fd.enable = true;                                # fd (file finder)
  programs.lazygit.enable = true;                           # lazygit (git client)
  programs.lazygit.fishIntegration = true;          
  
  programs.starship ={
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
        success_symbol = "[\\(v0.5.0\\)]";
        error_symbol = "[\\(v0.5.0\\)]";
      };
      nix_shell.symbol = "❄️ ";
    };
  }
}