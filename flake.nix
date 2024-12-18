{
  description = "Damacus's dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      # macOS configuration
      damacus = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [
          ./modules/home.nix
          ./modules/rust.nix
        ];
      };

      # Linux configuration
      "u.7862791-1" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./modules/home.nix
        ];
      };
    };

    packages.x86_64-linux.default = home-manager.defaultPackage.x86_64-linux;
    packages.aarch64-darwin.default = home-manager.defaultPackage.aarch64-darwin;
  };
}
