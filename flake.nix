{
  description = "Nixos config flake";

  inputs = {
    font-flake = {
      url = "github:redyf/font-flake";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland = {
    #   url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    nur = {
      url = "github:nix-community/nur";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    stylix.url = "github:danth/stylix";
    zen-browser.url = "github:omarcresp/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    # hyprland,
    home-manager,
    stylix,
    ...
  } @ inputs: let
    inherit (nixpkgs.lib) nixosSystem;
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./hosts/willsterjohnson/configuration.nix
        # hyprland.nixosModules.default
        stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.default
        inputs.nixos-hardware.nixosModules.framework-16-7040-amd
      ];
    };
  };
}
