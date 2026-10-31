# ghostty-config

Mi configuración de [Ghostty](https://ghostty.org).

## Instalación

```sh
mkdir -p ~/.config/ghostty
curl -fsSL https://raw.githubusercontent.com/ricar6os/ghostty-config/main/config -o ~/.config/ghostty/config
```

O clona el repo y crea un symlink:

```sh
git clone git@github.com:ricar6os/ghostty-config.git ~/ghostty-config
ln -sf ~/ghostty-config/config ~/.config/ghostty/config
```

Recarga con `Cmd + Shift + ,`.

## Prompt (Pure)

El prompt es [Pure](https://github.com/sindresorhus/pure), configurado en zsh (no en Ghostty).

```sh
brew install pure
git clone git@github.com:ricar6os/ghostty-config.git ~/ghostty-config
echo 'source ~/ghostty-config/zsh/prompt.zsh' >> ~/.zshrc
```

Si usas Oh My Zsh, deja `ZSH_THEME=""` y asegúrate de que la línea `source` va después de `source $ZSH/oh-my-zsh.sh`.
