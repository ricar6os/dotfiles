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

copy() { # copy <origen> <destino>; muestra el diff y guarda copia si el destino difiere
  mkdir -p "$(dirname "$2")"
  if [[ -L "$2" ]]; then
    rm "$2"
  elif [[ -e "$2" ]]; then
    cmp -s "$1" "$2" && { echo "$2 ya está al día"; return; }
    echo "Cambios en $2 respecto al repo:"
    diff -u "$2" "$1" || true
    mv "$2" "$2.backup.$(date +%Y%m%d%H%M%S)"
    echo "Copia de seguridad: $2.backup.*"
  fi
  cp "$1" "$2"
  echo "$2 <- $1"
}

# Paquetes del sistema
if [[ "$(uname)" == Darwin ]]; then
  brew install zsh fzf pure zoxide
  brew install --cask font-fira-code
elif command -v apt-get >/dev/null; then
  missing=()
  for p in zsh fzf zoxide curl unzip; do command -v "$p" >/dev/null || missing+=("$p"); done
  fc-list | grep -qi 'Fira Code' || missing+=(fonts-firacode)
  (( ${#missing[@]} == 0 )) || sudo apt-get install -y "${missing[@]}"
  clone sindresorhus/pure "$HOME/.zsh/pure"
fi

# fnm con el instalador oficial en ~/.local/share/fnm (igual en macOS y Linux);
# --skip-shell porque zsh/zshrc ya lo carga
if [[ ! -x "$HOME/.local/share/fnm/fnm" ]]; then
  curl -fsSL https://fnm.vercel.app/install |
    bash -s -- --install-dir "$HOME/.local/share/fnm" --skip-shell --force-no-brew
fi

# Oh My Zsh y plugins
clone ohmyzsh/ohmyzsh "$HOME/.oh-my-zsh"
plugins="$HOME/.oh-my-zsh/custom/plugins"
clone zsh-users/zsh-syntax-highlighting "$plugins/zsh-syntax-highlighting"
clone zsh-users/zsh-autosuggestions "$plugins/zsh-autosuggestions"
clone zsh-users/zsh-completions "$plugins/zsh-completions"
clone Aloxaf/fzf-tab "$plugins/fzf-tab"

# Ghostty se copia (no symlink) para que editarlo no cambie el repo sin darte
# cuenta; vuelve a ejecutar install.sh para aplicar cambios del repo
copy "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

# Symlinks
link "$DOTFILES/git/config" "$HOME/.config/git/config"

# ~/.zshrc no es un symlink sino un archivo local que carga el del repo: los
# instaladores (pnpm, fnm…) pueden añadirle líneas sin romper nada ni tocar el repo
zshrc_source="source \"${DOTFILES/#$HOME/\$HOME}/zsh/zshrc\""
if ! grep -qxF "$zshrc_source" "$HOME/.zshrc" 2>/dev/null; then
  if [[ -L "$HOME/.zshrc" ]]; then
    rm "$HOME/.zshrc"
  elif [[ -e "$HOME/.zshrc" ]]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
    echo "Copia de seguridad: ~/.zshrc.backup.* (pasa lo que quieras conservar al nuevo ~/.zshrc)"
  fi
  printf '%s\n' \
    "# Config versionada: https://github.com/ricar6os/dotfiles" \
    "$zshrc_source" \
    "" \
    "# Lo de abajo es local de esta máquina (no se versiona)" > "$HOME/.zshrc"
  echo "~/.zshrc creado (carga $DOTFILES/zsh/zshrc)"
fi

# Shell por defecto
zsh_path="$(command -v zsh)"
if [[ "$(basename "${SHELL:-}")" != zsh ]]; then
  chsh -s "$zsh_path" && echo "Shell cambiado a zsh: cierra sesión y vuelve a entrar."
fi

echo "Listo."
