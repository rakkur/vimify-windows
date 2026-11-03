# vimify-windows

Vim as an **OS layer** for Windows — not just Vim keys inside a text box.

Most “Vim on Windows” tools stop at modal text editing (hjkl in Notepad, Word, etc.). This script goes further: command / insert modes, motions, and registers apply across the desktop, then extend into **app switching**, an **app stack**, and **per-app command maps** so the whole workstation feels like one Vim-shaped environment. Powered by [AutoHotkey](https://www.autohotkey.com/) v1.

This is a **personal** script — paths, apps, and chords are tuned for one workstation, not a general audience. If people really like it, I can advance it and make it more suitable for various users; otherwise, fork it and adapt it for your own setup.

---

## Features

### OS-layer Vim (the point of this script)

| Feature | How it works |
| --- | --- |
| **Command mode in any app** | `y` / `p` / `h` `j` `k` `l` / `u` / `x` / … work in command mode across Windows — not only in editors |
| **Goto app — `g{x}`** | `g` then a letter jumps to (or launches) that app — e.g. `gf` → Firefox, `gv` → Visual Studio, `gh` → gVim |
| **Last-window memory** | Plain `gh` / `gp` / `gv` restore the *last focused* GVim / Cursor / VS window (not always stack slot 1). `gp` prefers Cursor over VS Code |
| **App stack** | A homemade recent-app stack: `,` cycles back; `1,`…`9,` jumps N entries back through the apps you just used |
| **Multi-instance focus** | `Ctrl+Alt+1`…`9` / `0` jump to the Nth window of whichever IDE is foreground (VS → Cursor → GVim). `Ctrl+Alt+[` / `]` cycle that stack. Also: `g` + digit + letter for Firefox / terminals / VS (e.g. `g3v`) |
| **Solution-rooted GVim** | Open the current file into the GVim for that `.sln`/`.slnx` tree (or launch one). Bridge chords move paths between VS, Cursor, and GVim |
| **Registers** | Vim-style named clipboards: `"ay` yanks into register `a`, `"ap` pastes from it (`"[a-z]y` / `"[a-z]p`) |

### Also included

| Feature | What it does |
| --- | --- |
| **Modal editing** | Command mode for navigation & actions; insert mode (`i` / `a` / `c`) for typing |
| **Counts** | Numeric prefixes on motions (e.g. `5j`) |
| **Cell-run registers** | `N` + `Shift+H/J/K/L/T` (or `S`) yank/paste a run of adjacent cells into letter registers — handy in Excel / SQL grids |
| **Per-app bindings** | Extra command maps for Chrome, Excel, Outlook, Cursor, Firefox, and more |
| **Mode indicators** | Tray icon + multi-monitor corner overlays show command vs insert (and point-n-click state); insert mode also swaps the system cursor to an I-beam |
| **Point-n-click** | `` ` `` toggles click-vs-move mouse helpers used by app macros |
| **Temp insert** | Some rename/edit flows (e.g. VS `F2`) enter insert until `Enter`, then return to command mode |

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
| `Ctrl+Alt+,` | Toggle whether `,` jumps the app stack (vs sending a literal comma — useful in GVim) |
| `Ctrl+Alt+Left` / `Right` | Move the active window across monitors (`Win+Shift+Arrow`) |
| `Ctrl+Alt+Shift+L` | Switch keyboard layout helper (Dvorak / QWERTY) |
| `Ctrl+Alt+1`…`9` / `0` | Activate Nth window in the foreground IDE stack (VS, Cursor, or GVim) |
| `Ctrl+Alt+[` / `]` | Cycle previous / next window in that same stack |
| `Ctrl+Alt+Shift+G` | Pick a folder and open a new GVim rooted there (titlestring + `--servername`) |

---

## Modes

The script tracks a global `vi` flag:

| Mode | Enter with | Behavior |
| --- | --- | --- |
| **Command** (`vi = 1`) | `Esc` / `CapsLock` | Keys are remapped to motions, edits, and app commands |
| **Insert** (`vi = 0`) | `i`, `a`, or `c` (delete + insert) | Most keys pass through as normal typing |

In command mode the icon uses the “normal” glyph; in insert mode it switches to the “edit” glyph (and the system cursor becomes an I-beam). The same icons also encode **point-n-click** state (`ahk_0.bmp` / `ahk_1.bmp`, `ahk_edit_0.bmp` / `ahk_edit_1.bmp`). Overlays are placed at fixed corners for a multi-monitor layout.

**Special case:** when the active window is real Vim, a Vim console titled `VIM`, or **Cursor**, the script mostly stays out of the way and forwards keys (with a few Cursor-specific overrides). `CapsLock` (with any modifiers) acts as Escape for mode switching.

---

## Global command-mode keys

These work in **any** application while command mode is on (unless an app module overrides them):

| Key | Action |
| --- | --- |
| `h` `j` `k` `l` | Left / down / up / right |
| `N` + motion | Repeat (e.g. `5j`) |
| `y` / `p` / `x` | Yank / paste / cut (`Ctrl+C` / `Ctrl+V` / `Ctrl+X`) |
| `u` | Undo (`Ctrl+Z`) |
| `i` / `a` | Enter insert mode |
| `c` | Delete, then insert mode |
| `;` / `q` | Page down / page up |
| `Alt+;` / `Alt+q` | Shift+PageDown / Shift+PageUp |
| `Alt+hjkl` | Extend selection with arrows |
| `"ay` / `"ap` | Yank into / paste from register `a` (any letter `a`–`z`) |
| `g` | Goto-app prefix (see below) |
| `,` | Previous app on the stack |
| `1,` … `9,` | Jump N apps back on the stack |
| `\` | Jump to Vim (`h`) |
| `` ` `` | Toggle point-n-click (`Ctrl+F1` / `Ctrl+F2`) |
| `Esc` / `CapsLock` | Return to command mode |

---

## App switching (`g{x}`)

Press `g`, then a letter within ~3s — like a Vim `g` motion, but for programs:

| Chord | Target |
| --- | --- |
| `gx` | xplorer2 / Explorer |
| `gh` | gVim |
| `gf` | Firefox Developer Edition |
| `ga` | Google Chrome |
| `gp` | Cursor first, then VS Code / Acrobat (shared Chrome-class letter) |
| `gr` | Slack |
| `gs` | Azure Data Studio |
| `gt` | Microsoft Teams |
| `go` | Outlook |
| `ge` | Excel |
| `gw` | Word / LibreOffice Writer (`SALFRAME`) |
| `gc` | Console / Windows Terminal |
| `gv` | Visual Studio |
| `gn` | Notepad / NAV (C/SIDE) |
| `gi` | Internet Explorer |
| `gj` | Jabber |
| `gl` | Logex / SnakeTail |
| `gy` | Zoom / Join.me / RDP |

### Last-window memory

Plain `gh` / `gp` / `gv` (and comma-back into those apps) restore the **last focused** window hwnd for that IDE — not always dynamic-stack slot 1. `gp` prefers Cursor over VS Code when both exist.

### Multi-instance windows

**IDE stack (global):** `Ctrl+Alt` numbers / brackets pick among open windows of the foreground IDE family:

- `Ctrl+Alt+3` → 3rd window in the foreground app’s stack  
- `Ctrl+Alt+0` → 10th window  
- `Ctrl+Alt+[` / `]` → previous / next in the stack  

Foreground decides which stack: VS first, else Cursor, else GVim (so from a non-IDE window, numbers still drive GVim).

**Via `g`:** for apps that keep a dynamic window stack (Firefox, terminals, Visual Studio / GVim), insert a digit after `g`:

- `g2f` → 2nd Firefox window  
- `g3v` → 3rd Visual Studio instance  
- `g1c` … `g6c` → numbered consoles / terminals  

### App stack (`,` / `N,`)

Every focus switch updates a recent-app stack. From command mode:

- `,` → jump to the previous app on the stack  
- `3,` → jump three entries back  
- `1,` … `9,` → same idea for deeper history  

This is how you bounce between “the last few things I was actually using” without remembering their `g` letters. `Ctrl+Alt+,` toggles whether `,` does this jump or types a literal comma.

---

## Solution-rooted GVim

GVim instances are tagged by solution/repo root (window titlestring `|root| -- filename`, hashed `--servername`). Opening a file from another app finds the matching GVim or launches one.

| From | Chord | What happens |
| --- | --- | --- |
| Visual Studio | `o` (command mode) | Copy full path + line → open in the GVim for that `.sln`/`.slnx` tree |
| Cursor | `Ctrl+o` | Same idea for the current Cursor file |
| xplorer2 | `Shift+o` | Open the selected file path in the matching GVim |
| Anywhere | `Ctrl+Alt+Shift+G` | Folder picker → new GVim rooted at that path |

### Bridge chords (while GVim is focused)

| Chord | Action |
| --- | --- |
| `Shift+F7` | Send current path into Cursor |
| `Shift+F8` | Push project/file into the matching Visual Studio instance |
| `Shift+F9` | Jump to Slack |
| `Shift+F10` | Jump to Firefox |
| `Shift+F12` | Jump to xplorer2 |

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
| `vim.ahk` | gVim helpers (solution-rooted open, bridge chords, etc.) |
| `visio.ahk` | Visio |
| `vs.ahk` | Visual Studio |
| `vscode.ahk` | Visual Studio Code |
| `word.ahk` | Word / Writer |
| `xplorer2.ahk` | xplorer2 |
| `zoom.ahk` | Zoom |
| `global.ahk` | Cross-cutting utilities |

Bindings are intentionally personal and uneven — some modules are deep (Outlook, Firefox, Excel), others are light stubs. Read the matching `ahk/apps/*.ahk` file for the source of truth.

---

## Notes & caveats

- **CapsLock is remapped to Escape** (all modifier combos) for mode switching.
- Several Chrome-class apps (Chrome, Slack, Teams, Cursor, VS Code, Azure Data Studio) are distinguished by **window title**, not class alone.
- Multi-instance switching uses an in-memory `dynamicWindowsStack` (FF / CMD / VS / GVIM / CURSOR) plus last-hwnd restore for IDE jumps.
- Outlook command maps flip between mail and calendar with `s`.
- Some macros assume companion tools (point-n-click via `Ctrl+F1`/`Ctrl+F2`, nircmd). Put `changeKeyboardLayout.ps1` in `scripts\` for the layout-switch hotkey.
---

## License

Use and adapt freely. Forks welcome. Credit is appreciated but not required.
