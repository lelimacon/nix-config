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
    pkgs-unstable.paseo-desktop

    # Coding agents.
    opencode
    goose-cli # configured at `~/.config/goose/config.yaml`.
    qwen-code
    pkgs-unstable.pi-coding-agent
  ];
}
