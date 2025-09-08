# My Personal Zsh Configuration

This repository stores my personal `.zshrc` configuration. The goal is to have a consistent and enhanced Zsh terminal experience across any system I'm working on.

## Features

This configuration is built on top of [Oh My Zsh](https://ohmyz.sh/) and includes several enhancements for a more productive command-line experience.

- **Base:** Oh My Zsh with the `robbyrussell` theme.
- **Syntax Highlighting:** Colors for commands via [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).
- **Auto-suggestions:** Inline suggestions for commands as you type, powered by [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions).
- **Enhanced Commands:**
    - `cat` is aliased to `bat` for syntax highlighting and a better viewing experience.
    - `ll` is aliased to `ls -lah` for a detailed, human-readable file listing.
- **Completions:** Additional autocompletions for various tools, including Angular CLI.
- **Custom `wow` Function:** A terminal-based YouTube player.

## Prerequisites

To use this configuration, you'll need to have [Homebrew](https://brew.sh/) installed, along with the following packages:

```bash
brew install bat fzf yt-dlp mpv chafa zsh-autosuggestions zsh-syntax-highlighting zsh-completions
```

## Installation

1.  Clone this repository to your local machine.
2.  Install the prerequisites listed above.
3.  Symlink the `.zshrc` file from this repository to your home directory:
    ```bash
    ln -s /path/to/your/clone/.zshrc ~/.zshrc
    ```
4.  Restart your terminal to apply the changes.

## Custom `wow` Function

This script provides a way to search for and play YouTube videos directly in your terminal.

### Usage

```bash
wow [-q quality] <search terms>
```

-   `<search terms>`: The video you want to search for on YouTube.
-   `-q`: (Optional) Set the video quality (e.g., `best`, `720p`, `480p`). Defaults to `best`.

### Example

```bash
wow lofi hip hop radio
```

This command will open an interactive `fzf` menu showing the top 5 search results. You can select a video to play it using `mpv` directly in the terminal.
