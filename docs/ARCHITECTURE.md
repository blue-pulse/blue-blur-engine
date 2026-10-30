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

The folders below are the project's logical organisation. An element that has sprites, sounds or animations splits its folder into `Logic`, `Sprites`, `Audio` and `Presentation`, keeping only those that exist.

- `01. Vendor` holds the third-party components, listed under Boundaries. Their internal layout is their authors' and is exempt from the structure rules.
- `02. Core` holds the engine's services, in nine folders: `01. Bootstrap` starts, restarts and stops the game and holds its global state, `02. Configuration` holds enums, macros, globals, fonts and particles, `03. Persistence` saves and loads user data, save data and settings and tracks those operations in a task queue, `04. Entities` holds the base objects of everything placed in a room and their shared draw routine, `05. Input` holds the checks built from the functions of the controls adapter, `06. Display` handles the screen, the GPU, the shared visual effects and the controller of the presentation that chooses the animations, `07. Physics` answers collision queries by ray and by box, `08. Tooling` holds the debugging tools and the editor icons, and `09. Adapters` holds the only code that calls a library of `Vendor`, with `01. Audio` over EasyAudio, `02. Scenes` over EasyFade, `03. Input` over Input and `04. Animation` over Resnip.
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

Third-party components live in the `01. Vendor` folder and are never edited. [NOTICE.md](../NOTICE.md) records each one with its origin and licence, and it also records the code derived from another project and the assets that belong to somebody else. The two configuration scripts of Input, `__InputConfig` and `__InputConfigVerbs`, stay in its folder and hold the project's settings and verbs.

| Component | Version | Responsibility |
| --- | --- | --- |
| Resnip | 0.2.0 | Animation |
| DB | 2.2.0 | Structured data with JSON serialization |
| EasyAudio | 2.0.0 | Audio groups and playback |
| EasyFade | 2.0.0 | Fades and room transitions |
| GMUtils | 2.1.0 | General utilities, such as angles and rounding |
| Input | 10.5.0 | Controls |
| SparkleStore | 1.4.2 | Save files |
| Sphinx | 1.0.0 | Encryption |

### The engine and a game

The engine's services live in `02. Core`. The other folders define one game: the movement and collision of the player, its character, the content of the stages, such as rings, enemies and obstacles, and the scenes and interface that put them together. The project is built for one genre today, so this boundary is where the code is divided and not an extension point.

### The logical organisation and the disk

The folders of the project's logical organisation are independent of the disk, where the resources are grouped by type.

### The project and its tools

The `tools/` folder holds the Python tools that check and run the project with Igor. It sits outside the logical organisation and is not part of the game. `gm.py` is its single entry point, and its commands are `doctor`, `run` and `check`, and `check` tests the rules that [0009](./decisions/0009-verify-behaviour-with-rules-replays-and-the-original-code.md) lists. The `.sandbox/` folder is their temporary space, and git ignores it. [0002](./decisions/0002-run-the-game-with-igor-run-and-the-prefabs-flag.md) states how the game is run, and the guides to the external tools and resources the project uses are in [reference/](./reference/).

## Cross-cutting concerns

### The frame and the player's state machine

Each frame, an instance of `obj_player` updates its timers with `player_update_params()`, runs its current state, limits its speeds to `speed_cap`, and then updates its grid, rotation and animation. The state is a function that is called with a phase, `INIT`, `STEP` or `STOP`, which is the State pattern of *Game Programming Patterns*. The player keeps its own `hor_speed` and `ver_speed`.

### Collision

The player resolves collisions with `player_collision_floor`, `player_collision_wall`, `player_collision_ceiling` and `player_collision_resource`. The floor, wall and ceiling checks use the queries in `02. Core/07. Physics`.

### Culling

When a stage sets `allow_culling`, the stage manager runs a periodic alarm that deactivates every instance of `obj_resource`, and then reactivates those inside the camera view and around the player.

### Persistence

`game_init_data` creates `userdata`, `savedata` and `settings` with `db_create`. The `file_*` functions write them through SparkleStore, encrypting the buffer first with Sphinx when the macro `ENCRYPT` is true, and track each operation in the task queue.

