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
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
      #url = "github:nix-community/home-manager";
      #inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-darwin =
    {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      #url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # TODO: Add?
    #nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    wrappers =
    {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @
  {
    wrappers,
    nixpkgs,
    nixpkgs-unstable,
    self,
    systems,
    ...
  }:
  let
    inherit (self) outputs;

    get-pkgs = nixpkgs: system: import nixpkgs
    {
      system = system;
      config =
      {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f system);
    #eachSystemPkgs = f: nixpkgs.lib.genAttrs (import systems) (system: f (import nixpkgs { inherit system; }));

    nixpkgs-local = eachSystem (system:
      let
        pkgs = get-pkgs nixpkgs system;
        pkgs-unstable = get-pkgs nixpkgs-unstable system;
        #{
        #  inherit (pkgs) system;
        #  config = { allowUnfree = true; allowUnfreePredicate = _: true; };
        #};
      in
      (import ./ext/index.nix { inherit pkgs; }) //
      (import ./pkgs/index.nix { inherit pkgs pkgs-unstable wrappers; })
    );
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
    devShells = eachSystem (system: import ./shells/index.nix
    {
      inherit system;
      pkgs = lib.get-pkgs nixpkgs system;
    });
  };
}
