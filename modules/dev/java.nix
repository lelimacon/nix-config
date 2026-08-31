# Java dev environment.
{
  pkgs,
  pkgs-wrappers,
  ...
}:
let
  jdk21 = pkgs.javaPackages.compiler.openjdk21;
  #jdk25 = pkgs.javaPackages.compiler.openjdk25;
  #jdk25 = pkgs.javaPackages.compiler.temurin-bin.jdk-25;
in
{
  environment.systemPackages = with pkgs;
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
    pkgs-wrappers.jetbrains-idea
  ];

  # No `programs.java` on nix-darwin, so set it directly (works on both).
  environment.variables.JAVA_HOME = "${jdk21}";
}
