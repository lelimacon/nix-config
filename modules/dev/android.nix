# Android SDK for Flutter (and other mobile) builds.
# `pkgs.flutter` ships the engine artifacts for Android, but neither the SDK
# nor a JDK, both of which Gradle needs.
{
  config,
  pkgs,
  ...
}:
let
  # `pkgs.androidsdk` lives in the read-only Nix store, so it can't hold
  # accepted licenses, system images, build tools you add later, or AVDs and
  # emulator state. Point everything at a writable SDK under `$HOME` instead
  # and use the store copy only as a bootstrap:
  #
  #   sdkmanager --licenses
  #   sdkmanager "cmdline-tools;latest" "platform-tools" \
  #              "platforms;android-36" "build-tools;36.0.0"
  #
  # Once `cmdline-tools;latest` is installed, `$ANDROID_HOME/cmdline-tools/latest/bin`
  # shadows the store's tools (see the PATH prepend in `pkgs/nushell`).
  androidHome = "${config.user.homeDirectory}/.android/sdk";

  # The store's `sdkmanager` wrapper hardcodes `--sdk_root` to its own (read-only)
  # path. Re-passing it last overrides that, so this one installs into `$HOME`.
  sdkmanager = pkgs.writeShellScriptBin "sdkmanager"
  ''
    exec ${pkgs.androidsdk}/bin/sdkmanager --sdk_root="${androidHome}" "$@"
  '';
in
{
  environment.systemPackages =
  [
    # Listed before `androidsdk`: on a name collision the first package wins.
    sdkmanager
  ]
  ++ (with pkgs; [
    androidsdk # emulator, avdmanager, adb, ... (read-only copy).
    javaPackages.compiler.openjdk21 # used by Gradle.
  ]);

  # `sessionVariables` rather than `variables`: PAM sets these early in the
  # login process, so GUI apps started from the desktop session — the IDEs —
  # see them too. On macOS the equivalent is `environment.variables`.
  environment.sessionVariables =
  {
    ANDROID_HOME = androidHome;
    ANDROID_SDK_ROOT = androidHome;
  };
}