### Input, audio and animation

Controls are reached through the `input_*` functions of the adapter `02. Core/09. Adapters/03. Input`, described in the next section. Audio is played through the `mixer_*` functions, over EasyAudio, with the groups `grp_bgm`, `grp_sfx` and `grp_voices`. A room change with a fade goes through the `scene_*` functions, over EasyFade. Animation is played through the `animation_*` functions of the adapter `02. Core/09. Adapters/04. Animation`, over Resnip, as described after the controls contract.

### The controls contract

Every function acts on the player slot in the macro `PLAYER_SLOT`, which is 0 because the project has one player, and which is the player whose controls are read. A button is one of the `vb_*` macros, which the adapter defines over the verbs of the Input configuration. The face buttons `vb_a`, `vb_b`, `vb_x` and `vb_y` are positional, so `vb_a` is the bottom face button of a gamepad whatever its label, and `vb_accept` and `vb_back` are the menu buttons. Commands return nothing, and queries return a boolean, a number or an `input_devices` member. While `INPUT_COLLECT_MODE` is 0, Input collects in the Begin Step event, so every later event of a frame reads the same state.

| Function | Meaning |
| --- | --- |
| `input_held(button)` | True on every frame the button is active. |
| `input_pressed(button)` | True only on the first frame the button is active. |
| `input_released(button)` | True only on the first frame the button stops being active. |
| `input_pressed_any(buttons)` | True when any button of the array was pressed this frame. |
| `input_axis(positive, negative)` | Held positive minus held negative, so -1, 0 or 1, and 0 when both are held. Right and down are positive, and [0003](./decisions/0003-read-directions-with-input-axis-in-gamemakers-sign-order.md) states why. |
| `input_axis_pressed(positive, negative)` | The same with pressed in place of held. |
| `input_clear(button)`, `input_clear_all()` | Make the button, or every button, inactive until the player triggers it again. |
| `input_disable()`, `input_enable()` | Block and unblock the player. While blocked every button reads as inactive. |
| `input_disconnect()` | Remove the device from player 0. Input assigns a device again when it detects activity. |
| `input_get_device()` | The `input_devices` member for the device of player 0, which is `other` when there is none. |
| `input_vibrate(strength, frames)` | Vibrate the gamepad of player 0 with a strength from 0 to 1 for a number of frames, which the adapter converts to milliseconds at `MAX_FPS`. |
| `game_has_focus()` | True when the game window has focus and the operating system has not paused the application. |

### The animation contract

An animation, called a clip, is a sprite, or a run of its sub-images, with a speed. The logic never names a clip and never reads one. It publishes facts, and the presentation chooses which clip plays, as [0004](./decisions/0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md) states.

| Part | Where | Responsibility |
| --- | --- | --- |
| The logic | `04. Player` and `07. Enemies` | Decides, counts its durations in steps and writes the facts once per step. |
| `presentation_facts` | One struct in each instance | The record the logic writes and the presentation reads. |
| `presentation_update` and `presentation_init` | `02. Core/06. Display/03. Presentation/01. Controller` | Find the row of the state when it changes, run its `entry` list, and run its `follow` list every step. They hold no name of a state, a pose or a clip. |
| The selectors | `.../02. Selectors` | One script each. Each one picks a clip from the facts and asks the adapter to play it. |
| The rows and the clips | The shared rows of the player in `04. Player/01. Base/07. Presentation`, and the clips of a character or an enemy and the rows of an enemy in its own folder | Pure data. A row is `{ state, entry, follow }`, and each type builds its clips once. |
| The adapter | `02. Core/09. Adapters/04. Animation` | The only code that calls Resnip. |
| `game_set_step_rate` | `02. Core/06. Display/01. Screen` | The one owner of the game speed. It scales the clock of the animation to the rate over `MAX_FPS`. |

An instance that plays clips calls `animation_init` and `presentation_init` in its `Create` event, and runs `presentation_update` and `animation_update` once per step. It shows the frame through its own `sprite_index` and `image_index`. The player runs them after the state, in `player_update_animation`, and an enemy in its End Step event, in `enemy_update_animation`.

