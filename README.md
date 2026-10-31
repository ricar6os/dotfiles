# dotfiles

Mi configuración de terminal: [Ghostty](https://ghostty.org) + zsh con [Oh My Zsh](https://ohmyz.sh) y el prompt [Pure](https://github.com/sindresorhus/pure).

```
ghostty/config   → ~/.config/ghostty/config
zsh/zshrc        → ~/.zshrc
zsh/prompt.zsh     (Pure, cargado desde zshrc)
install.sh         instala dependencias y crea los symlinks
```

## Instalación

```sh
git clone git@github.com:ricar6os/dotfiles.git ~/workspace/dotfiles
~/workspace/dotfiles/install.sh
```

`install.sh` funciona en macOS (Homebrew) y Ubuntu (apt) y se puede ejecutar varias veces:

- Instala `zsh`, `fzf` y Pure (en Linux, Pure se clona en `~/.zsh/pure`).
- Clona Oh My Zsh y los plugins en `~/.oh-my-zsh/custom/plugins`.
- Crea los symlinks. Si ya existía un archivo real, lo guarda como `*.backup.<fecha>`.
- Cambia el shell por defecto a zsh (cierra sesión y vuelve a entrar después).

Recarga Ghostty con `Cmd + Shift + ,` (macOS) o `Ctrl + Shift + ,` (Linux).

## zsh

Plugins:

| Plugin | Qué hace |
| --- | --- |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Colorea el comando mientras escribes: verde si existe, rojo si no |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Sugiere en gris según tu historial; acepta con `→` o `End` |
| [zsh-completions](https://github.com/zsh-users/zsh-completions) | Completados de `Tab` para más programas |
| [fzf](https://github.com/junegunn/fzf) | `Ctrl+R` busca en el historial, `Ctrl+T` busca archivos, `Alt+C` cambia de carpeta |
| git | Alias de git de Oh My Zsh (`gst`, `gco`, `gp`…) |

Configuración local que no quieras versionar (alias del trabajo, variables, etc.): `~/.zshrc.local`.
