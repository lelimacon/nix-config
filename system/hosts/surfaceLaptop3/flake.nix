{
  description = "Host-specific flake";

  inputs =
  {
    # home-manager =
    # {
    #   url = "github:nix-community/home-manager/release-25.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # TODO: Add?
    #nix-flatpak.url = "github:gmodena/nix-flatpak/main";

    #nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    #systems.url = "github:nix-systems/x86_64-linux";

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
    home-config-path = ../../../home/profiles/surface-laptop-3.nix;
    vars =
    {
      system = "x86_64-linux";
      config.path = ./.;
      config.rev = self.rev or self.dirtyRev or null;
      user.name = "lelimacon";
      user.homeDirectory = "/home/lelimacon";
      hostName = "surfaceLaptop3";
      theme =
      {
        # https://colorhunt.co/palette/fffbf1fff2d0ffb2b2e36a6a
        colors.primary = "#E36A6A";
        colors.primary-dark = "#755757";
        colors.primary-light = "#FFF2D0";
        colors.primary-lighter = "#FFFBF1";
        colors.primary-fg = "#FFFBF1";
        colors.primary-fg-strong = "#fff";
        colors.fg = "#3f1e1e";
        colors.fg-strong = "#000";
        colors.bg = "#FFFBF1";
        colors.bg-soft = "#FFFBF1";
        colors.bg-strong = "#fff";
        colors.border = "#654141ff";
        colors.border-soft = "#b6a8a8ff";
        colors.border-strong = "#3f1e1e";
      };
    };
  in
  {
    # System configuration with Home Manager.
    nixosConfigurations."${vars.hostName}" =
      common.my-lib.mkNixosSystemWithHome { inherit vars config-path home-config-path; };

    # Standalone Home Manager configuration.
    # `home-manager switch`.
    # Home Manager is also tied to system configuration.
    homeConfigurations."${vars.user.name}" =
      common.my-lib.mkHomeConfiguration { inherit vars home-config-path; };
  };
}
