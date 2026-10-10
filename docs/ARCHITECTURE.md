# Architecture

## About this document

This document is a map of Blue Blur Engine. It is for anyone who needs to find their way around the project before changing it.

It contains a bird's-eye view, a codemap of the main parts and how they relate, the invariants the project keeps, the boundaries between parts, the concerns that cut across all of them, and a glossary of the terms of the domain explained in the vocabulary of software engineering. It names important files and types without linking to them, so search for a name to find it. Its structure follows the article "ARCHITECTURE.md" by matklad (2021), with the glossary added.

It deliberately leaves out implementation detail, which the code states, the rules you follow, which are in [CONTRIBUTING.md](./CONTRIBUTING.md), and the reasoning behind unusual choices, which is in [decisions/](./decisions/).

Update it when a part is added, removed or renamed, or when an invariant or boundary changes. Revisit it as a whole from time to time rather than on every change, because it describes what rarely changes.

## Bird's-eye view

Blue Blur Engine is a 2D game engine that runs on GameMaker. A game is a set of rooms, and the engine runs one room at a time. Each room holds the instances of the objects that make it up, and the engine updates them once per frame.

The game starts in the room `rm_init_game`. Its object `obj_init_manager` calls `framework_start()`, which resets the base state and, on the first run, creates the global data structures for user data, save data and settings, schedules the loading of the configuration, and prepares the screen and the audio. When the audio groups are loaded and the asynchronous queue is empty, the object fades to `rm_title`, or to `rm_home` if the game was already initialised. The room `rm_stop_game` ends the process.

A gameplay room is prepared by a stage manager, `obj_stage_manager`. Its creation runs `stage_bootstrap()`, which resets the counters and the player's score and time, and `stage_init_data()`, which selects the setup function for the current room and starts its music. A room change goes through `stage_goto()` or `scene_change()`.

## Codemap

The folders below are the project's logical organisation. An element that has sprites or sounds splits its folder into `Logic`, `Sprites` and `Audio`, keeping only those that exist.

- `01. Vendor` holds the third-party components, listed under Boundaries. Their internal layout is their authors' and is exempt from the structure rules.
- `02. Core` holds the engine's services, in ten folders: `01. Bootstrap` starts, restarts and stops the game and holds its global state, `02. Configuration` holds enums, macros, globals, fonts and particles, `03. Persistence` saves and loads user data, save data and settings and tracks those operations in a task queue, `04. Entities` holds the base objects of everything placed in a room and their shared draw routine, `05. Input` wraps the input devices and their checks, `06. Display` handles the screen, the GPU and the shared visual effects, `07. Animation` plays animations and their events, `08. Physics` answers collision queries by ray and by box, `09. Tooling` holds the debugging tools and the editor icons, and `10. Adapters` holds the only code that calls a library of `Vendor`, with `01. Audio` over EasyAudio and `02. Scenes` over EasyFade.
- `03. World` holds the solid geometry the player stands on and the areas that act on the player: `01. Shapes`, `02. Platforms` and `03. Triggers`.
- `04. Player` holds `01. Base`, the generic player split by responsibility into runtime, states, movement, collision, reactions, status and presentation, and `02. Sonic`, the first character.
- `05. Camera` holds the camera object and its behaviour.
- `06. Interactables` holds what the player touches, with one folder each for rings, springs, monitors, checkpoints, dash panels and spikes.
- `07. Enemies` holds `01. Base`, the shared parent and helpers, and one folder per enemy.
- `08. Scenes` holds `01. Common`, the flow and setup shared by rooms, and one folder per scene: title, home, pause, hub world and test zone.
- `09. UI` holds the HUD, the overlays, the menus and the fonts.

### Main objects

- `obj_player` is the generic player, and `obj_sonic` inherits from it. `obj_player_spawner` builds the gameplay scene of a room: the player, the camera `obj_camera`, the stage manager and the interface `obj_hud`.
- `obj_stage_manager` runs the setup of a gameplay room. `obj_title_manager`, `obj_home_manager` and `obj_pause_manager` are the managers of the title, home and pause rooms.
- `obj_enemy` is the parent of the enemies, such as `obj_motobug`.

