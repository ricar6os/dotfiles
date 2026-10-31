#!/usr/bin/env bash
# Instala dependencias y enlaza los dotfiles. Se puede ejecutar varias veces.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

clone() { # clone <repo> <destino>
  [[ -d "$2" ]] || git clone --depth=1 "https://github.com/$1.git" "$2"
}

link() { # link <origen> <destino>; guarda copia si el destino es un archivo real
  mkdir -p "$(dirname "$2")"
  if [[ -e "$2" && ! -L "$2" ]]; then
    mv "$2" "$2.backup.$(date +%Y%m%d%H%M%S)"
    echo "Copia de seguridad: $2.backup.*"
  fi
  ln -sfn "$1" "$2"
  echo "$2 -> $1"
}

# Paquetes del sistema
if [[ "$(uname)" == Darwin ]]; then
  brew install zsh fzf pure
  brew install --cask font-fira-code
elif command -v apt-get >/dev/null; then
  missing=()
  for p in zsh fzf; do command -v "$p" >/dev/null || missing+=("$p"); done
  fc-list | grep -qi 'Fira Code' || missing+=(fonts-firacode)
  (( ${#missing[@]} == 0 )) || sudo apt-get install -y "${missing[@]}"
  clone sindresorhus/pure "$HOME/.zsh/pure"
fi

# Oh My Zsh y plugins
clone ohmyzsh/ohmyzsh "$HOME/.oh-my-zsh"
plugins="$HOME/.oh-my-zsh/custom/plugins"
clone zsh-users/zsh-syntax-highlighting "$plugins/zsh-syntax-highlighting"
clone zsh-users/zsh-autosuggestions "$plugins/zsh-autosuggestions"
clone zsh-users/zsh-completions "$plugins/zsh-completions"

# Symlinks
link "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"

# Shell por defecto
zsh_path="$(command -v zsh)"
if [[ "$(basename "${SHELL:-}")" != zsh ]]; then
  chsh -s "$zsh_path" && echo "Shell cambiado a zsh: cierra sesión y vuelve a entrar."
fi

echo "Listo."
