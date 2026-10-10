# Architecture

## About this document

This document is a map of Blue Blur Engine. It is for anyone who needs to find their way around the project before changing it.

It contains a bird's-eye view, a codemap of the main parts and how they relate, the invariants the project keeps, the boundaries between parts, the concerns that cut across all of them, and a glossary of the terms of the domain explained in the vocabulary of software engineering. It names important files and types without linking to them, so search for a name to find it. Its structure follows the article "ARCHITECTURE.md" by matklad (2021), with the glossary added.

It deliberately leaves out implementation detail, which the code states, the rules you follow, which are in [CONTRIBUTING.md](./CONTRIBUTING.md), and the reasoning behind unusual choices, which is in [decisions/](./decisions/).

Update it when a part is added, removed or renamed, or when an invariant or boundary changes. Revisit it as a whole from time to time rather than on every change, because it describes what rarely changes.

## Bird's-eye view

Blue Blur Engine is a 2D game engine that runs on GameMaker. A game is a set of rooms, and the engine runs one room at a time. Each room holds the instances of the objects that make it up, and the engine updates them once per frame.

The game starts in the room `rm_init_game`. Its object `obj_init_manager` calls `framework_start()`, which resets the base state and, on the first run, creates the global data structures for user data, save data and settings, schedules the loading of the configuration, and prepares the screen and the audio. When the audio groups are loaded and the asynchronous queue is empty, the object fades to `rm_title`, or to `rm_home` if the game was already initialised. The room `rm_stop_game` ends the process.

A gameplay room is prepared by a stage manager, `obj_stage_manager`. Its creation runs `stage_bootstrap()`, which resets the counters and the player's score and time, and `stage_init_data()`, which selects the setup function for the current room and starts its music. A room change goes through `stage_goto()` or `room_fadeto()`.

## Codemap

The folders below are the project's logical organisation.

### Third-party and core

- `1. Vendor` holds the third-party components, listed under Boundaries.
- `2. Core` holds the engine's services, in nine folders: `1. Bootstrap` starts and stops the game and holds its global state, `2. Configuration` holds enums, macros, globals, fonts and particles, `3. Persistence` saves and loads user data, save data and settings, `4. Tasks` is the task queue, `5. Input` wraps the input devices and their checks, `6. Display` handles the screen and the GPU, `7. Animation` plays animations and their events, `8. Physics` answers collision queries by ray and by box, and `9. Tooling` holds the debugging tools.

### Earlier layout

These folders are being migrated one domain at a time, as [PENDING.md](./PENDING.md) describes, so treat their layout as provisional.

- `2. Framework` has the subfolders Assets, Managers, Scripts and Setup.
- `3. Visuals` has Assets, Camera and GUI, and `3. World` has no subfolders.
- `4. Player` has Player and Sonic.
- `5. Enemies` has Effects, Objects, Parents, Scripts, Sounds and Sprites.
- `6. Items` has Checkpoints, Dashpads, Monitors, Obstacles, Rings and Springs.
- `7. Stages` has Assets, Managers, Parents, Rooms, Scripts and Setup.
- `8. Usable` has Spawner, Terrain and Triggers.

### Main objects

- `obj_player` is the generic player, and `obj_sonic` inherits from it. `obj_player_spawner` builds the gameplay scene of a room: the player, the camera `obj_camera`, the stage manager and the interface `obj_hud`.
- `obj_stage_manager` runs the setup of a gameplay room. `obj_title_manager`, `obj_home_manager` and `obj_pause_manager` are the managers of the title, home and pause rooms.
- `obj_enemy` is the parent of the enemies, such as `obj_motobug`.

## Invariants

- At most one manager of each kind exists at a time, because `manager_create` creates one only if none exists.
- Apart from the initial state a player is created with, its state changes only through `player_set_state`, which stops the previous state before it starts the next.

## Boundaries

### Our code and third-party code

Third-party components live in the `1. Vendor` folder and are never edited. Each keeps its licence in `datafiles/licenses/`.

| Component | Version | Responsibility | Licence | Copyright |
| --- | --- | --- | --- | --- |
| AESnips | 0.1.4 | Animation | MIT | William Jones |
| DB | 2.2.0 | Structured data with JSON serialization | MIT | Julian Adams |
| EasyAudio | 1.1.0 | Audio groups and playback | MIT | Blue Pulse |
| EasyFade | 1.2.4 | Fades and room transitions | MIT | Blue Pulse |
| GMUtils | 2.0.5 | General utilities, such as angles and rounding | MIT | Blue Pulse |
| Input | 10.3.0 | Controls | MIT | Julian Adams |
| SparkleStore | 1.4.2 | Save files | MIT | Julian Adams |
| Sphinx | 1.0.0 | Encryption | MIT | Julian Adams |

### The engine and a game

The code is divided between the engine's services, such as input, persistence, display and the stage flow, and the parts that define one game: the movement and collision of the player, its character, and the content of the stages, such as rings, enemies and obstacles. The project is built for one genre today, so this boundary is where the code is divided and not an extension point.

### The logical organisation and the disk

The folders of the project's logical organisation are independent of the disk, where the resources are grouped by type.

## Cross-cutting concerns

### The frame and the player's state machine

Each frame, an instance of `obj_player` updates its timers with `player_update_params()`, runs its current state, limits its speeds to `speed_cap`, and then updates its grid, rotation and animation. The state is a function that is called with a phase, `INIT`, `STEP` or `STOP`, which is the State pattern of *Game Programming Patterns*. The player keeps its own `hor_speed` and `ver_speed`.

### Collision

The player resolves collisions with `player_collision_floor`, `player_collision_wall`, `player_collision_ceiling` and `player_collision_resource`. The floor, wall and ceiling checks use the queries in `2. Core/8. Physics`.

### Culling

When a stage sets `allow_culling`, the stage manager runs a periodic alarm that deactivates every instance of `obj_resource`, and then reactivates those inside the camera view and around the player.

### Persistence

`game_init_data` creates `userdata`, `savedata` and `settings` with `db_create`. The `file_*` functions write them through SparkleStore, encrypting the buffer first with Sphinx when the macro `ENCRYPT` is true, and track each operation in the task queue.

### Input, audio and animation

Input is reached through the functions in `2. Core/5. Input`. Audio uses EasyAudio, with the groups `grp_bgm`, `grp_sfx` and `grp_voices`. Animation is played through the functions in `2. Core/7. Animation`, over AESnips.

## Glossary

- **Room:** a scene or level. The engine loads and runs one at a time.
- **Object:** a class of things placed in a room, defined by its events.
- **Instance:** one live copy of an object, with its own state.
- **Event:** a handler that runs on a condition, such as `Create`, `Step`, `Alarm` or `Draw`.
- **Step:** one tick of the main loop, which runs once per frame.
- **Alarm:** a countdown timer in an instance that triggers an event when it reaches zero.
- **Script:** a file that holds a function.
- **Macro:** a constant replaced by its value when the project is compiled.
- **Enum:** a named set of constants.
- **Layer:** an ordered group inside a room, such as a layer of instances.
- **VM:** the runtime that interprets compiled bytecode, used while testing.
- **YYC:** the compiler that turns GML into native code through C++, used for the executables that are shared.