## Invariants

- At most one manager of each kind exists at a time, because `manager_create` creates one only if none exists.
- Apart from the initial state a player is created with, its state changes only through `player_set_state`, which stops the previous state before it starts the next.

## Boundaries

### Our code and third-party code

Third-party components live in the `01. Vendor` folder and are never edited. Each keeps its licence in `datafiles/licenses/`.

| Component | Version | Responsibility | Licence | Copyright |
| --- | --- | --- | --- | --- |
| AESnips | 0.1.4 | Animation | MIT | William Jones |
| DB | 2.2.0 | Structured data with JSON serialization | MIT | Julian Adams |
| EasyAudio | 2.0.0 | Audio groups and playback | MIT | Blue Pulse |
| EasyFade | 2.0.0 | Fades and room transitions | MIT | Blue Pulse |
| GMUtils | 2.1.0 | General utilities, such as angles and rounding | MIT | Blue Pulse |
| Input | 10.3.0 | Controls | MIT | Julian Adams |
| SparkleStore | 1.4.2 | Save files | MIT | Julian Adams |
| Sphinx | 1.0.0 | Encryption | MIT | Julian Adams |

### The engine and a game

The engine's services live in `02. Core`. The other folders define one game: the movement and collision of the player, its character, the content of the stages, such as rings, enemies and obstacles, and the scenes and interface that put them together. The project is built for one genre today, so this boundary is where the code is divided and not an extension point.

### The logical organisation and the disk

The folders of the project's logical organisation are independent of the disk, where the resources are grouped by type.

## Cross-cutting concerns

### The frame and the player's state machine

Each frame, an instance of `obj_player` updates its timers with `player_update_params()`, runs its current state, limits its speeds to `speed_cap`, and then updates its grid, rotation and animation. The state is a function that is called with a phase, `INIT`, `STEP` or `STOP`, which is the State pattern of *Game Programming Patterns*. The player keeps its own `hor_speed` and `ver_speed`.

### Collision

The player resolves collisions with `player_collision_floor`, `player_collision_wall`, `player_collision_ceiling` and `player_collision_resource`. The floor, wall and ceiling checks use the queries in `02. Core/08. Physics`.

### Culling

When a stage sets `allow_culling`, the stage manager runs a periodic alarm that deactivates every instance of `obj_resource`, and then reactivates those inside the camera view and around the player.

### Persistence

`game_init_data` creates `userdata`, `savedata` and `settings` with `db_create`. The `file_*` functions write them through SparkleStore, encrypting the buffer first with Sphinx when the macro `ENCRYPT` is true, and track each operation in the task queue.

### Input, audio and animation

Input is reached through the functions in `02. Core/05. Input`. Audio is played through the `mixer_*` functions, over EasyAudio, with the groups `grp_bgm`, `grp_sfx` and `grp_voices`. A room change with a fade goes through the `scene_*` functions, over EasyFade. Animation is played through the functions in `02. Core/07. Animation`, over AESnips.

## Glossary

- **Room:** a scene or level. The engine loads and runs one at a time.
- **Object:** a class of things placed in a room, defined by its events.
- **Instance:** one live copy of an object, with its own state.
- **Entity:** an object placed in a room that the engine culls and the player interacts with, which here means any child of `obj_resource`.
- **Event:** a handler that runs on a condition, such as `Create`, `Step`, `Alarm` or `Draw`.
- **Step:** one tick of the main loop, which runs once per frame.
- **Alarm:** a countdown timer in an instance that triggers an event when it reaches zero.
- **Script:** a file that holds a function.
- **Macro:** a constant replaced by its value when the project is compiled.
- **Enum:** a named set of constants.
- **Layer:** an ordered group inside a room, such as a layer of instances.
- **VM:** the runtime that interprets compiled bytecode, used while testing.
- **YYC:** the compiler that turns GML into native code through C++, used for the executables that are shared.
