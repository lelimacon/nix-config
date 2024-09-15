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

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11.
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };

  # Excluded apps.
  environment.gnome.excludePackages = (with pkgs; [
    gnome.epiphany # "Web" browser.
    gnome.geary # email client.
    gnome.totem # video player.
    gnome.evince # document viewer.
    gnome.cheese # webcam.
    gnome.yelp gnome.gnome-initial-setup gnome-tour # assistance apps.
    gnome.gnome-contacts
    gnome.gnome-weather
    gnome.gnome-maps
    gnome.gnome-music
    gnome-photos
  ]);

  # Extensions.
  # https://extensions.gnome.org/
  environment.systemPackages = with pkgs; [
    pkgs.gnome3.gnome-tweaks
    gnomeExtensions.just-perfection
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar
  ];

  programs.dconf.enable = true;

  # Home configuration.
  home-manager.users.lelimacon = {

    home.packages = with pkgs; [
    ];

    # `dconf watch /` to track changes.
    dconf.settings = {
      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true; # show hidden files.
      };
      "org/gnome/shell" = {
        disable-user-extensions = false;
        # `gnome-extensions list` for a list
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "trayIconsReloaded@selfmade.pl"
          "Vitals@CoreCoding.com"
          "dash-to-panel@jderose9.github.com"
          "sound-output-device-chooser@kgshank.net"
          "space-bar@luchrioh"
        ];
        favorite-apps = [
          "firefox.desktop"
          "org.gnome.Nautilus.desktop"
          "org.telegram.desktop.desktop"
          "org.gnome.Console.desktop"
        ];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "default"; # light with dark appbar.
        enable-hot-corners = false; # no flicking to the top-left corner.
        gtk-enable-primary-paste = false; # no pasting with mouse middle click.
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,close";
        workspace-names = [ "Main" ];
      };
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/lelimacon/Pictures/pixel-black.png";
        picture-options = "stretched";
        #primary-color = "#000000";
        #secondary-color = "#000000";
      };
    };

    gtk = {
      enable = true;

      #iconTheme = {
      #  name = "Papirus-Dark";
      #  package = pkgs.papirus-icon-theme;
      #};

      #theme = {
      #  name = "palenight";
      #  package = pkgs.palenight-theme;
      #};

      cursorTheme = {
        name = "Numix-Cursor";
        package = pkgs.numix-cursor-theme;
      };

      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };

      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };

  };
}
