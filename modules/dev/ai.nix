{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  # skills.sh registry, as `<owner>.<repo>.<skill>`.
  skills = inputs.agents-nix.agent-skills.${pkgs.stdenv.hostPlatform.system}.github;
in
{
  # Agent skills, linked one by one into the shared skills folder (read by
  # Claude Code through `~/.claude/skills -> ~/.agents/skills`). The folder
  # itself stays writable so `npx skills add` can still install others.
  hjem.users.${config.user.name}.files =
  {
    ".agents/skills/grill-me".source = skills.mattpocock.skills.grill-me;
    ".agents/skills/improve-codebase-architecture".source = skills.mattpocock.skills.improve-codebase-architecture;
    ".agents/skills/ponytail".source = skills.dietrichgebert.ponytail.ponytail;
  };

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
