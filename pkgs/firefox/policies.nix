# Firefox enterprise policies, baked into the wrapped package at build time.
# Errors in `about:policies#errors`.
let
  extensionsBaseUrl = "https://addons.mozilla.org/firefox/downloads/latest";
  lock-false =
  {
    Value = false;
    Status = "locked";
  };
  lock-true =
  {
    Value = true;
    Status = "locked";
  };
  lock-empty-string =
  {
    Value = "";
    Status = "locked";
  };
in
{
  # Security / Privacy.
  DisableTelemetry = true;
  Preferences."toolkit.telemetry.server" = "";
  DontCheckDefaultBrowser = false; # make sure FF is the default browser.
  Preferences."browser.topsites.contile.enabled" = lock-false;
  FirefoxSuggest =
  {
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
  };
  EnableTrackingProtection =
  {
    Value = true;
    Cryptomining = true;
    Fingerprinting = true;
  };

  # Search.
  SearchBar = "unified";
  SearchEngines =
  {
    Default = "DuckDuckGo";
    Add =
    [
      {
        Name = "DuckDuckGo";
        IconURL = "https://duckduckgo.com/favicon.ico";
        URLTemplate = "https://start.duckduckgo.com/?t=ffab&ia=web&q={searchTerms}";
      }
      {
        Name = "Nix packages";
        Alias = "@npkgs";
        URLTemplate = "https://github.com/search?type=code&q=repo:NixOS/nixpkgs+lang:nix+{searchTerms}";
      }
      {
        Name = "Home Manager";
        Alias = "@hmgr";
        URLTemplate = "https://github.com/search?type=code&q=repo:nix-community/home-manager+lang:nix+{searchTerms}";
      }
      {
        Name = "Home Manager Options";
        Alias = "@oh";
        IconURL = "https://home-manager-options.extranix.com/images/favicon.png";
        URLTemplate = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";
      }
      {
        Name = "NixOS Options";
        Alias = "@on";
        URLTemplate = "https://search.nixos.org/options?channel=unstable&from=0&size=100&sort=alpha_asc&query={searchTerms}";
      }
    ];
  };

  # Extensions installed from AMO on first launch.
  Extensions.Install =
  [
    "${extensionsBaseUrl}/ublock-origin/latest.xpi"
    "${extensionsBaseUrl}/tree-style-tab/latest.xpi"
    "${extensionsBaseUrl}/highlightall/latest.xpi"
    "${extensionsBaseUrl}/1password-x-password-manager/latest.xpi"
  ];

  # Start behavior.
  Homepage.StartPage = "previous-session";
  Preferences."browser.newtabpage.activity-stream.showSponsored" = lock-false;
  Preferences."browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
  Preferences."browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
  Preferences."browser.newtabpage.pinned" = lock-empty-string;
  FirefoxHome = # make new tab only show search.
  {
    Search = true;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    SponsoredPocket = false;
    Snippets = false;
  };

  # Appearence.
  DisplayBookmarksToolbar = "never"; # bookmarks are shown on URL bar instead.

  # Space after word selection.
  Preferences =
  {
    "editor.word_select.delete_space_after_doubleclick_selection" = lock-true;
    "layout.word_select.eat_space_to_next_word" = lock-false;
  };

  # UserChrome.
  Preferences."toolkit.legacyUserProfileCustomizations.stylesheets" = true;

  # Other.
  DisablePocket = true;
  DisableFirefoxStudies = true;
  HardwareAcceleration = true;
  Preferences."extensions.pocket.enabled" = lock-false;
}
