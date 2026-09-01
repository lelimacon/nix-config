# Firefox content (page) stylesheet.
# Synced into chrome/userContent.css.
{
  config,
  ...
}:
let
  colors = config.theme.colors;
in
''
  @-moz-document url-prefix("moz-extension://"),
                url-prefix("about:treestyletab") {
      .tab.active {
          #background: ${colors.primary};
          background: rgba(129, 231, 176, 0.5);
      }
  }
''
