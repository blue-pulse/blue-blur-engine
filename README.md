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

## Credits

This project is a labor of love --built by fans, for fans-- and we're grateful to everyone who made it possible:

- **Sonic Team:** Owners of all character sprites, designs, and sound effects.
- **SEGA SOUND TEAM:** Composers of all the music used.
- **@ddenicc:** Designer of the project's beautiful logo.
- **@triangly, @singleshotgamer and @monolith4007:** Developers of the additional code used for the collision system and physics implementations.

## License

This project is licensed under the Apache License 2.0 - please refer to the [LICENSE](LICENSE) file for more details. The third-party components in `01. Vendor` keep their own licences, which are in [`datafiles/licenses/`](./datafiles/licenses/).
