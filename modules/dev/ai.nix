{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    # ADEs.
    pkgs-unstable.paseo

    # Coding agents.
    opencode
    goose-cli # configured at `~/.config/goose/config.yaml`.
    qwen-code
  ];
}
