# dotfiles

Mi configuración de terminal: [Ghostty](https://ghostty.org) + zsh con [Oh My Zsh](https://ohmyz.sh) y el prompt [Pure](https://github.com/sindresorhus/pure).

```
ghostty/config   → ~/.config/ghostty/config (copia)
git/config       → ~/.config/git/config
zsh/zshrc          cargado desde ~/.zshrc (ver abajo)
zsh/prompt.zsh     (Pure, cargado desde zshrc)
install.sh         instala dependencias, crea los symlinks y ~/.zshrc
```

## Instalación

```sh
git clone git@github.com:ricar6os/dotfiles.git ~/workspace/dotfiles
~/workspace/dotfiles/install.sh
```

`install.sh` funciona en macOS (Homebrew) y Ubuntu (apt) y se puede ejecutar varias veces:

- Instala `zsh`, `fzf`, `zoxide`, Pure y [fnm](https://github.com/Schniz/fnm) (con su instalador oficial en `~/.local/share/fnm`) (en Linux, Pure se clona en `~/.zsh/pure`).
- Clona Oh My Zsh y los plugins en `~/.oh-my-zsh/custom/plugins`.
- Copia la config de Ghostty. Si la tuya era distinta, muestra el diff y la guarda como `*.backup.<fecha>`. No es un symlink para que editar Ghostty no cambie el repo sin darte cuenta: si cambias algo que quieras conservar, pásalo al repo y vuelve a ejecutar `install.sh`.
- Enlaza la config de git. Si ya existía un archivo real, lo guarda como `*.backup.<fecha>`.
- Crea `~/.zshrc` con una línea que carga `zsh/zshrc` del repo (si ya existía, lo guarda como `~/.zshrc.backup.<fecha>`).
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
| [fzf-tab](https://github.com/Aloxaf/fzf-tab) | `Tab` abre un buscador fuzzy en vez del menú normal (con vista previa al hacer `cd`); `<` y `>` cambian de grupo |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `z proy` salta a la carpeta más usada que coincida; `zi` la elige con fzf |
| git | Alias de git de Oh My Zsh (`gst`, `gco`, `gp`…) |

## Qué va en el repo y qué no

`~/.zshrc` y `~/.gitconfig` son **locales** de cada máquina; el repo solo aporta la parte común:

- `~/.zshrc` carga `zsh/zshrc` en su primera línea. Debajo van los PATH que añaden los instaladores (pnpm, opencode…), alias del trabajo y variables de esa máquina. Así un instalador nunca rompe un symlink ni mete rutas como `/home/<usuario>` en el repo.
- `~/.gitconfig` se lee después de `git/config`, así que puede sobrescribirlo: ahí van los `includeIf` del trabajo y lo que añadan `gh` u otras herramientas.

En lo versionado, usa `$HOME` en vez de rutas absolutas y comprueba que una herramienta existe antes de cargarla (como hace el bloque de fnm). **Nunca** subas tokens ni API keys: el repo es público.

VS Code no está aquí porque usa Settings Sync.
