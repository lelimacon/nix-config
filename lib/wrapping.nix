# Nix derivation helpers for wrapped packages.
{
  pkgs,
}:
rec {
  # Overlays the .app bundle so the Finder/Dock launcher calls the wrapper
  # script instead of the original Mach-O binary.
  # The executable name (CFBundleExecutable) is read from the original bundle.
  wrapMacOsApp = appName: binName: wrapped:
    pkgs.runCommand binName { } ''
      # Read the real main executable name from Info.plist rather than
      # listing Contents/MacOS/, which can contain many other files
      # (helper apps, dylibs, ...) besides the actual CFBundleExecutable.
      execName=$(/usr/bin/plutil -extract CFBundleExecutable raw -o - "${wrapped}/Applications/${appName}.app/Contents/Info.plist")

      mkdir -p $out/bin "$out/Applications/${appName}.app/Contents/MacOS"

      ln -s ${wrapped}/bin/${binName} $out/bin/${binName}

      for item in ${wrapped}/Applications/${appName}.app/Contents/*; do
        name=$(basename "$item")
        [ "$name" != "MacOS" ] && ln -s "$item" "$out/Applications/${appName}.app/Contents/$name"
      done

      cat > "$out/Applications/${appName}.app/Contents/MacOS/$execName" << 'EOF'
      #!/bin/sh
      exec "${wrapped}/bin/${binName}" "$@"
      EOF
      chmod +x "$out/Applications/${appName}.app/Contents/MacOS/$execName"
    '';

  # Calls wrapMacOsApp on Darwin, otherwise returns the wrapped package unchanged.
  wrapIfMacOsApp = appName: binName: wrapped:
    if pkgs.stdenv.isDarwin
    then wrapMacOsApp appName binName wrapped
    else wrapped;
}
