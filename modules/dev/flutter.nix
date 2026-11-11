# Flutter dev environment.
# `pkgs.flutter` already ships the Dart SDK, the engine artifacts (web, linux,
# android) and, on Linux, injects the desktop toolchain (clang, cmake, ninja,
# pkg-config, GTK) into its wrappers. What it does not provide is the Android
# SDK/JDK (see `android.nix`), a browser for web debugging (see
# `../social/chrome.nix`) and CocoaPods for iOS/macOS builds.
{
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    flutter
  ]
  ++ lib.optionals pkgs.stdenv.isDarwin
  [
    cocoapods # required for iOS/macOS builds.
  ];
}
