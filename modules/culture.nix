{
  ...
}:
let
  locale-fr = "fr_FR.UTF-8";
  locale-us = "en_US.UTF-8";
in
{
  # Console keymap.
  #console.keyMap = "fr";
  console.keyMap = "br-abnt2";

  # Timezone.
  #time.timeZone = "Asia/Hong_Kong";
  time.timeZone = "Europe/Paris";

  # Locale.
  i18n.defaultLocale = locale-us;
  i18n.extraLocaleSettings =
  {
    LANGUAGE = locale-us;
    LANG = locale-us;
    #LC_ALL = locale-us;
    LC_MESSAGES = locale-us;
    LC_ADDRESS = locale-fr;
    LC_IDENTIFICATION = locale-fr;
    LC_MEASUREMENT = locale-fr;
    LC_MONETARY = locale-fr;
    LC_NAME = locale-fr;
    LC_NUMERIC = locale-fr;
    LC_PAPER = locale-fr;
    LC_TELEPHONE = locale-fr;
    LC_TIME = locale-fr;
  };
}
