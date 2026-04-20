{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
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

    # plasma-manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # winapps
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen Browser
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Encrypted secrets (SOPS + age)
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # remote-touchpad source (default branch; pinned in flake.lock)
    remote-touchpad = {
      url = "github:ArcticOwl-Dev/remote-touchpad";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    grub2-themes,
    plasma-manager,
    winapps,
    zen-browser,
    sops-nix,
    ...
  } @ inputs: let
    # Supported systems for your flake packages, shell, etc.
    system = "x86_64-linux";

  in {
    packages = import ./pkgs nixpkgs.legacyPackages.${system} inputs;
    formatter = nixpkgs.legacyPackages.${system}.nixfmt;

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
            home-manager.sharedModules = [
              plasma-manager.homeModules.plasma-manager
              sops-nix.homeManagerModules.sops
            ];

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
