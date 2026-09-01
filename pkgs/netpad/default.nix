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
}:
if stdenv.isDarwin then
  callPackage ./darwin.nix { }
else
  callPackage ./linux.nix { }
