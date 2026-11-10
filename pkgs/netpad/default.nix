# tareqimbasher/NetPad
# LINQPad OSS alternative.
# Also see roslynpad/roslynpad.
#
# NetPad ships two very different bootstrap packages per platform: darwin
# unpacks a .dmg app bundle (undmg) while linux unpacks a .deb (dpkg) with a
# distinct set of native runtime libraries (webkitgtk/gtk3) -- kept as
# separate files rather than branching one derivation.
{
  stdenv,
  callPackage,
  dotnetCorePackages,
  dotnet-ef,
  buildDotnetGlobalTool,
}:
let
  # nixpkgs' dotnet-ef builds against the source-built sdk_10_0, and
  # buildDotnetGlobalTool's `dotnet-runtime` default silently falls back to
  # the top-level (also source-built) sdk_8_0 instead of the tool's own SDK.
  # Whenever Hydra lags behind a nixpkgs bump, both get compiled locally from
  # the VMR for hours. Pin both to Microsoft's prebuilt binaries instead.
  dotnet-ef-bin = dotnet-ef.override
  {
    dotnetCorePackages = dotnetCorePackages // { sdk_10_0 = dotnetCorePackages.sdk_10_0-bin; };
    buildDotnetGlobalTool = buildDotnetGlobalTool.override { dotnet-sdk = dotnetCorePackages.sdk_10_0-bin; };
  };
in
if stdenv.isDarwin then
  callPackage ./darwin.nix { dotnet-ef = dotnet-ef-bin; }
else
  callPackage ./linux.nix { dotnet-ef = dotnet-ef-bin; }
