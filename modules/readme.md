# Modules (`modules/`)

This directory contains **NixOS modules** - reusable module definitions that provide configuration options and system integration.

## What goes here?

- **Module definitions** - Files that define `options` and `config` for NixOS services, programs, or system features
- **Reusable configuration logic** - Modules that can be imported and configured in multiple places
- **System integration** - Modules that set up kernel modules, udev rules, systemd services, firewall rules, etc.

## Structure

Each module should have its own subdirectory with a `default.nix` file:


## What modules do

Modules typically:
- Define **options** (configuration parameters users can set)
- Provide **default values** for options
- Implement **system configuration** based on those options (kernel modules, services, firewall, etc.)
- Handle **dependencies** and **integration** with the system

## Examples

- Service modules that configure systemd services
- Modules that set up kernel modules and udev rules
- Modules that configure firewall ports
- Modules that create user groups and permissions
- Modules that provide wrapper scripts or environment setup

## What does NOT go here?

- **Package definitions** → Go in `pkgs/`
- **Configuration values** → Go in `config/` (config files that use these modules)
- **Client-specific config** → Go in `clients/`

## Usage

Modules are imported in configuration files (like `config/remote-touchpad/remote-touchpad.nix`) where you set the actual configuration values. The module defines *what* can be configured, while the config files define *how* it's configured.

## Key difference from config files

- **Modules** (`modules/`) = Define *options* and *how* to configure the system
- **Config files** (`config/`) = Set the actual *values* for those options

