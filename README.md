# ghostty-config

Mi configuración de [Ghostty](https://ghostty.org).

## Instalación

```sh
mkdir -p ~/.config/ghostty
curl -fsSL https://raw.githubusercontent.com/ricar6os/ghostty-config/main/config -o ~/.config/ghostty/config
```

O clona el repo y crea un symlink:

```sh
git clone git@github.com:ricar6os/ghostty-config.git ~/workspace/ghostty-config
mkdir -p ~/.config/ghostty
ln -sf ~/workspace/ghostty-config/config ~/.config/ghostty/config
```

Recarga con `Cmd + Shift + ,` (macOS) o `Ctrl + Shift + ,` (Linux).

## Prompt (Pure)

El prompt es [Pure](https://github.com/sindresorhus/pure), configurado en zsh (no en Ghostty).

### macOS

```sh
brew install pure
echo 'source ~/workspace/ghostty-config/zsh/prompt.zsh' >> ~/.zshrc
```

### Linux (Ubuntu)

No hay Homebrew, así que Pure se clona desde GitHub y se añade a `fpath`:

```sh
sudo apt install -y zsh
chsh -s "$(which zsh)"
git clone --depth=1 https://github.com/sindresorhus/pure.git ~/.zsh/pure
cat >> ~/.zshrc <<'EOF'
fpath+=("$HOME/.zsh/pure")
source "$HOME/workspace/ghostty-config/zsh/prompt.zsh"
EOF
```

### Oh My Zsh

Si usas Oh My Zsh, deja `ZSH_THEME=""` y asegúrate de que las líneas anteriores van después de `source $ZSH/oh-my-zsh.sh`.
