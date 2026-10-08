uuid := "system-monitor-next@paradoxxx.zero.gmail.com"

# List recipes
default:
    @just --list

# Build the extension into _build/
build:
    make build

# Install the extension for the current user
install:
    make install

# Uninstall the extension
uninstall:
    make uninstall

# Build dist/<uuid>.zip (for extensions.gnome.org)
zip version="0":
    make zip-file VERSION={{version}}

# Install the built zip with gnome-extensions
install-zip: zip
    gnome-extensions install --force dist/{{uuid}}.zip

# Remove generated files
clean:
    make clean

# Enable the extension
enable:
    gnome-extensions enable {{uuid}}

# Disable the extension
disable:
    gnome-extensions disable {{uuid}}

# Show extension state (ACTIVE / ERROR / OUT OF DATE)
status:
    gnome-extensions info {{uuid}}

# Open the extension preferences
prefs:
    gnome-extensions prefs {{uuid}}

# Follow GNOME Shell logs for this boot
logs:
    journalctl --user -b -f -o cat /usr/bin/gnome-shell

# Install, then run a nested GNOME Shell window to test without logging out
nested: install
    dbus-run-session gnome-shell --devkit --wayland
