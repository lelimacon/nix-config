# Run unpatched prebuilt binaries (`nix-ld`).
# Flutter/Android tooling pulls in dynamically linked binaries that expect an
# FHS layout the store doesn't have (Gradle natives, `aapt2` and friends from
# the SDK, `sdkmanager`'s own helpers, ...). `nix-ld` becomes the ELF
# interpreter for anything Nix didn't patch, so those binaries find a `ld.so`
# and a library path at run time.
#
# NixOS only: there is no nix-darwin equivalent, so this module must stay
# commented out on macOS hosts.
{
  pkgs,
  ...
}:
{
  programs.nix-ld.enable = true;

  # List options merge, so this is *appended* to the module's defaults (zlib,
  # zstd, stdenv.cc.cc, curl, openssl, attr, libssh, bzip2, libxml2, acl,
  # libsodium, util-linux, xz, systemd) rather than replacing them.
  programs.nix-ld.libraries = with pkgs;
  [
    libGL # GL loading, e.g. the emulator's GPU backends.
    #libcxx #libcxxabi # uncomment if something asks for `libc++_shared.so`.
  ];
}
