#!/bin/bash

# Emoji Picker for KDE Plasma
# Enhances plasma-emojier by auto-closing and auto-pasting
# Works with keyboard shortcuts on KDE Wayland

# Check dependencies
if ! command -v wl-paste &>/dev/null || ! command -v ydotool &>/dev/null; then
    echo "Error: Missing dependencies!"
    echo "Please run: ./setup.sh"
    exit 1
fi

# Store initial clipboard content
OLD_CLIP=$(wl-paste -n 2>/dev/null || echo "empty")

# Wait for keyboard shortcut to be released
sleep 0.5

# Launch KDE's emoji picker
plasma-emojier &
PICKER_PID=$!

# Monitor clipboard for emoji selection
CHECKS=0
while true; do
    sleep 0.1
    
    # Check clipboard content
    NEW_CLIP=$(wl-paste -n 2>/dev/null || echo "empty")
    
    # Show progress dot every second
    if [ $((CHECKS % 10)) -eq 0 ]; then
        echo -n "."
    fi
    CHECKS=$((CHECKS + 1))
    
    # If clipboard changed (emoji selected)
    if [[ "$OLD_CLIP" != "$NEW_CLIP" ]]; then
        echo " Done!"
        
        # Close the picker
        kill $PICKER_PID 2>/dev/null
        
        # Wait for focus to return
        sleep 0.8
        
        # Send Ctrl+V to paste the emoji
        ydotool key ctrl+v
        exit 0
    fi
    
    # Check if picker was closed without selection
    if [ $((CHECKS % 50)) -eq 0 ] && [ $CHECKS -gt 0 ]; then
        if ! ps -p $PICKER_PID > /dev/null; then
            echo " Picker closed"
            exit 0
        fi
    fi
    
    # Timeout after 30 seconds
    if [ $CHECKS -gt 300 ]; then
        echo " Timeout"
        kill $PICKER_PID 2>/dev/null
        exit 1
    fi
done