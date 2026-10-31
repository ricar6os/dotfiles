# Pure prompt (https://github.com/sindresorhus/pure)
# - macOS: brew install pure
# - Linux: git clone --depth=1 https://github.com/sindresorhus/pure.git ~/.zsh/pure
# Si usas Oh My Zsh, deja ZSH_THEME="" y carga este archivo después de oh-my-zsh.sh.

fpath+=("$HOME/.zsh/pure")
[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath+=(/opt/homebrew/share/zsh/site-functions)
autoload -U promptinit
promptinit
prompt pure
