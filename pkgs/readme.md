# Packages (`pkgs/`)

This directory contains **package definitions** - Nix expressions that define how to build or fetch packages.

## What goes here?

- **Package build definitions** - Files that define how to build packages from source (e.g., using `buildGoModule`, `stdenv.mkDerivation`, etc.)
- **Custom package derivations** - Packages not available in nixpkgs or custom versions/patches of existing packages
- **Package source fetching** - Definitions for fetching packages from GitHub, URLs, or other sources

## Structure

Each package should have its own subdirectory with a `default.nix` file:


## Examples

- Building a Go application from GitHub source
- Fetching and packaging a pre-built binary
- Creating a custom derivation with patches or modifications
- Packaging software not in nixpkgs

## What does NOT go here?

- **NixOS modules** → Go in `modules/`
- **Configuration files** → Go in `nixos/`
- **System configuration** → Go in `nixos/` or `clients/`

## Usage

Packages defined here are automatically available through the overlay system defined in `overlays/default.nix` and can be used in your NixOS configuration or as standalone packages.

