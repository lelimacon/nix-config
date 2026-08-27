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

    get-pkgs = import ./lib/get-pkgs.nix;

    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f system);
    #eachSystemPkgs = f: nixpkgs.lib.genAttrs (import systems) (system: f (import nixpkgs { inherit system; }));

    # Used for this flake's own packages (e.g. `nix run .#goland` from the
    # repo root), where there's no real host to pull a `host-config` from.
    # Evaluating the bare options module gives us its built-in defaults
    # (theme, user, ...) without tying it to any specific host.
    default-host-config = (nixpkgs.lib.evalModules { modules = [ ./lib/host-options.nix ]; }).config;

    local-pkgs = import ./lib/local-pkgs.nix { inherit wrappers; };

    nixpkgs-ext = eachSystem (system:
      local-pkgs.pkgs-ext { pkgs = get-pkgs nixpkgs system; }
    );

    # Keyed off a `host-config` for host-specific customization (e.g. theme
    # colors).
    nixpkgs-wrappers = eachSystem (system:
      local-pkgs.pkgs-wrappers
      {
        pkgs = get-pkgs nixpkgs system;
        pkgs-unstable = get-pkgs nixpkgs-unstable system;
        config = default-host-config;
      }
    );

    lib = import ./lib { inherit inputs outputs nixpkgs nixpkgs-unstable systems; };
    #my-options = import ./lib/host-options.nix;
  in
  {
    # Expose lib for host-specific flakes.
    my-lib = lib;
    #my-options = my-options;

    # Expose custom packages.
    # This allows for `nix run .#shelve`/`nix run .#goland`.
    packages = eachSystem (system: nixpkgs-ext.${system} // nixpkgs-wrappers.${system});

    # Dev shells.
    devShells = eachSystem (system: import ./shells/index.nix
    {
      inherit system;
      pkgs = get-pkgs nixpkgs system;
    });
  };
}
