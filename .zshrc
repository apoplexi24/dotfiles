# >>> Zsh Config for VS Code-like Terminal <<<

# Path for Homebrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

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
source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting (colors for commands)
source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add extra completions
fpath+=/home/linuxbrew/.linuxbrew/share/zsh-completions

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

  TMP_THUMBS="${TMP_THUMBS:-$(mktemp -d)}"

  # Use ":::" as field separator to avoid conflicts
  results=$(yt-dlp "ytsearch5:${query}" --skip-download \
    --print "%(title)s:::%(id)s:::%(thumbnails.-1.url)s" 2>/dev/null)

  [ -z "$results" ] && { echo "No results found"; return 1; }

  choice=$(echo "$results" | fzf --ansi --delimiter=":::" --with-nth=1 \
    --prompt="Select video: " \
    --preview '
      id=$(echo {} | awk -F ":::" "{print \$2}")
      url=$(echo {} | awk -F ":::" "{print \$3}")
      fname="'"$TMP_THUMBS"'/$id.jpg"

      if [ -n "$url" ]; then
        [ ! -f "$fname" ] && curl -s "$url" -o "$fname"
        chafa --symbols ascii --size 60x20 "$fname" 2>/dev/null || echo "(thumbnail display failed)"
      else
        echo "(no thumbnail)"
      fi
    ')

  [ -z "$choice" ] && { echo "No selection"; return 1; }

  title=$(echo "$choice" | awk -F ':::' '{print $1}')
  id=$(echo "$choice" | awk -F ':::' '{print $2}')

  echo "▶ Playing: $title (quality: $quality)"
  mpv --vo=tct --ytdl-format="$quality" "https://www.youtube.com/watch?v=$id" 2>/dev/null
}


export CGO_ENABLED=1
