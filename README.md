# KDE Plasma Emoji Picker

A simple utility that launches KDE's emoji picker and automatically types the selected emoji at your cursor position.

## Features

- Launches the native KDE Plasma emoji picker (plasma-emojier)
- Monitors clipboard for emoji selection
- Automatically types the selected emoji using ydotool
- Works with Wayland
- No need for manual copy-paste

## Requirements

- KDE Plasma desktop environment
- Wayland session
- Linux system with udev support

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

After setup, simply run:
```bash
./emoji-picker.sh
```

The KDE emoji picker will appear. Select an emoji and it will be automatically typed at your cursor position.

### Setting Up a Keyboard Shortcut (Recommended)

For quick access, it's recommended to set up a custom keyboard shortcut:

1. Open **System Settings** > **Shortcuts** > **Custom Shortcuts**
   - Alternative path: **System Settings** > **Input Actions**

2. Right-click in the left pane and select **New** > **Global Shortcut** > **Command/URL**

3. Configure the shortcut:
   - **Name**: Emoji Picker
   - **Command**: `/path/to/kde6-wayland-emoji-picker/emoji-picker.sh`
     (Replace with the actual path to your script)
   - **Trigger**: Click the button and press your desired key combination
     (e.g., `Meta+E` or `Ctrl+Alt+E`)

4. Click **Apply** to save the shortcut

Now you can launch the emoji picker instantly using your keyboard shortcut!

## How it Works

1. The script stores the current clipboard content
2. Launches KDE's plasma-emojier
3. Monitors the clipboard for changes every 0.1 seconds
4. When an emoji is selected (clipboard changes), it types the emoji using ydotool
5. Cleans up and exits

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