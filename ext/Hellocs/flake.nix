{
  description = "Test dotnet console app";

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
  {
    self,
    nixpkgs,
    flake-utils,
  }:
  flake-utils.lib.eachDefaultSystem (system: {
    packages.default =
      let
        pkgs = import nixpkgs { system = system; };
        buildDotnetModule = pkgs.dotnetCorePackages.buildDotnetModule;
      in
      buildDotnetModule rec
      {
        pname = "hellocs";
        version = "0.4.2";

        src = ./.;

        projectFile = "Hellocs.csproj";

        dotnet-sdk = pkgs.dotnetCorePackages.sdk_8_0;
        dotnet-runtime = pkgs.dotnetCorePackages.runtime_8_0;

        executables = [ "Hellocs" ];
      };
  });
}
