# Overlays

This folder contains patches for packages and the overlay definitions that apply them.

## Purpose

The `overlays` folder is used to store patch files (`.patch`, `.diff`, etc.) and define overlays that apply these patches to existing packages from nixpkgs. This allows you to:

- Fix bugs in packages
- Add features or modifications to packages
- Customize package behavior without maintaining a full fork

## Structure

The `default.nix` file defines overlays that apply patches to packages. Patches are stored in this directory and referenced in the overlay definitions.

## Example

To apply a patch to a package, add it to the `modifications` overlay in `default.nix`:

```nix
modifications = final: prev: {
  example = prev.example.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [ ./my-patch.patch ];
  });
};
```

Store your patch files (`.patch`, `.diff`, etc.) in this directory and reference them relative to `default.nix`.

## Further Reading

- [NixOS Wiki: Overlays](https://nixos.wiki/wiki/Overlays)
