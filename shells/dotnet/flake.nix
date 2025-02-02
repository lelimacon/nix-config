{
  description = ".NET shell";

  inputs =
  {
    flake-utils =
    {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    systems.url = "github:nix-systems/x86_64-linux";
  };

  outputs =
  {
    flake-utils,
    nixpkgs,
    self,
    ...
  }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs
      {
        system = system;
        config =
        {
          # For dotnet 6.
          permittedInsecurePackages =
          [
            "dotnet-core-combined"
            "dotnet-sdk-6.0.428"
            "dotnet-sdk-wrapped-6.0.428"
          ];
        };
      };
      dotnet-sdks = with pkgs; dotnetCorePackages.combinePackages
      [
        dotnetCorePackages.sdk_6_0
        dotnetCorePackages.sdk_8_0
        dotnetCorePackages.sdk_9_0
      ];
    in
    {
      # To run Rider :
      # $ nix develop path:./shells/dotnet --command rider
      devShells.default = pkgs.mkShell
      {
        buildInputs = with pkgs;
        [
          dotnet-sdks
          #dotnet-ef # Entity Framework tools.
          powershell
        ];
      };
    }
  );
}
