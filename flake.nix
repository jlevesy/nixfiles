{
  description = "Nixos config flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    alejandra,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = {
      vmcell = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {
            environment.systemPackages = [alejandra.defaultPackage.${system}];
          }
          ./hosts/vmcell/configuration.nix
          home-manager.nixosModules.default
        ];
      };
    };
  };
}
