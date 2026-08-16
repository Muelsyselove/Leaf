<!-- markdownlint-disable -->

[简体中文](README.md) | **English**

<div align="center">

<img src="./src-tauri/icons/icon.png" width="120" alt="Ecology Section Archive icon">

# Ecology Section Archive

A local Markdown note archive terminal in Rhine Lab Ecological Section style<br>
Built with Tauri 2 + React · Plantable via the ECO launcher

[Report an Issue](https://github.com/Muelsyselove/Leaf/issues) · [Changelog](https://github.com/Muelsyselove/Leaf/releases)<br>
[Quick Start](#quick-start) · [ECO Integration](#eco-integration) · [Building from Source](#building-from-source)

[![Version](https://img.shields.io/github/v/release/Muelsyselove/Leaf)](https://github.com/Muelsyselove/Leaf/releases/latest)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)<br>
![React 19](https://img.shields.io/badge/React-19-blue?logo=react)
![Tauri v2](https://img.shields.io/badge/Tauri-v2-%2324C8D8?logo=tauri)
![Rust Edition 2021](https://img.shields.io/badge/Rust-2021-%23000000?logo=rust)

</div>

<!-- markdownlint-restore -->

---

## About

**Ecology Section Archive** (生态科档案) is a local Markdown sticky-note app themed after the Rhine Lab Ecological Section from _Arknights_. It is a complete rebrand and visual rebuild of the open-source project [floral-notepaper](https://github.com/Achilng/floral-notepaper): every original capability is preserved, while the interface is reshaped into an ecological data terminal — pale gray-green surfaces, eco-teal accents, chamfered polygons, diamond grids, scanlines and hexagonal insignia, typeset in Saira / Michroma / IBM Plex Mono. Every note you take feels like filing a specimen record.

> This is a personal, non-commercial fan-style derivative project. It is not affiliated with Hypergryph or the official _Arknights_ franchise.

![Main window](Docs/images/main-window.png)

## Features

- **Markdown Editing & Preview** — GFM syntax, KaTeX math, GFM Alerts and in-document heading navigation, with edit / preview / split views
- **Quick Notepad** — Summon a notepad anytime from the tray or via a global shortcut (`Ctrl+Space` by default), optionally appearing next to your cursor
- **Tile Mode** — Pin notes anywhere on your desktop for quick reference and copying
- **Images & Files** — Paste or drag images into the editor; drop `.md` / `.markdown` / `.txt` files to open them directly
- **Import & Export** — Import and export `.md` files
- **Thoughtful Details** — Autosave, undo / redo, editor context menu, Tab indentation, toast notifications
- **Localization** — Simplified Chinese / Traditional Chinese / English
- **Personalization** — Custom main-window background, customizable global shortcuts, launch at login
- **In-app Updates** — Check, download and install new versions right from Settings

## Use Cases

- An always-visible clipboard for stashing and copying text
- Jotting things down while gaming or watching videos
- Capturing fleeting thoughts and ideas
- An on-desktop to-do list

## Quick Start

### Option 1: Plant with the ECO Launcher (Recommended)

This repository is ECO-friendly. Use the [ECO Launcher](https://github.com/Muelsyselove/Rhine-Lab-Ecological-Section) to "plant" this repository — downloading, extraction, dependency setup and launch are handled automatically.

### Option 2: Run Locally (Development)

Requirements: [Node.js](https://nodejs.org/) 24+ and the [Rust](https://www.rust-lang.org/) toolchain (on Windows, Visual Studio Build Tools are required).

```bash
git clone https://github.com/Muelsyselove/Leaf.git
cd Leaf
npm install
npm run start
```

On Windows you can also double-click `start.bat` (it handles port cleanup and execution policy for you).

### Run Tests

```bash
npm test
```

## ECO Integration

The repository ships an [eco-manifest.json](eco-manifest.json) at its root. Releases provide only an ECO-friendly archive `ecology-section-archive-<version>-eco.tar.gz` (full source tree + dependency manifest + launch manifest) — no installers are attached. ECO uses it to "fertilize" (`npm install`) and "observe" (`npm run start`).

> Since this app is built on Tauri, the first launch compiles the Rust backend on your machine. Make sure the Rust toolchain is installed.

## Building from Source

```bash
npm install
npm run tauri build
```

Build artifacts are located in `src-tauri/target/release/bundle/`.

## Tech Stack

| Layer             | Technology                          |
| ----------------- | ----------------------------------- |
| Desktop Framework | Tauri 2 (Rust 2021)                 |
| Frontend          | React 19 · TypeScript · Vite        |
| Styling           | Tailwind CSS 4                      |
| Markdown          | react-markdown · remark-gfm · KaTeX |
| i18n              | i18next · react-i18next             |
| Testing           | Vitest (96 tests)                   |

## Project Structure

```text
├── src/                  # Frontend (React + TypeScript)
│   ├── components/       # Main window, settings, about, tiles, eco decoration components
│   ├── features/         # Feature domains: markdown / notes / settings / update / windows
│   ├── locales/          # Trilingual translation resources
│   └── assets/fonts/     # Saira / Michroma / IBM Plex Mono and other fonts
├── src-tauri/            # Rust backend (Tauri 2: note storage, window management, updater)
├── Docs/                 # Documentation and UI screenshots
├── scripts/              # Development scripts (version sync, window capture)
├── start.bat / start.ps1 # One-click Windows launch entry
└── eco-manifest.json     # ECO launcher integration manifest
```

## Screenshot Permission

You are **explicitly allowed to take screenshots or recordings of this application's interface** and use them for introductions, reviews, sharing, or derivative-work reference — no prior permission required.

## License

This project is open-sourced under the [MIT License](LICENSE):

- Original project code © [Achilng](https://github.com/Achilng) (floral-notepaper, MIT)
- Rebrand and new additions © [Muelsyselove](https://github.com/Muelsyselove)

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and the license files under `src/assets/fonts/` for third-party component and font licenses.

## Acknowledgements

- [floral-notepaper](https://github.com/Achilng/floral-notepaper) — the functional foundation of this project. Thanks to Achilng and all upstream contributors
- [Tauri](https://tauri.app/) · [React](https://react.dev/) · [Tailwind CSS](https://tailwindcss.com/) · [Vite](https://vite.dev/) · [i18next](https://www.i18next.com/) · [react-markdown](https://github.com/remarkjs/react-markdown) · [KaTeX](https://katex.org/)
- Fonts: [Saira](https://fonts.google.com/specimen/Saira) · [Michroma](https://fonts.google.com/specimen/Michroma) · [IBM Plex Mono](https://www.ibm.com/plex/) · HarmonyOS Sans SC · Source Han Serif
- Rhine Lab from _Arknights_ — the source of visual inspiration (unofficial tribute)

## Related Projects

- [Rhine-Lab-Ecological-Section](https://github.com/Muelsyselove/Rhine-Lab-Ecological-Section) — the ECO launcher, sharing the same visual identity
