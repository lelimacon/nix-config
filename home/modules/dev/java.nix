# Java dev environment.
{
  pkgs,
  pkgs-unstable,
  ...
}:
let
  jdk21 = pkgs.javaPackages.compiler.openjdk21;
  #jdk25 = pkgs.javaPackages.compiler.openjdk25;
  #jdk25 = pkgs.javaPackages.compiler.temurin-bin.jdk-25;
in
{
  home.packages = with pkgs;
  [
    #zulu8 # Java OpenJDK.
    jdk21
    #jdk25
    kotlin # JVM language.
    #quarkus # Java framework.

    # Build systems.
    maven
    gradle_9

    # IDE.
    pkgs-unstable.jetbrains.idea
  ];

  programs.java =
  {
    enable = true;
    package = jdk21;
  };
}
