#!/bin/bash

# Check if dependencies are available
if ! which wl-copy &>/dev/null || ! which wl-paste &>/dev/null || ! which ydotool &>/dev/null; then
    echo "Missing dependencies!"
    echo "Please run: ./setup.sh"
    exit 1
fi

# Note: Modern versions of ydotool don't require a separate daemon

# Store initial clipboard content
OLD_CLIP=$(wl-paste -n 2>/dev/null || echo "empty")
echo "Initial clipboard: '$OLD_CLIP'"

# Launch KDE's emoji picker
plasma-emojier &
PICKER_PID=$!
echo "Launched emoji picker with PID $PICKER_PID"

# Wait for clipboard to change (meaning an emoji was selected)
echo -n "Waiting for emoji selection"
CHECKS=0

while true; do
    sleep 0.1  # Check more frequently (was 0.5)
    
    # Check clipboard content
    NEW_CLIP=$(wl-paste -n 2>/dev/null || echo "empty")
    
    # Show progress every 10 checks (1 second)
    if [ $((CHECKS % 10)) -eq 0 ]; then
        echo -n "."
    fi
    CHECKS=$((CHECKS + 1))
    
    # If clipboard changed
    if [[ "$OLD_CLIP" != "$NEW_CLIP" ]]; then
        echo ""
        echo "Clipboard changed to: '$NEW_CLIP'"
        
        # Wait just a tiny moment before typing (was 0.5)
        sleep 0.1
        
        # Type the emoji using ydotool
        echo "Typing emoji..."
        ydotool type "$NEW_CLIP"
        
        # Cleanup
        kill $PICKER_PID 2>/dev/null
        echo "Process completed successfully"
        exit 0
    fi
    
    # Timeout after 30 seconds
    if [ $CHECKS -gt 300 ]; then  # 300 * 0.1 = 30 seconds
        echo ""
        echo "Timeout waiting for emoji selection"
        kill $PICKER_PID 2>/dev/null
        exit 1
    fi
done