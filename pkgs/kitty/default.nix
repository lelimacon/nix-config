# Console-related wrapped packages, grouped here as none of them warrants
# its own directory.
{
  config,
  pkgs,
  wrappers,
  ...
}:
wrappers.wrappers.kitty.wrap
{
  inherit pkgs;

  font =
  {
    name = config.theme.monoFont.frozenFamily;
    size = config.theme.monoFont.size;
  };

  settings =
  {
    confirm_os_window_close = 0;

    enable_audio_bell = true;

    mouse_hide_wait = "-1.0"; # hide cursor immediately when typing.

    window_padding_width = 2;

    dynamic_background_opacity = true;
    background_opacity = "1";
    background_blur = 0;
  };
}
