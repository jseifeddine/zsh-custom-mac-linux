# Zsh Custom Configuration

Custom Zsh configuration with Oh My Zsh, plugins, and Dracula theme for macOS and Linux.

## Prerequisites

### macOS
```bash
brew install zsh git fzf bat
```

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install zsh git fzf bat
```

## Installation

1. Install Oh My Zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Clone this repository:
```bash
git clone https://github.com/jseifeddine/zsh-custom-mac-linux.git ~/.zsh-custom
```

3. Install required plugins:
```bash
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH_CUSTOM/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat
```

4. Install Dracula theme:
```bash
mkdir -p ~/.local
git clone https://github.com/dracula/zsh.git ~/.local/dracula-zsh-theme
ln -s ~/.local/dracula-zsh-theme/dracula.zsh-theme $ZSH_CUSTOM/themes/dracula.zsh-theme
```

5. Backup existing .zshrc and use the new one:
```bash
cp ~/.zshrc ~/.zshrc.backup
rm ~/.zshrc
ln -s ~/.zsh-custom/.zshrc ~/.zshrc
```

6. Install custom bat config to make it more like cat - with Dracula theme
```bash
mkdir -p ~/.config/bat
cp ~/.zsh-custom/.config/bat/config ~/.config/bat
```

7. Reload shell:
```bash
source ~/.zshrc
```

## Custom Functions

- `myip` - Show external IP address and brief network info
- `time-zsh` - Measure shell startup time
- `omz-update-custom` - Update all custom omz plugins and dracula zsh theme

## Local Customization

Add machine-specific settings to:
- `~/.local/.zshrc` - Local configurations
- `~/.local/.zshrc_plugins` - Additional local plugins
- `~/.local/.zshrc_completions` - Additional local completions