The facts of the player are these. An enemy publishes only `state`.

| Fact | Meaning |
| --- | --- |
| `state` | The mode of the body, by the identity of the state function. |
| `ledge` | 0 for none, 1 for a ledge in front and -1 for one behind. |
| `speed` | The absolute horizontal speed at the end of the step. |
| `rotation` | The angle of the body. |
| `rolling`, `rising`, `pushing`, `braking_turn` | Flags the logic owns and clears. They replaced reads of the animation, as [0006](./decisions/0006-replace-a-read-of-the-animation-by-explicit-state.md) states. |
| `spindash_revs`, `curl_ups`, `monitor_bounces` | Counters that only grow. A selector compares each with the last value it saw. |

A new fact comes with the selector that reads it and never before.

| Selector | What it does |
| --- | --- |
| `selector_direct` | Plays one clip. |
| `selector_by_fact` | Plays the clip of the first case whose value equals a fact. |
| `selector_by_band` | Plays the clip of the first case whose lower limit a fact reaches. |
| `selector_ladder` | Every step, picks a clip by speed and sets its pace. It skips the entering step and gives way when a named fact is true. |
| `selector_start` | Plays a clip at a pace taken from a fact and attaches an effect that lives while it plays. |
| `selector_while_fact` | Plays a clip on every step a fact holds. |
| `selector_on_count` | When a counter grew, runs another selector. |
| `selector_on_change` | When a fact changes to a value, runs the selector of that case. |

The durations that matter to the game are parameters of the logic in steps, listed in [0007](./decisions/0007-let-the-logic-own-the-durations-that-matter-to-the-game.md). The clips of a character come from `<character>_create_animations`, the shared rows from `player_create_presentation` and the fallback for a missing clip from `player_define_fallbacks`, as [0008](./decisions/0008-build-the-animations-once-and-share-them.md) states. A new state machine only has to write the same facts and keep the flags above.

| Function | Meaning |
| --- | --- |
| `animation_create(sprite, [options])` | Make a clip. The options are `speed`, `first_image` and `last_image` (sub-images, the whole sprite by default), `reversed`, and `next`, the clip that plays when this one ends. Create `next` first. |
| `animation_init()`, `animation_update()` | Prepare the instance in Create, and advance and show its clip once per step. |
| `animation_play(animation, [speed])` | Request a clip at a speed. It does nothing else when the clip already plays or a transition leads to it. |
| `animation_add_transition(from, to, via)` | When `to` is requested while `from` plays, `via` plays first. |
| `animation_is_playing(animation)` | True when it is the clip last requested, or the one now playing. Only the presentation uses it. |
| `animation_set_time_scale(scale)` | Scale the pace of every clip. Only `game_set_step_rate` calls it. |
| `animation_debug_draw(x, y)` | Draw the sub-images of the sprite with the frame now playing marked. |

After `animation_init` the instance holds `animation`, the clip last requested, which is `noone` until the first request. Only the presentation reads it. The speed belongs to the instance and not to the clip, so each `animation_play` sets it. A reversed clip plays from its last frame down.

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
- **Sub-image:** one image of a sprite, counted from 0.
- **Frame:** one image of an animation, counted from 0 at its first sub-image.
- **Clip:** an animation, which is a sprite or a run of its sub-images with a speed.
- **Transition:** a clip that plays between two others when the second is requested while the first plays.
- **Facts:** the record that the logic writes once per step and the presentation reads to choose a clip.
- **Row:** the data that says which selectors run when a state starts and while it lasts.
- **Selector:** a script that picks a clip from the facts and asks the adapter to play it.
- **Fallback:** the clip that plays in place of one a character does not have.
- **VM:** the runtime that interprets compiled bytecode, used while testing.
- **YYC:** the compiler that turns GML into native code through C++, used for the executables that are shared.
- **Runtime:** the versioned package of GameMaker that holds the compiler, the runner and Igor.
- **Igor:** the command line tool inside each runtime that compiles, runs and packages a project.
- **Prefab:** a ready-made set of assets that GameMaker downloads and that a project refers to by package.
