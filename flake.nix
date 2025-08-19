{
  description = "Nixos config flake";

  inputs = {
	nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";

    home-manager = {
       url = "github:nix-community/home-manager/release-25.05";
       inputs.nixpkgs.follows = "nixpkgs";
    };

	nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
