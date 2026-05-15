project(
  'drawernator',
  ['vala', 'c', 'objc'],
  version: '0.1',
  meson_version: '>= 0.60.0'
)

# Dependencies
gtk_dep = dependency('gtk4')
cocoa_dep = dependency('appleframeworks', modules: ['Cocoa', 'AppKit'])

sources = files(
  'src/main.vala',
  'src/macos_hide.m'
)

# Executable
executable(
  'drawernator',
  sources,
  dependencies: [
    gtk_dep,
    cocoa_dep,
  ],
  install: true
)
