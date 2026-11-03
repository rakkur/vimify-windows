# vimify-windows

Bring Vim-style **command / insert modes**, motion keys, registers, and fast app switching to everyday Windows apps — powered by [AutoHotkey](https://www.autohotkey.com/) v1.

When the script is running, most of Windows behaves like a modal editor: navigate with `hjkl`, yank/paste with `yp`, jump between apps with `g`, and drop into insert mode only when you need to type.

---

## Features

| Feature | What it does |
| --- | --- |
| **Modal editing** | Command mode for navigation & actions; insert mode for typing |
| **Vim-ish motions** | `hjkl`, counts (`5j`), page up/down, undo |
| **Registers** | Named clipboard slots via `"` + letter + `y`/`p` |
| **App launcher / jumper** | `g` + letter focuses (or launches) a known app |
| **App stack** | `,` jumps back through recently used apps; `N,` jumps N entries back |
| **Per-app bindings** | Custom command maps for Chrome, Excel, Outlook, Cursor, Firefox, and more |
| **Mode indicators** | Tray icon + small corner overlays show command vs insert (and point-n-click state) |
| **Point-n-click** | `` ` `` toggles click-vs-move mouse helpers used by app macros |

---

## Requirements

- **Windows**
- **[AutoHotkey v1.1](https://www.autohotkey.com/)** (classic / v1 syntax — not v2)
- Optional integrations (paths are hardcoded in places):
  - [gVim](https://www.vim.org/) under `C:\Program Files\Vim\`
  - [xplorer2](https://www.zabkat.com/) under `C:\Program Files\zabkat\`
  - [nircmd](https://www.nirsoft.net/utils/nircmd.html) for some window activation helpers

> Paths and window-class heuristics are tuned for a personal workstation. Expect to edit a few strings if your install locations or app titles differ.

**Planned:** a port to AutoHotkey v2 sometime over the winter. Until then, this tree stays on v1.1.

---

## Quick start

1. Install AutoHotkey v1.1.
2. Clone or copy this repo somewhere convenient (or keep it under `C:\Program Files\vimify-windows`).
3. Double-click **`hotKeys.ahk`**, or run:

   ```bat
   "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\Program Files\vimify-windows\hotKeys.ahk"
   ```

4. Look for the tray / corner icon — you’re in **command mode**.

**Useful meta hotkeys** (always available):

| Shortcut | Action |
| --- | --- |
| `Ctrl+Alt+P` | Pause the script |
| `Ctrl+Alt+A` | Suspend hotkeys |
| `Ctrl+Alt+Z` | Copy pixel color under the cursor to the clipboard |
| `Ctrl+Alt+,` | Toggle comma-as-tab behavior |
| `Ctrl+Alt+Shift+L` | Switch keyboard layout helper (Dvorak / QWERTY) |

---

## Modes

The script tracks a global `vi` flag:

| Mode | Enter with | Behavior |
| --- | --- | --- |
| **Command** (`vi = 1`) | `Esc` / `CapsLock` | Keys are remapped to motions, edits, and app commands |
| **Insert** (`vi = 0`) | `i`, `a`, or `c` (delete + insert) | Most keys pass through as normal typing |

In command mode the icon uses the “normal” glyph; in insert mode it switches to the “edit” glyph. The same icons also encode **point-n-click** state (`ahk_0.bmp` / `ahk_1.bmp`, `ahk_edit_0.bmp` / `ahk_edit_1.bmp`).

**Special case:** when the active window is real Vim, a Vim console titled `VIM`, or **Cursor**, the script mostly stays out of the way and forwards keys (with a few Cursor-specific overrides).

---

## Global command-mode keys

These apply across apps (unless an app module overrides them):

| Key | Action |
| --- | --- |
| `h` `j` `k` `l` | Left / down / up / right |
| `N` + motion | Repeat (e.g. `3j`) |
| `y` / `p` / `x` | Copy / paste / cut (`Ctrl+C` / `Ctrl+V` / `Ctrl+X`) |
| `u` | Undo (`Ctrl+Z`) |
| `i` / `a` | Enter insert mode |
| `c` | Delete selection/char, then insert mode |
| `;` / `q` | Page down / page up |
| `Alt+;` / `Alt+q` | Shift+PageDown / Shift+PageUp |
| `Alt+hjkl` | Extend selection with arrows |
| `"` | Register mode → letter → `y` (yank into register) or `p` (paste from register) |
| `g` | App switch prefix (see below) |
| `,` | Focus previous app on the stack |
| `\` | Jump to Vim (`h`) |
| `` ` `` | Toggle point-n-click (`Ctrl+F1` / `Ctrl+F2`) |
| `Esc` / `CapsLock` | Return to command mode |

---

## App switching (`g` + letter)

Press `g`, then a letter (within ~3s). Optionally type a number first for multi-instance apps (Firefox / CMD / Visual Studio stacks).

| Letter | Target |
| --- | --- |
| `x` | xplorer2 / Explorer |
| `h` | gVim |
| `f` | Firefox Developer Edition (numbered instances) |
| `a` | Google Chrome |
| `p` | Cursor / VS Code / Acrobat (context-dependent) |
| `r` | Slack |
| `s` | Azure Data Studio |
| `t` | Microsoft Teams |
| `o` | Outlook |
| `e` | Excel |
| `w` | Word / LibreOffice Writer (`SALFRAME`) |
| `c` | Console / Windows Terminal (numbered instances) |
| `v` | Visual Studio (numbered / titled instances) |
| `n` | Notepad / NAV (C/SIDE) |
| `i` | Internet Explorer |
| `j` | Jabber |
| `l` | Logex / SnakeTail |
| `y` | Zoom / Join.me / RDP |

`,` returns to the previous entry on the **app stack**. `N,` (number then comma) jumps further back.

---

## Project layout

```
vimify-windows/
├── hotKeys.ahk                 # Entry point: routing, modes, app stack
├── ahk/
│   ├── engine/
│   │   └── init.ahk            # Key hooks + mode icon GUIs
│   ├── apps/                   # One module per application
│   │   ├── chrome.ahk
│   │   ├── cursor.ahk
│   │   ├── excel.ahk
│   │   ├── firefox.ahk
│   │   ├── outlook.ahk
│   │   ├── global.ahk          # Shared helpers (clipboard registers, pause, etc.)
│   │   └── …                   # acrobat, teams, zoom, sql, vs, word, …
│   ├── dynamic_includes.ahk    # Auto-generated #Include list
│   ├── generate_includes.ahk   # Regenerates dynamic_includes.ahk
│   ├── regenerate_includes.bat # Convenience wrapper
│   └── icons/                  # Mode / point-n-click tray & overlay bitmaps
└── README.md
```

### How routing works

1. Every remapped key calls `GetUserCmd(key, modifier)` in `hotKeys.ahk`.
2. The active window’s **class / title** is classified (`chrome`, `xls`, `cursor`, …).
3. Global Vim actions run first (mode switch, yank, app jump, registers).
4. Remaining keys are dispatched to `RunXxxCommand(...)` in the matching `ahk/apps/*.ahk` module.

### Adding a new app module

1. Create `ahk/apps/myapp.ahk` with a `RunMyAppCommand(count, key, modifier)` function.
2. Wire detection in `GetUserCmd` / `GetUserInput` / `AdjustAppStack` / `RunControlFocus` inside `hotKeys.ahk`.
3. Regenerate includes:

   ```bat
   ahk\regenerate_includes.bat
   ```

   or run `ahk\generate_includes.ahk` with AutoHotkey.
4. Reload `hotKeys.ahk`.

---

## Supported apps (modules)

| Module | Apps / windows |
| --- | --- |
| `acrobat.ahk` | Adobe Acrobat |
| `audacity.ahk` | Audacity |
| `chrome.ahk` | Google Chrome (and Electron apps sharing its class, where title-matched) |
| `cursor.ahk` | Cursor IDE |
| `excel.ahk` | Microsoft Excel |
| `filediff.ahk` | Qt-based file diff tools |
| `firefox.ahk` | Firefox Developer Edition |
| `ie.ahk` | Internet Explorer |
| `jabber.ahk` | Cisco Jabber |
| `logex.ahk` | Logex / related WinForms apps |
| `nav.ahk` | Dynamics NAV (C/SIDE) |
| `notepad.ahk` | Notepad |
| `outlook.ahk` | Outlook (mail + calendar modes) |
| `sketchup.ahk` | SketchUp |
| `slack.ahk` | Slack |
| `sql.ahk` | Azure Data Studio / SQL tooling |
| `teams.ahk` | Microsoft Teams |
| `vim.ahk` | gVim helpers (open file from other apps, etc.) |
| `visio.ahk` | Visio |
| `vs.ahk` | Visual Studio |
| `word.ahk` | Word / Writer |
| `xplorer2.ahk` | xplorer2 |
| `zoom.ahk` | Zoom |
| `global.ahk` | Cross-cutting utilities |

Bindings are intentionally personal and uneven — some modules are deep (Outlook, Firefox, Excel), others are light stubs. Read the matching `ahk/apps/*.ahk` file for the source of truth.

---

## Notes & caveats

- **CapsLock is remapped to Escape** for mode switching.
- Several Chrome-class apps (Chrome, Slack, Teams, Cursor, VS Code, Azure Data Studio) are distinguished by **window title**, not class alone.
- Multi-instance switching for Firefox, terminals, and Visual Studio uses an in-memory `dynamicWindowsStack`.
- Some macros assume companion tools (point-n-click via `Ctrl+F1`/`Ctrl+F2`, nircmd). Put `changeKeyboardLayout.ps1` in `scripts\` (next to the repo root) for the layout-switch hotkey.
- This is a long-lived personal automation layer — treat paths, titles, and key chords as starting points, not a universal product API.

---

## License

Use and adapt freely for personal or team workflows. If you publish changes, credit is appreciated but not required.
