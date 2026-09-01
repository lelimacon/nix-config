# tareqimbasher/NetPad -- linux (vNext/Tauri shell) bootstrap.
#
# The upstream release is a .deb built by the Tauri bundler. Its layout is
# usr/bin/netpad-vnext (the native GTK/WebKit shell) plus a sibling
# usr/lib/"NetPad vNext"/ holding the self-contained .NET server the shell
# talks to -- Tauri resolves that resource dir at runtime as ../lib/<name>
# relative to its own (symlink-resolved) executable path, so that relative
# layout has to be preserved wherever we end up exec'ing the real binary
# from. See darwin.nix for the equivalent macOS bootstrap.
{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  autoPatchelfHook,
  wrapGAppsHook3,
  gtk3,
  webkitgtk_4_1,
  glib,
  cairo,
  gdk-pixbuf,
  pango,
  libsoup_3,
  openssl,
  icu,
  zlib,
  libunwind,
  krb5,
  dotnetCorePackages,
  dotnet-ef,
}:
let
  version = "0.12.0";

  # See darwin.nix: NetPad scripts run through the .NET SDK itself, not just
  # a runtime, and this needs to stay in sync with that file's set.
  dotnet-sdks = dotnetCorePackages.combinePackages
  [
    dotnetCorePackages.sdk_9_0
    dotnetCorePackages.sdk_10_0
  ];
in
stdenv.mkDerivation
{
  pname = "netpad-vnext";
  version = version;
  meta =
  {
    description = "Cross-platform C# editor and playground (Tauri native shell)";
    homepage = "https://github.com/tareqimbasher/NetPad";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "netpad-vnext";
  };

  src = fetchurl
  {
    url = "https://github.com/tareqimbasher/NetPad/releases/download/v${version}/netpad_vnext-${version}-linux-amd64.deb";
    hash = "sha256-iikPLrNXZEyBETCAlk3fTI0oyJ/vnPrSovrMSLBT1H0=";
  };

  nativeBuildInputs = [ dpkg autoPatchelfHook wrapGAppsHook3 ];

  # NEEDED entries of usr/bin/netpad-vnext (GTK/WebKit shell) plus the
  # self-contained CoreCLR server's native shims -- autoPatchelfHook resolves
  # both against this set.
  buildInputs =
  [
    gtk3
    webkitgtk_4_1
    glib
    cairo
    gdk-pixbuf
    pango
    libsoup_3
    openssl
    icu
    zlib
    libunwind
    krb5
    stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  dontBuild = true;

  # The real binary+resources live under libexec, one level further down
  # than upstream's usr/bin + usr/lib -- their relative bin/../lib/<name>
  # relationship (see file header) is preserved either way, since it only
  # depends on the two staying siblings, not on their absolute depth.
  installPhase = ''
    runHook preInstall

    mkdir -p "$out/libexec/netpad-vnext" "$out/bin" "$out/share"
    cp -a usr/bin "$out/libexec/netpad-vnext/bin"
    cp -a "usr/lib/NetPad vNext" "$out/libexec/netpad-vnext/lib"
    cp -a usr/share/icons "$out/share/icons"

    install -Dm644 "usr/share/applications/NetPad vNext.desktop" \
      "$out/share/applications/netpad-vnext.desktop"
    substituteInPlace "$out/share/applications/netpad-vnext.desktop" \
      --replace-fail "Exec=netpad-vnext" "Exec=$out/bin/netpad-vnext"

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
    # permission bits, so the in-place rewrite fails with
    # UnauthorizedAccessException. Run from a writable cache copy instead,
    # mirroring the bin/+lib/ layout so Tauri's relative resource lookup
    # (see file header) still resolves from inside the cache.
    cache="\$HOME/.cache/netpad-vnext/$(basename $out)"
    if [ ! -e "\$cache/done" ]; then
      rm -rf "\$cache"
      mkdir -p "\$cache"
      cp -a "$out/libexec/netpad-vnext/bin" "$out/libexec/netpad-vnext/lib" "\$cache/"
      chmod -R u+w "\$cache"
      touch "\$cache/done"
    fi
    exec "\$cache/bin/netpad-vnext" "\$@"
    WRAPPER
    chmod +x $out/bin/netpad-vnext

    runHook postInstall
  '';
}
