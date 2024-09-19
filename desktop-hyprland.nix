{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11.
  services.xserver.exportConfiguration = true; # enable `localectl`.
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  programs.hyprland = {
    enable = true;

    # Enable X applications.
    xwayland.enable = true;
  };

  # Required for the default Hyprland config.
  #programs.kitty.enable = true;

  environment.sessionVariables = {
    # If your cursor becomes invisible.
    WLR_NO_HARDWARE_CURSORS = "1";

    # Hint electron apps to use wayland.
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    # Opengl.
    opengl.enable = true;

    # Most wayland compositors need this.
    nvidia.modesetting.enable = true;
  };

  # XDG portal (handles interactions between apps).
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Extensions.
  # https://extensions.gnome.org/
  environment.systemPackages = with pkgs; [
    waybar # top bar.
    kitty # terminal emulator.
    libnotify dunst # notifications.
    anyrun walker # app launchers.
    swww # wallpaper daemon.
    networkmanagerapplet # tray applet for managing networks
    cinnamon.nemo # file explorer

    # Fix for waybar.
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
  ];

  # Home configuration.
  home-manager.users.lelimacon = {

    home.pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    gtk = {
      enable = true;

      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };

      iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };

  };
}
