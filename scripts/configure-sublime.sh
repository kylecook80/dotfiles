#!/bin/sh

SUBLIME_DIR="$HOME/Library/Application Support/Sublime Text 3"

cp "settings/Package\ Control.sublime-package" "$SUBLIME_DIR/Installed Packages/"
cp "../settings/Preferences.sublime-settings" "$SUBLIME_DIR/Packages/User/"
cp "../themes/syntax/textmate/base16-tomorrow.dark.tmTheme" "$SUBLIME_DIR/Packages/User/"
cp "../themes/Theme - SoDaReloaded" "$SUBLIME_DIR/Packages/"
