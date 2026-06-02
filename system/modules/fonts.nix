{
  lib,
  pkgs,
  ...
}:
{
  config.fonts.packages = with pkgs;
  [
    # Fira
    #fira-code
    nerd-fonts.fira-code

    # Icons.
    font-awesome

    # Inria.
    inriafonts
    liberation_ttf

    # Libertinus.
    libertinus

    # Monaspace.
    # Original included for frozen variants.
    # See https://github.com/githubnext/monaspace/issues/13#issuecomment-2113347570
    monaspace
    nerd-fonts.monaspace

    # Noto.
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts-emoji-blob-bin
    noto-fonts-lgc-plus
    noto-fonts-monochrome-emoji

    # Ubuntu.
    ubuntu-sans
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
  ];
}
