# tareqimbasher/NetPad -- darwin (vNext/Tauri shell) bootstrap.
#
# Known limitation (not fixable here, not a packaging issue): scaffolding a
# Postgres data connection can fail outright if the schema has any foreign
# key whose column type doesn't match its referenced primary key's column
# type (e.g. a `bigint` FK pointing at an `int` PK). EF Core's scaffolder
# throws `System.InvalidOperationException: The types of the properties
# specified for the foreign key ... do not match the types of the
# properties in the principal key ...` and aborts scaffolding the whole
# connection rather than skipping just that relationship. dotnet-ef itself
# works fine (confirmed connecting and scaffolding most of the schema);
# this is an upstream EF Core/NetPad limitation. Fix the schema's FK/PK
# type mismatch, or wait for a NetPad release that skips bad FKs instead
# of failing the whole scaffold.
{
  lib,
  stdenvNoCC,
  fetchurl,
  undmg,
  dotnetCorePackages,
  dotnet-ef,
}:
let
  version = "0.12.0";

  # NetPad scripts run through the .NET SDK itself (Roslyn compilation, EF
  # tooling, etc.), so it needs a full SDK, not just a runtime. Mirrors the
  # version set from `shells/dotnet.nix`, bumped to include the latest SDK.
  dotnet-sdks = dotnetCorePackages.combinePackages
  [
    dotnetCorePackages.sdk_9_0
    dotnetCorePackages.sdk_10_0
  ];
in
stdenvNoCC.mkDerivation
{
  pname = "netpad-vnext";
  version = version;
  meta =
  {
    description = "Cross-platform C# editor and playground (Tauri native shell)";
    homepage = "https://github.com/tareqimbasher/NetPad";
    license = lib.licenses.mit;
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "netpad-vnext";
  };

  # NetPad ships two desktop shells (Electron and the newer, lighter Tauri
  # "vNext" native shell) from the same release; this tracks vNext.
  src = fetchurl
  {
    url = "https://github.com/tareqimbasher/NetPad/releases/download/v${version}/netpad_vnext-${version}-mac-aarch64.dmg";
    hash = "sha256-5u9VnW5w5UIRhfbgpGJNFctfqKzU1FL4cG4pquUvI4I=";
  };

  nativeBuildInputs = [ undmg ];
  sourceRoot = ".";

  installPhase =
  ''
    mkdir -p $out/Applications $out/bin
    cp -a "NetPad vNext.app" $out/Applications/

    # `exec`'d directly (rather than via a symlink, and without going through
    # `open`) so the real absolute Contents/MacOS path is what the app sees as
    # its own executable path -- it uses that to locate its bundled .NET
    # server under Contents/Resources, which breaks if invoked via a symlink.
    # Going through a plain shell script (instead of `open`) lets DOTNET_ROOT
    # and PATH reach the app, since GUI apps launched via `open`/LaunchServices
    # don't inherit the caller's environment.
    cat > $out/bin/netpad-vnext <<WRAPPER
    #!/bin/sh
    export DOTNET_ROOT="${dotnet-sdks}/share/dotnet"
    export PATH="${dotnet-sdks}/share/dotnet:${dotnet-ef}/bin:\$PATH"

    # NetPad's EF discovery doesn't just search PATH -- it also (or instead)
    # looks for the tool installed the way \`dotnet tool install -g\` would,
    # under ~/.dotnet/tools. Symlink it there too, without clobbering a real
    # \`dotnet tool install\`-managed one if the user already has one.
    if [ ! -e "\$HOME/.dotnet/tools/dotnet-ef" ]; then
      mkdir -p "\$HOME/.dotnet/tools"
      ln -s "${dotnet-ef}/bin/dotnet-ef" "\$HOME/.dotnet/tools/dotnet-ef"
    fi

    # Everything under the Nix store is permanently read-only. NetPad's
    # script-host copies parts of its bundled .NET server into a /tmp working
    # dir per script run and then rewrites files in place (e.g. its
    # runtimeconfig.json) -- and that copy preserves the source's (read-only)
    # permission bits on macOS, so the in-place rewrite fails with
    # UnauthorizedAccessException. Run from a writable cache copy instead.
    cache="\$HOME/Library/Caches/netpad-vnext/$(basename $out)"
    if [ ! -e "\$cache/done" ]; then
      rm -rf "\$cache"
      mkdir -p "\$cache"
      cp -a "$out/Applications/NetPad vNext.app" "\$cache/"
      chmod -R u+w "\$cache/NetPad vNext.app"
      touch "\$cache/done"
    fi
    exec "\$cache/NetPad vNext.app/Contents/MacOS/NetPad vNext" "\$@"
    WRAPPER
    chmod +x $out/bin/netpad-vnext
  '';
}
