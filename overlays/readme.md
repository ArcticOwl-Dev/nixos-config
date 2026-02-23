# Overlays

This folder contains patch files and the overlay definitions that apply them.

## Purpose

- **Store patches** (`.patch`, `.diff`) for nixpkgs packages in one place.
- **Apply patches** via the `modifications` overlay when possible, or in the consuming module when the package is used with `.override {}`.

Use this to fix bugs, add features, or customize behavior without maintaining a full fork.

## Structure

- `default.nix` – defines overlays (additions, modifications, etc.).
- `sddm-astronaut-theme/patches/` – example: patches for the SDDM astronaut theme (Main.qml, Input.qml). Applied via the `sddm-astronaut-custom` helper in the overlay (see Pattern 2).

## Pattern 1: Patch in the overlay (preferred)

For packages you use **without** `.override {}`, add the patch in `modifications` in `default.nix`:

```nix
modifications = final: prev: {
  example = prev.example.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [ ./path/to/my-patch.patch ];
  });
};
```

Reference patch files relative to `default.nix`. The derivation’s normal build (unpack → patch → install) will use your patch.

## Pattern 2: Override first, then patch in the overlay (when using `.override {}`)

For packages you use **with** `.override { ... }`, the overridden derivation does **not** inherit a simple `overrideAttrs` on the base package (override re-invokes the recipe). You can still keep patches in the overlay by providing a **helper** that does override first, then `overrideAttrs` to add patches. The consuming module then only calls the helper and does any extra steps (e.g. rename).

**Example:** `sddm-astronaut-theme` – `modifications` in `default.nix` defines `sddm-astronaut-custom` that takes `embeddedTheme` and `themeConfig`, runs `prev.sddm-astronaut.override { ... }` and then `.overrideAttrs { patches = [ ... ]; }`. Patches live in `sddm-astronaut-theme/patches/`. The Plasma module uses `pkgs.sddm-astronaut-custom { ... }` and only renames the theme for a unique SDDM name.

## Further Reading

- [NixOS Wiki: Overlays](https://nixos.wiki/wiki/Overlays)
