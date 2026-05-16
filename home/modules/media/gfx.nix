{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = with pkgs;
  [
    # Photo editing.
    gimp

    # Vector graphics.
    inkscape
    fontforge-gtk # font editor.

    # 3D.
    blender

    # Video.
    jellyfin-ffmpeg # Jellyfin fork of FFmpeg.
    handbrake # video converter with GUI (`ghb`).
  ];
}
