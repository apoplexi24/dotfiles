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

# wow - a vid player for terminal 

wow() {
  quality="best"
  while getopts "q:" opt; do
    case $opt in
      q) quality=$OPTARG ;;
    esac
  done
  shift $((OPTIND - 1))

  query="$*"
  [ -z "$query" ] && { echo "Usage: wow [-q quality] <search terms>"; return 1; }

  # Fetch top 5 results as "title|||id"
  choices=$(yt-dlp "ytsearch5:${query}" --get-title --get-id --skip-download 2>/dev/null \
    | awk 'NR%2{title=$0; next} {print title "|||" $0}')

  # Show full title in fzf (treat whole line as 1 field)
  choice=$(echo "$choices" | fzf --prompt="Select video: " --with-nth=1..)

  [ -z "$choice" ] && { echo "No selection"; return 1; }

  # Split back into title and id
  title="${choice%%|||*}"
  id="${choice##*|||}"

  echo "▶ Playing: $title (quality: $quality)"
  mpv --vo=tct --ytdl-format="$quality" "https://www.youtube.com/watch?v=$id"
}

# Load Angular CLI autocompletion.
source <(ng completion script)
