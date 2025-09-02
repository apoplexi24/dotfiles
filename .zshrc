# >>> Zsh Config for VS Code-like Terminal <<<

# Path for Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Enable colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Oh My Zsh base
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"   # Try powerlevel10k later if you want a fancier prompt
plugins=(git)              # Only use oh-my-zsh plugins here

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ----- Plugins installed via Homebrew -----

# zsh-autosuggestions (grey inline suggestions)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting (colors for commands)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add extra completions
fpath+=/opt/homebrew/share/zsh-completions

# Initialize completion system
autoload -Uz compinit
compinit

# ----- Aliases -----
alias cat="bat"       # prettier cat
alias ll="ls -lah"    # better ls

# >>> End Config <<<

export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"

wow() {
  query="$*"
  url=$(yt-dlp "ytsearch1:${query}" --get-id --skip-download 2>/dev/null | head -n1)
  if [ -n "$url" ]; then
    mpv --vo=tct "https://www.youtube.com/watch?v=${url}"
  else
    echo "No results found for: $query"
  fi
}



# Load Angular CLI autocompletion.
source <(ng completion script)
