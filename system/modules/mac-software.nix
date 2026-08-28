{
  config,
  ...
}:
{
  # Privacy.
  system.defaults.CustomUserPreferences =
  {
    "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
  };

  # Show battery percentage.
  system.defaults.CustomUserPreferences =
  {
    "/Users/${config.user.name}/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = true;
  };

  # TODO: Does not seem to work.
  # Menu bar clock: ISO date (YYYY-MM-DD), 24h time.
  system.defaults.menuExtraClock =
  {
    Show24Hour = true;
    ShowAMPM = false;
    ShowDate = 1;
  };
  system.defaults.CustomUserPreferences =
  {
    "com.apple.menuextra.clock".DateFormat = "yyyy-MM-dd  HH:mm";
  };

  # Screen.
  system.defaults.screensaver =
  {
    askForPasswordDelay = 10;
  };

  # Dock.
  system.defaults.dock =
  {
    autohide = true;
    autohide-delay = 0.2;
    autohide-time-modifier = 0.1;
    magnification = false;
    mru-spaces = false; # don't rearrange spaces based on most recent.
    mineffect = "genie"; # the worst of all.
    minimize-to-application = true;
    showhidden = false;
    show-recents = false;
    tilesize = 40;
  };

  # Finder.
  system.defaults.finder =
  {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true; # show hidden files.
    FXPreferredViewStyle = "Nlsv"; # list view.
    CreateDesktop = false; # hide icons on the desktop.
    FXEnableExtensionChangeWarning = false; # no warning when renaming file extension.
    ShowPathbar = true;
    ShowStatusBar = true;

    # Default folder when opening Finder.
    NewWindowTarget = "Other";
    NewWindowTargetPath = "file:///Users/${config.user.name}";
  };

  # Screenshots.
  system.defaults =
  {
    screencapture.location = "~/Pictures/screenshots";
  };

  # Disable Homebrew telemetry.
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  homebrew =
  {
    enable = true;
    casks =
    [
      #"visual-studio-code"
      #"1password" # password manager (installed manually).
      "ungoogled-chromium"
    ];
    brews =
    [
      #"erlang"
      #"elixir"
      "gitversion"
    ];
  };
}
