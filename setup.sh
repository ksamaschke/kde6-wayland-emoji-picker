#!/bin/bash

# Setup script for emoji-picker dependencies
# Run this once: ./setup.sh (will ask for sudo when needed)

set -e

echo "Setting up emoji-picker dependencies..."

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
echo "Setup complete! Please note:"
echo "1. You need to log out and log back in for group changes to take effect"
echo "2. After logging back in, you can run: ./emoji-picker.sh"
echo "3. The emoji-picker.sh script can now run without sudo"