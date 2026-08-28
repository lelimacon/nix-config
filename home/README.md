# Home Manager

Configurations for home-manager.


## Folder Structure

- `desktops/`: Desktop environments
- `modules/`: Programs and their customization
- `profiles/`: Profiles to cherry pick the desktops and modules


## Package Migration Analysis

Analysis of which home-manager modules can be moved to system configuration and how.

Four categories:

- **As-is**: only `home.packages` (and possibly `home.sessionVariables` replaceable by `environment.variables`), trivially moved to `environment.systemPackages`
- **nix-wrapper-modules**: has a built-in wrapper in the library (`wrappers.wrappers.<name>.wrap`) that can embed the config
- **Custom wrapper**: config achievable via `makeWrapper`, store-path config file, or `environment.shellAliases` — but no pre-built nix-wrapper-modules wrapper
- **Home-manager only**: genuinely per-user: GTK/dconf theming, browser profiles, IDE extension state, shell init files that reference `$HOME`

Note: `home.sessionVariables` is not a fundamental blocker — it maps directly to `environment.variables` (NixOS/nix-darwin) at system level.

### Already moved


| Module | Tool | Reason |
|--------|------|--------|
| `console/kitty.nix` | kitty | Settings map directly to `kitty.conf` options; wrapper available. |
| `dev/vscode.nix` | vscodium | No wrapper; per-user keybindings, color theme customizations, and extension settings via `programs.vscodium`. |
| `social/firefox/default.nix` | firefox | No wrapper; per-user profile, `userChrome`, toolbar layout, and search engines via `programs.firefox`. |
| `dev/starship.nix` | starship | **Already done** in `pkgs/starship/default.nix`. |
| `console/nushell/default.nix` | nushell | Wrapper available. Current code reads `config.home.sessionVariables` — needs refactoring to explicit values, but the config and carapace init can be embedded. |
| `console/bash.nix` | bash | No nix-wrapper-modules wrapper; per-user `initExtra` loads `~/.private.bashrc` and sets `STORE_ROOT`. |


### Movable as-is

| Module | Packages | Notes |
|--------|----------|-------|
| `console/ghostty.nix` | ghostty | |
| `dev/ai.nix` | llama-cpp, ollama, qwen-code, goose-cli, uv, python3 | |
| `dev/asdf.nix` | asdf-vm | |
| `dev/aws.nix` | awscli2, ssm-session-manager-plugin, aws-sam-cli | |
| `dev/beam.nix` | erlang, elixir, gleam, dexter | Session vars (`ERL_TOP`, `*_SDK_HOME`) move to `environment.variables`. |
| `dev/containerization.nix` | docker, lazydocker | |
| `dev/db.nix` | jetbrains.datagrip | |
| `dev/dotnet.nix` | jetbrains.rider | Self-contained override. |
| `dev/gamedev.nix` | unityhub | |
| `dev/general.nix` | toybox, wget, curl, jq, vim, eza, fontconfig, openssl, cocogitto, ranger, nnn, helix, fresh-editor, go-task, deno | `helix` and `vim` also have nix-wrapper-modules wrappers if config is ever needed. |
| `dev/go.nix` | go, gopls, jetbrains.goland | |
| `dev/gtk.nix` | icon-library | |
| `dev/java.nix` | jdk21, kotlin, maven, gradle, jetbrains.idea | `programs.java` just sets `JAVA_HOME`; use `environment.variables.JAVA_HOME` instead. |
| `dev/nix.nix` | nixd | |
| `dev/rust.nix` | jetbrains.rust-rover | |
| `dev/web.nix` | nodejs_22, bun, dart-sass, caddy, postman, bruno, jetbrains.webstorm | |
| `media/docs.nix` | typst, tinymist, poppler-utils, gnome-clocks | |
| `media/emulation.nix` | bottles | |
| `media/games.nix` | xmoto | |
| `media/gfx.nix` | gimp, inkscape, fontforge-gtk, blender, jellyfin-ffmpeg, handbrake | |
| `media/music.nix` | spotify, psst | |
| `media/sfx.nix` | musescore | |
| `media/torrent.nix` | transmission_4-gtk | |
| `media/video.nix` | vlc | |
| `social/chrome.nix` | ungoogled-chromium | |
| `social/play.nix` | telegram-desktop, discord | |
| `social/slack.nix` | slack | |
| `social/teams.nix` | teams-for-linux | |
| `utils/graphviz.nix` | graphviz | |
| `utils/ext.nix` | pkgs-ext.{develop, where, shelve} | |
| `utils/monitoring.nix` | bottom, dgop | `bottom` also has a nix-wrapper-modules wrapper if config is ever needed. |
| `utils/password-manager.nix` | _1password-gui | |

### Wrappable with nix-wrapper-modules out of the box

These tools have a built-in wrapper in the library (confirmed from the `wrapperModules/` directory at rev `6e7f66f`). Config is expressed as a Nix attrset and baked into the package via `wrappers.wrappers.<name>.wrap { inherit pkgs; settings = { ... }; }`.

| Module | Tool | Notes |
|--------|------|-------|
| `dev/git.nix` | git | Wrapper available. All current settings (autocrlf, eol, pull.rebase, user identity) are expressible as Nix attrset. |

### Wrappable with a custom wrapper

No pre-built nix-wrapper-modules wrapper exists, but config can be embedded via other means.

| Module | Tool | Strategy |
|--------|------|----------|
| `utils/fzf.nix` | fzf | Package is plain; shell init scripts ship with fzf and can be sourced from the store path in shell config. |
| `utils/nix-tools.nix` | nix-du, nix-index, nix-inspect, nix-tree | Packages are plain; the `nix-graph` alias can be a script in `pkgs-ext` instead of a shell alias. |

### Home-manager only

| Module | Tool | Reason |
|--------|------|--------|
| `console/gtk.nix` | GTK theme | `gtk.*` and `home.pointerCursor` are per-user dconf/XSettings — no system-level equivalent. |
| `console/shell.nix` | shell aliases/path | Aliases could use `environment.shellAliases`, but `home.sessionPath = ["$HOME/.local/bin"]` is inherently per-user. |
| `dev/mise.nix` | mise | Shell integration hooks into per-user shell init; no nix-wrapper-modules wrapper. |
