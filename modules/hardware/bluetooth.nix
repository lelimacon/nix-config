{
  ...
}:
{
  # Bluetooth.
  hardware.bluetooth.enable = true;
  # Fix for Bluez.
  # https://github.com/NixOS/nixpkgs/issues/170573
  systemd.services."bluetooth".serviceConfig =
  {
    StateDirectory = "";
  };
}
