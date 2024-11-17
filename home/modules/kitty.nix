{
  ...
}:
{
  # Kitty.
  programs.kitty =
  {
    enable = true;

    settings =
    {
      confirm_os_window_close = 0;

      enable_audio_bell = true;

      mouse_hide_wait = "-1.0"; # hide cursor immediately when typing.

      window_padding_width = 2;

      dynamic_background_opacity = true;
      background_opacity = "1";
      background_blur = 0;

      font_size = 12;
      font_family = "Fira Code";
    };
  };
}
