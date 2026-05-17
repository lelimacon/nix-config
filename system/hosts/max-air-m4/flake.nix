{
  description = "Host-specific flake";

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    common =
    {
      url  = "./../../../";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };
  };

  outputs =
  {
    common,
    self,
    ...
  }:
  let
    config-path = ./configuration.nix;
    home-config-path = ../../../home/profiles/max-air-m4.nix;
    vars =
    {
      system = "aarch64-darwin";
      config.path = ./.;
      config.rev = self.rev or self.dirtyRev or null;
      user.name = "max";
      user.homeDirectory = "/Users/max";
      hostName = "max-air-m4";
      theme =
      {
        # Theme colors.
        # https://tailwindcss.com/docs/colors
        colors.primary = "#db2777"; # Pink 600.
        colors.primary-dark = "#9d174d"; # Pink 800.
        colors.primary-light = "#fce7f3"; # Pink 100.
        colors.primary-lighter = "#fdf2f8"; # Pink 50.
        colors.primary-fg = "#FFFBF1";
        colors.primary-fg-strong = "#fff";
        colors.fg = "#1c1917"; # Stone 900.
        colors.fg-strong = "#000"; # Stone 900.
        colors.bg = "#FFFBF1";
        colors.bg-soft = "#FFFBF1";
        colors.bg-strong = "#fff";
        colors.border = "#1c1917"; # Stone 900.
        colors.border-soft = "#b6a8a8ff";
        colors.border-strong = "#1c1917"; # Stone 900.
      };
    };
  in
  {
    # System configuration with Home Manager.
    darwinConfigurations."${vars.hostName}" =
      common.lib.mkDarwinSystemWithHome { inherit vars config-path home-config-path; };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    # Home Manager is also tied to system configuration.
    homeConfigurations."${vars.hostName}-${vars.user.name}" =
      common.lib.mkHomeConfiguration { inherit vars home-config-path; };
  };
}
