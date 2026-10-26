<div align="center">

# Blue Blur Engine 🦔

[![Project Status: WIP](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-green.svg)](LICENSE)

<img src="https://raw.githubusercontent.com/blue-pulse/blue-blur-engine/4b0edf39eaa9c501c28c23c0ecaef26df9172ac1/assets/img/blue-blur-engine.png" alt="blue-blur-engine" width="500">

</div>

## Description

Blue Blur Engine is a 2D game engine developed with GameMaker, with a focus on movement physics. It is designed for games in the style of Sonic The Hedgehog, with 'boost' gameplay, and it can be adapted to other genres and styles.

It's important to note that *Sonic The Hedgehog* and all its content, including characters, music, and sound effects, are owned by SEGA and the Sonic Team.

## Requirements

- GameMaker LTS 2026
- Minimum runtime: 2026.0.0.23
- Python, only for the tools in `tools/`, and its minimum version is in `tools/pyproject.toml`

## Run the project

Sign in once in the GameMaker IDE, then run these commands from the root of the repository.

```
python tools/gm.py doctor
python tools/gm.py run
python tools/gm.py check
```

`check` needs no runtime and no licence. It reads the libraries from `Vendor`, treats a library as having an adapter once a file in `09. Adapters` uses it, and exits with 1 when any other file outside `Vendor` uses that library. It warns about the libraries that are still called without an adapter. `doctor` shows the runtime, the licence folder and the prefabs folder it found, and says what to do when one is missing. `run` compiles the project with Igor and starts the game, and it ends when you close the game window. Nothing needs configuring when GameMaker is installed in its usual place. When it is not, pass `--runtime-dir`, `--user-dir` or `--prefabs-dir`, or set `GM_RUNTIME_DIR`, `GM_USER_DIR` or `GM_PREFABS_DIR`. The tools keep their temporary files in `.sandbox/`, which git ignores. Only Windows has been verified.

[Decision 0002](./docs/decisions/0002-run-the-game-with-igor-run-and-the-prefabs-flag.md) states why the game is run this way.

### With an MCP server

[GMS MCP](./docs/reference/gms-mcp.md) is an optional server that lets an AI assistant read and edit the project. It is never required.

| Task | Command | MCP tool |
| --- | --- | --- |
| Check the setup | `python tools/gm.py doctor` | `gm_mcp_health` |
| Run the game | `python tools/gm.py run` | `gm_run`, which did not start this project in its tests, so use the command |
| Check the library boundaries | `python tools/gm.py check` | None |
| Read assets and references | Read the files | `gm_list_assets`, `gm_read_asset`, `gm_find_references` |

## Project organisation

The folders below are the project's logical organisation, the tree the GameMaker IDE shows when the project is open. It is independent of the disk, where the resources are grouped by type. [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md) states the rules for this organisation.

| Folder | What it holds |
| --- | --- |
| `01. Vendor` | Third-party components, which are never edited. |
| `02. Core` | The engine's services. |
| `03. World` | Solid geometry and the areas that act on the player. |
| `04. Player` | The generic player and its characters. |
| `05. Camera` | The camera. |
| `06. Interactables` | What the player touches, such as rings and springs. |
| `07. Enemies` | The enemies and their shared parent. |
| `08. Scenes` | The rooms and the flow between them. |
| `09. UI` | The HUD, overlays, menus and fonts. |

## Where to go next

We recommend reading the following documents in the order listed.

- [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md): how the project is organised and the invariants it keeps.
- [docs/PRINCIPLES.md](./docs/PRINCIPLES.md): the design principles every change is judged against.
- [docs/CONTRIBUTING.md](./docs/CONTRIBUTING.md): the rules every contributor follows.
- [docs/decisions/](./docs/decisions/): the records of choices that look unusual but are deliberate.
- [docs/PENDING.md](./docs/PENDING.md): the backlog of known work.
- [docs/reference/](./docs/reference/): guides to the external tools and resources the project uses.

## Credits

This project is a labor of love --built by fans, for fans-- and we're grateful to everyone who made it possible:

- **Sonic Team:** Owners of all character sprites, designs, and sound effects.
- **SEGA SOUND TEAM:** Composers of all the music used.
- **@ddenicc:** Designer of the project's beautiful logo.
- **@triangly, @singleshotgamer and @monolith4007:** Developers of the additional code used for the collision system and physics implementations.

## License

This project is licensed under the Apache License 2.0 - please refer to the [LICENSE](LICENSE) file for more details. The Apache License covers the code only. The third-party components in `01. Vendor` keep their own licences, the code derived from another project keeps its licence, and the sprites, music and sound effects belong to other people. [NOTICE.md](./NOTICE.md) records each of them.
