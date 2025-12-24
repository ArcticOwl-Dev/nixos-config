{ config, lib, pkgs, style, ... }:
let
  nerdFont = style.nerdFont;
in
{
  # Install Nerd Fonts for terminal icons
  # nerdfonts is a function that takes a list of fonts to include
  # Using override to only include NotoMono (reduces package size significantly)
  # Without override, it would include ALL nerd fonts (several GB)
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "NotoMono" ]; })
  ];

  programs.fish.enable = true;                               # fish (shell)
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    icons = "auto";
    colors = "auto";
    extraOptions = [
      "--group-directories-first"
    ];
  };
  programs.micro.enable = true;                             # micro (text editor)
  programs.micro.settings = {
    editor = {
      font = nerdFont;
      font_size = 12;
      line_height = 1.5;
      line_width = 120;
      line_width_chars = 120;
    };
  };

  programs.fastfetch.enable = true;                         # fastfetch (system information)
  programs.btop.enable = true;                              # btop (system monitor)
  services.cliphist.enable = true;                          # cliphist (clipboard history)
  programs.fd.enable = true;                                # fd (file finder)
  programs.lazygit.enable = true;                           # lazygit (git client)
  programs.lazygit.enableFishIntegration = true;          
  
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
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      nix_shell.symbol = "❄️ ";
    };
  };
}