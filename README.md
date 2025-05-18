# KDE Wayland Emoji Picker

Enhances KDE's emoji picker by automatically closing it after selection and pasting the emoji at your cursor.

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

## Why This Script?

KDE's emoji picker (`plasma-emojier`) doesn't close automatically after selection, requiring extra clicks. This script streamlines the workflow by:
- Auto-closing the picker
- Attempting to paste automatically
- Providing a smoother emoji selection experience

## License

MIT License

Copyright (c) 2025 Karsten Samaschke

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.