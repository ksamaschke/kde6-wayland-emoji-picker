#!/bin/bash

# Setup script for KDE Wayland Emoji Picker
# Installs dependencies and configures permissions
# Run once: ./setup.sh

set -e

echo "Setting up KDE Wayland Emoji Picker..."

# Install required packages
echo "Installing required packages..."
sudo apt update
sudo apt install -y wl-clipboard ydotool

# Set up ydotool permissions to run without sudo
echo "Configuring ydotool permissions..."

# Create ydotool group if it doesn't exist
if ! getent group ydotool > /dev/null 2>&1; then
    sudo groupadd ydotool
    echo "Created ydotool group"
fi

# Add current user to ydotool group
sudo usermod -aG ydotool "$USER"
echo "Added $USER to ydotool group"

# Set up udev rule for ydotool
sudo tee /etc/udev/rules.d/80-ydotool.rules > /dev/null << 'EOF'
# Allow ydotool group to access input devices
KERNEL=="uinput", GROUP="ydotool", MODE="0660"
SUBSYSTEM=="input", MODE="0660", GROUP="ydotool"
EOF

echo "Created udev rules for ydotool"

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger

echo ""
echo "Setup complete!"
echo ""
echo "IMPORTANT: You must log out and log back in for group changes to take effect."
echo ""
echo "After logging back in:"
echo "1. Run: ./emoji-picker.sh"
echo "2. Set up a keyboard shortcut (see README.md)"