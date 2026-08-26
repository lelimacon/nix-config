/*
Profile prefs, written into user.js and synced into the live profile dir at
every launch (see default.nix — unlike policies.nix, this dir is writable
and Firefox keeps its own state alongside these).
*/
{
  # "browser.startup.homepage" = "https://duckduckgo.com";
  "browser.search.defaultenginename" = "DuckDuckGo";
  "browser.search.order.1" = "DuckDuckGo";
  "browser.aboutConfig.showWarning" = false;
  "browser.compactmode.show" = true;
  "browser.cache.disk.enable" = false; # be kind to hard drive.
  "browser.tabs.inTitlebar" = 0; # show native system titlebar.

  "signon.rememberSignons" = false;

  "mousewheel.default.delta_multiplier_x" = 200;
  "mousewheel.default.delta_multiplier_y" = 200;
  "mousewheel.default.delta_multiplier_z" = 200;

  # Firefox 75+ remembers the last workspace it was opened on as part of its session management.
  # This is annoying, because I can have a blank workspace, click Firefox from the launcher, and
  # then have Firefox open on some other workspace.
  "widget.disable-workspace-management" = true;

  # Toolbar configuration.
  # Extracted from `about:config` > `browser.uiCustomization.state`.
  "browser.uiCustomization.state" = builtins.toJSON
  {
    placements =
    {
      nav-bar =
      [
        "back-button"
        "forward-button"
        "stop-reload-button"
        "vertical-spacer"
        "urlbar-container"
        "personal-bookmarks"
        "downloads-button"
        "unified-extensions-button"
        "ublock0_raymondhill_net-browser-action"
      ];
      widget-overflow-fixed-list =
      [
        "fxa-toolbar-menu-button" # account.
      ];
      unified-extensions-area =
      [
        "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action" # 1password.
        "treestyletab_piro_sakura_ne_jp-browser-action" # TreeStyleTab.
        "amptra_keepa_com-browser-action" # Keepa.
      ];
    };
    currentVersion = 23;
    newElementCount = 7;
  };
}
