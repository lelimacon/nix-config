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

  # Store paths are content-addressed and change on every `nix flake update`,
  # so hardcoding one into an IDE's settings breaks on the next rebuild.
  # Expose stable paths instead:
  #
  #   Flutter SDK: /etc/flutter-sdk
  #   Dart SDK:    /etc/dart-sdk
  #
  # In JetBrains IDEs set the Flutter SDK under *Languages & Frameworks →
  # Flutter* and tick "Use Dart SDK from Flutter SDK" there; only set the Dart
  # SDK manually for pure-Dart projects.
  environment.etc =
  {
    "flutter-sdk".source = pkgs.flutter;
    "dart-sdk".source = "${pkgs.flutter}/bin/cache/dart-sdk";
  };
}
