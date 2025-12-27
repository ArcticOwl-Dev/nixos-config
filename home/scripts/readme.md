# Scripts Directory

This directory contains custom scripts that are automatically added to your PATH.

## Structure

- `default.nix` - Nix module that manages scripts and adds them to PATH
- Place your script files directly in this `home/scripts/` directory

## Usage

### Method 1: Reference script files from this directory

1. Add your script file (e.g., `my-script.sh`) to the `home/scripts/` directory
2. Add a reference in `default.nix`:
   ```nix
   home.file."${scriptsDir}/my-script.sh" = {
     source = ./my-script.sh;
     executable = true;
   };
   ```
3. Rebuild your NixOS configuration
4. The script will be available as `my-script.sh` from anywhere in your terminal

### Method 2: Define scripts directly in `default.nix`

Add scripts directly in the `default.nix` file using `home.file`:

```nix
home.file."${scriptsDir}/my-script.sh" = {
  executable = true;
  text = ''
    #!/usr/bin/env bash
    # Your script content here
    echo "Hello from my script!"
  '';
};
```

### Method 3: Use `pkgs.writeShellScriptBin` for single scripts

For scripts that should be available system-wide, you can use:

```nix
home.packages = [
  (pkgs.writeShellScriptBin "my-script" ''
    #!/usr/bin/env bash
    # Your script content
  '')
];
```

## Environment Variables

- `$HYPRSCRIPTS` - Points to `~/.local/bin` (useful for Hyprland keybinds)
- Scripts are automatically added to `$PATH`

## Importing the Module

Make sure to import this module in your `home.nix`:

```nix
imports = [
  # ... other imports
  ../../home/scripts
];
```

