{
  description = "Common flake";

  inputs =
  {
    nix-firefox-addons =
    {
      url = "github:osipog/nix-firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager =
    {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
      #url = "github:nix-community/home-manager";
      #inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-darwin =
    {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      #url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Add?
    #nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @
  {
    nixpkgs,
    nixpkgs-unstable,
    self,
    systems,
    ...
  }:
  let
    inherit (self) outputs;

    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f system);
    eachSystemPkgs = f: nixpkgs.lib.genAttrs (import systems) (system: f (import nixpkgs { inherit system; }));

    nixpkgs-local = eachSystemPkgs (pkgs: import ./ext/_.nix { inherit pkgs; });
    lib = import ./lib { inherit inputs outputs nixpkgs nixpkgs-unstable nixpkgs-local systems; };
    #my-options = import ./lib/options.nix;
  in
  {
    # Expose lib for host-specific flakes.
    my-lib = lib;
    #my-options = my-options;

    # Expose custom packages.
    # This allows for `nix run .#shelve`.
    packages = nixpkgs-local;

    # Dev shells.
    devShells = eachSystem (system: import ./shells/_.nix
    {
      inherit system;
      pkgs = lib.get-pkgs nixpkgs system;
    });
  };
}
