/*
Firefox browser configuration.

Known issues :
- Screensharing not working

Settings errors in `about:policies#errors`.
*/
{
  inputs,
  pkgs,
  ...
}:
let
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

  # Addons with https://github.com/OsiPog/nix-firefox-addons.
  # TODO: Most settings don't work.
  #firefoxAddons = inputs.nix-firefox-addons.addons.${pkgs.system};
  #mkAddon = slug: id:
  #{
  #  slug = slug;
  #  id = id;
  #  package = firefoxAddons.${slug};
  #};
  #addons.tree-style-tab = mkAddon "tree-style-tab" "treestyletab@piro.sakura.ne.jp";
in
{
  # Sources :
  # https://github.com/llakala/nixos/blob/main/wrappers/config/firefox/default.nix

  programs.firefox =
  {
    enable = true;

    policies =
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

      # Other.
      DisablePocket = true;
      DisableFirefoxStudies = true;
      HardwareAcceleration = true;
      Preferences."extensions.pocket.enabled" = lock-false;
    };

    # UserChrome.
    policies.Preferences."toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    profiles.default =
    {
      userChrome =
      ''
        /* hides the native tabs */
        #TabsToolbar {
          visibility: collapse;
        }
      '';
      #userContent =
      #''
      #  @-moz-document url-prefix("moz-extension://"), 
      #                 url-prefix("about:treestyletab") {
      #    ${builtins.readFile ./tree-style-tab.css}
      #  }
      #'';
      userContent =
      ''
        @-moz-document url-prefix("moz-extension://"), 
                      url-prefix("about:treestyletab") {
            .tab.active {
                background: rgba(255,0,0,0.5);
            }
        }
      '';
    };

    # At ~/Library/Application\ Support/Firefox/Profiles
    profiles =
    {
      default =
      {
        id = 0;
        name = "default";
        isDefault = true;
        settings =
        {
          # "browser.startup.homepage" = "https://duckduckgo.com";
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";

          "signon.rememberSignons" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.compactmode.show" = true;
          "browser.cache.disk.enable" = false; # Be kind to hard drive

          "mousewheel.default.delta_multiplier_x" = 200;
          "mousewheel.default.delta_multiplier_y" = 200;
          "mousewheel.default.delta_multiplier_z" = 200;

          # Firefox 75+ remembers the last workspace it was opened on as part of its session management.
          # This is annoying, because I can have a blank workspace, click Firefox from the launcher, and
          # then have Firefox open on some other workspace.
          "widget.disable-workspace-management" = true;
        };
        search =
        {
          force = true;
          default = "ddg";
          order = [ "ddg" "nixpkgs" ];
          engines = {
            "ddg" =
            {
              #Name = "DuckDuckGo"; # TODO find label.
              icon = "https://duckduckgo.com/favicon.ico";
              urls =
              [
                {
                  template = "https://start.duckduckgo.com/?t=ffab&ia=web&q={searchTerms}";
                }
              ];
            };
            "nixpkgs" =
            {
              #name = "Nix packages";
              Alias = "@npkgs";
              urls =
              [
                {
                  template = "https://github.com/search?type=code&q=repo:NixOS/nixpkgs+lang:nix+{searchTerms}";
                }
              ];
            };
            "Home Manager" =
            {
              #name = "Home Manager";
              Alias = "@hmgr";
              urls =
              [
                {
                  template = "https://github.com/search?type=code&q=repo:nix-community/home-manager+lang:nix+{searchTerms}";
                }
              ];
            };
            "Home Manager Options" =
            {
              #name = "Home Manager Options";
              Alias = "@oh";
              icon = "https://home-manager-options.extranix.com/images/favicon.png";
              urls =
              [
                {
                  template = "https://home-manager-options.extranix.com/?release=master";
                  params =
                  [
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
            };
            "NixOS Options" =
            {
              #name = "NixOS Options";
              Alias = "@on";
              urls =
              [
                {
                  template = "https://search.nixos.org/options?channel=unstable&from=0&size=100&sort=alpha_asc";
                  params =
                  [
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }
              ];
            };
          };
        };
      };
    };

    # Extensions.
    /*
    profiles.default.extensions =
    {
      force = true;
      packages =
      [
        addons.tree-style-tab.package
      ];

      settings."${addons.tree-style-tab.id}".settings =
      {
        toto = 42;
      };
    };

    # optional: without this the addons need to be enabled manually after first install
    profiles.default.settings = {
      "extensions.autoDisableScopes" = 0;
    };
    */
  };
}
