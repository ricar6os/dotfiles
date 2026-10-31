# Pure prompt (https://github.com/sindresorhus/pure), installed with Homebrew.
# Usage: brew install pure, then add to ~/.zshrc:
#   source ~/workspace/ghostty-config/zsh/prompt.zsh
# If you use Oh My Zsh, set ZSH_THEME="" and source this after oh-my-zsh.sh.

fpath+=(/opt/homebrew/share/zsh/site-functions)
autoload -U promptinit
promptinit
prompt pure
