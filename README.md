# KDE 6 Emoji Picker

I use Emojis very often, but unfortunately, there's no good Emoji-Picker for KDE 6 - at least not that I would be aware of. 

KDE's emoji picker (`plasma-emojier`) doesn't close automatically after selection, requiring extra clicks and window management.

This script fixes that by auto-closing the picker and attempting to paste the emoji directly at your cursor.

## Features

- Launches KDE Plasma's native emoji picker
- Automatically closes the picker after emoji selection
- Returns focus to your original application
- Sends Ctrl+V to paste the selected emoji
- Works reliably with keyboard shortcuts on Wayland

## Requirements

- KDE Plasma desktop environment
- Wayland or X11 session
- Linux system with apt package manager

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/ksamaschke/kde6-wayland-emoji-picker.git
   cd kde6-wayland-emoji-picker
   ```

2. Run the setup script (requires sudo):
   ```bash
   ./setup.sh
   ```

3. Log out and log back in (required for group permissions)

## Usage

Run the script directly:
```bash
./emoji-picker.sh
```

Or better yet, set up a keyboard shortcut (see below).

### Setting Up a Keyboard Shortcut

Set up a custom keyboard shortcut:

1. Open **System Settings** > **Shortcuts** > **Custom Shortcuts**
2. Right-click and select **Add New** > **Command or Script**
3. Configure the shortcut:
   - **Name**: Emoji Picker
   - **Command**: `/path/to/emoji-picker.sh`
   - **Trigger**: Your desired key combination (e.g., `Meta+E`)
4. Click **Apply**

## How it Works

1. Stores the current clipboard content
2. Launches KDE's emoji picker (plasma-emojier)
3. Monitors clipboard for changes
4. When an emoji is selected:
   - Closes the picker automatically
   - Waits briefly for focus to return
   - Sends Ctrl+V to paste the emoji

## Limitations

- **Focus changes**: If you switch windows after invoking the script, the paste will occur in the newly focused window
- **Clipboard interference**: If another application modifies the clipboard while the emoji picker is open, the script may detect the wrong change
- **Auto-paste restrictions**: On KDE Plasma 6 with Wayland, the auto-paste (Ctrl+V) may not work in some applications due to security policies. In such cases, paste manually with Ctrl+V
- **Timing sensitivity**: The script relies on clipboard monitoring, which can occasionally miss rapid changes


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
