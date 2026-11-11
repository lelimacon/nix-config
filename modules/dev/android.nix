# Android SDK for Flutter (and other mobile) builds.
# `pkgs.flutter` ships the engine artifacts for Android, but neither the SDK
# nor a JDK, both of which Gradle needs.
{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs;
  [
    androidsdk
    javaPackages.compiler.openjdk21 # used by Gradle.
  ];

  environment.variables =
  {
    # Pointing at the store means the SDK is read-only: use
    # `sdkmanager --sdk_root` elsewhere to add more packages. Licenses are
    # pre-accepted in `lib/get-pkgs.nix`.
    ANDROID_HOME = "${pkgs.androidsdk}/libexec/android-sdk";
    ANDROID_SDK_ROOT = "${pkgs.androidsdk}/libexec/android-sdk";
  };
}
