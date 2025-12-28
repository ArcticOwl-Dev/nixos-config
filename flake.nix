{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # walker
    elephant.url = "github:abenz1267/elephant";
    walker.url = "github:abenz1267/walker";
    walker.inputs.elephant.follows = "elephant";

    # vicinae
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae-extensions = {
       url = "github:vicinaehq/extensions";
       inputs.nixpkgs.follows = "nixpkgs";
     };

    # grub2-themes
    grub2-themes.url = "github:vinceliuice/grub2-themes";

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    grub2-themes,
    ...
  } @ inputs: let
    # Supported systems for your flake packages, shell, etc.
    system = "x86_64-linux";

  in {
    packages = import ./pkgs nixpkgs.legacyPackages.${system};
    formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

    overlays = import ./overlays {inherit inputs;};
 
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # Machine 1: snowfire
      snowfire = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./config/configuration.nix
          ./clients/snowfire/configuration.nix

          grub2-themes.nixosModules.default
          # home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            home-manager.users.r00t = import ./clients/snowfire/home.nix;

            home-manager.extraSpecialArgs = {
              inherit inputs;
              style = import ./clients/snowfire/style.nix;
            };
          }
        ];
      };
      # Machine 2: stardust
      stardust = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./config/configuration.nix
          ./clients/stardust/configuration.nix
        ];
      };
    };
  };
}
