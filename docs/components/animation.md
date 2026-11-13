# Animation

## About this document

This document describes how the animation of the player and of the enemies works, and how to change it. It is for anyone about to add, remove, rename or change a clip, a state, a fact, a selector, a character or an enemy. Read it before you change `02. Core/06. Display/03. Presentation`, `02. Core/09. Adapters/04. Animation`, any `Presentation` folder of `04. Player` or `07. Enemies`, `player_publish_facts`, `player_update_animation`, `enemy_update_animation`, `game_set_step_rate`, or the events `Step_1` of `obj_player` and `Step_2` of `obj_enemy`.

It contains a summary, the part as a black box, how one step of the player and of an enemy flows through it, its parts and the variables of an instance, the facts, the selectors and the rows, the interfaces, the invariants with the check that detects each, a map of the edits for each kind of change, its cost and its known risks. It leaves out why it is built this way, which is in [decisions/](../decisions/), the rules, which are in [CONTRIBUTING.md](../CONTRIBUTING.md), how Resnip behaves, which is in [reference/resnip.md](../reference/resnip.md), and how a change is compared with the original code, which is in [replay.md](./replay.md).

Update it in the same change as the code it describes. Every name, signature and value here was read from the code, so re-read them when the code changes.

## Summary

- The logic decides what the body is doing and publishes it as facts. The presentation reads the facts, finds the row of data of the current state and runs the selectors the row lists. A selector picks a clip and asks the adapter to play it.
- Everything follows from one rule: the logic never names a clip and never reads one, and the presentation names no state, no pose and no clip ([0004](../decisions/0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md)).
- The player picks its clip and then advances it, and an enemy advances first and then picks, so an enemy shows a new clip one step late on purpose ([0012](../decisions/0012-keep-the-enemy-animation-one-step-behind-its-state.md)).

## Context

The logic is the states of `04. Player` and the `Step` events of `07. Enemies`. It gives the presentation one record of facts per instance. The presentation gives back a `sprite_index` and an `image_index` on the instance, which `draw_object` and the player's draw event show. The code lives in these places.

| Folder | Holds |
| --- | --- |
| `02. Core/06. Display/03. Presentation/01. Controller` | `presentation_init`, `presentation_update` |
| `02. Core/06. Display/03. Presentation/02. Selectors` | the eight `selector_*` scripts |
| `02. Core/06. Display/01. Screen` | `game_set_step_rate` |
| `02. Core/09. Adapters/04. Animation` | the `animation_*` functions, the only code that calls Resnip |
| `04. Player/01. Base/07. Presentation/01. Animation` | `player_create_presentation`, `player_define_fallbacks`, `player_resolve_clips`, `player_update_animation` |
| `04. Player/02. Sonic/04. Presentation` | `sonic_create_animations`, `sonic_create_presentation`, `sonic_init_animations`, `sonic_init_transitions` |
| `07. Enemies/01. Base/04. Presentation` | `enemy_update_animation` |
| `07. Enemies/NN. <Enemy>/03. Presentation` | `<enemy>_init_animations`, one per enemy |

It depends on Resnip, only through the adapter, and on `map` of GMUtils and on `vfx_create` of the effects. Search for a name to find it.

## How it works

### One step of the player

The events of `obj_player` run in the Begin Step event, in this order, and only while `allow_movement` is true.

1. `player_update_params` updates the timers.
2. `state(STEP)` runs the current state, which may call `player_set_state`. The states set the flags that become facts.
3. `hor_speed` and `ver_speed` are clamped to `speed_cap`. The trail span is set when either speed reaches 8.
4. `player_update_grid` and `player_update_rotation` run.
5. `player_publish_facts` copies the variables of the logic into `presentation_facts`.
6. `player_update_animation` runs `presentation_update`, then `animation_update`, then updates the alpha of the trail.

The order matters because the facts must be the ones at the end of the step. The speed is read after the clamp, the rotation after its update, and a flag set by the state is read in the same step. Because the clip is chosen before it advances, the player shows the new clip on the step its state changes. When `allow_movement` is false nothing here runs, so the animation freezes with the player.

### One step of an enemy

1. The `Step` event of the enemy, such as `Step_0` of `obj_motobug`, runs its logic and may change `state`. A change that goes through `enemy_invoke_turn` also sets `state_timer` to 0 and `hspeed` to 0.
2. The End Step event of `obj_enemy`, `Step_2`, calls `enemy_update_animation`. It runs `animation_update` first, then sets `presentation_facts.state = state`, then runs `presentation_update`.
3. The draw event shows `sprite_index` and `image_index`.

The enemy advances first and chooses after, so the clip requested at the end of step N is first shown by the `animation_update` of step N+1. That keeps the pictures of the original code, and it is why code must read `state` of an enemy and never its sprite. The enemy asks for its first clip in its `Create` event, as described under Enemies below.

### What `presentation_update` does

It reads `presentation_facts` and compares `state` with `presentation_seen`. The step in which they differ is the entering step.

1. If the state did not change and the row has no `follow` list, it returns at once.
2. On entering, it stores the state, looks for the first row whose `state` equals it, and keeps the row and its `follow` list in `presentation_row` and `presentation_follow`. A state with no row leaves both undefined and nothing is chosen, so the last clip keeps playing.
3. On entering, it runs each selector of the row's `entry` list, calling it as `select(facts, params)`.
4. Every step, including the entering step, it runs each selector of the `follow` list in order, calling it as `react(facts, params, entering)`.

Calling the selectors through a variable keeps the instance as `self`, so a selector reads `x`, `y` and `presentation_marks` of the instance that runs it. A selector in an `entry` list, or one reached through `then`, receives two arguments, so its third parameter is undefined there.

## Parts

| Part | Where | Responsibility |
| --- | --- | --- |
| The logic | `04. Player`, `07. Enemies` | Decides, counts its durations in steps ([0007](../decisions/0007-let-the-logic-own-the-durations-that-matter-to-the-game.md)) and writes the facts once per step |
| The record of facts | `presentation_facts`, one struct per instance | What the logic writes and the presentation reads |
| The controller | `presentation_init`, `presentation_update` | Finds the row, runs `entry` and `follow`. Names no state, pose or clip |
| The selectors | `02. Selectors`, one script each | Pick a clip from the facts and call `animation_play` |
| The rows | `player_create_presentation` for the player, and the `static presentation` of each enemy | Data only: `{ state, entry, follow }` |
| The clips | `sonic_create_animations` for a character, the `static clips` of an enemy | Built once and shared by every instance ([0008](../decisions/0008-build-the-animations-once-and-share-them.md)) |
| The fallbacks | `player_define_fallbacks`, `player_resolve_clips` | Give a character without a clip the clip that its chain leads to |
| The transitions | `sonic_init_transitions` | Pairs `from, to, via` registered once ([0005](../decisions/0005-use-one-mechanism-for-transitions.md)) |
| The adapter | `animation_*` | The only calls to Resnip |
| The speed owner | `game_set_step_rate` | Sets the game speed and the clock scale together |

### Variables of an instance

| Variable | Written by | Read by |
| --- | --- | --- |
| `state` | The logic, through `player_set_state` for the player and by assignment for an enemy | `player_publish_facts`, `enemy_update_animation`, the replay line |
| `presentation_facts` | `presentation_init` creates it, `player_publish_facts` writes it, `enemy_update_animation` writes only `state` | `presentation_update` and the selectors |
| `presentation_set` | `presentation_init`, and `sonic_init_animations` replaces the empty set of the player | `presentation_update` |
| `presentation_seen` | `presentation_update`, undefined until the first update | `presentation_update` |
| `presentation_row`, `presentation_follow` | `presentation_update` on the entering step | `presentation_update` |
| `presentation_marks` | `selector_on_count` and `selector_on_change`, keyed by the name of a fact | The same two selectors |
| `animation` | `animation_init` sets `noone`, `animation_play` sets the clip last requested | `animation_is_playing`, and `obj_jumpball`, which ends when `owner.animation` is not its `hook` |
| `__animation_playback` | `animation_init` | `animation_update`, `animation_play`, `animation_is_playing`, `animation_debug_draw` |
| `sprite_index`, `image_index` | `animation_update`, through `resnip_instance_sync` | The draw events and the replay line |

`obj_player` calls `presentation_init` with an empty set in its `Create` event, and the character calls `animation_init` and gives its set. A player object with no character has no `__animation_playback` for `animation_update` to step.

## The facts

The initial record is in `Create_0` of `obj_player`, and `player_publish_facts` writes the same eleven fields.

| Fact | Source variable | Written by | Cleared by |
| --- | --- | --- | --- |
| `state` | `state` | `player_set_state` | Replaced by the next state |
| `ledge` | `cliff_dir * dir` | `player_update_cliff` sets `cliff_dir` | Recomputed |
| `speed` | `abs(hor_speed)` | The movement, after the clamp | Recomputed |
| `rotation` | `rotation` | `player_update_rotation` | Recomputed |
| `rolling` | `is_rolling` | The start of `jump`, `roll`, `spindash`, `dashpanel` and the curl up in `airbone` | The start of `idle`, `run`, `hurt`, `death`, `lock`, `debug`, and the spring reaction |
| `rising` | `is_rising` | An upward spring in `player_reaction_spring` | The apex, the curl up and `STOP` in `airbone`, and the monitor reaction |
| `pushing` | `is_pushing` | `player_wall_push` | The start of `run`, and `run` when the direction pressed differs from the facing |
| `braking_turn` | `is_braking_turn` | The start of `turn`, true when the previous state was `skid` | Set again at each `turn` |
| `spindash_revs` | `spindash_revs` | `spindash`, by one at each rev | Never, it only grows |
| `curl_ups` | `curl_ups` | `airbone` at the curl up, and `sonic_routine_homing` | Never, it only grows |
| `monitor_bounces` | `monitor_bounces` | `player_reaction_monitor` | Never, it only grows |

A flag is a variable of the logic with a clearing rule: it ends when anything else takes its place, as [0006](../decisions/0006-replace-a-read-of-the-animation-by-explicit-state.md) states. A counter only grows, and a selector compares it with the last value it saw. An enemy publishes only `state`, whose values are the members of its own enum: `motobug_states` has `move` and `turn`, `buzzer_states` has `fly`, `turn` and `attack`, `balloon_states` has `idle` and `attack`, `newtron_states` has `wait`, `fade_in`, `attack` and `fade_out`, and `chopper_states` has `fly`.

## The selectors

Each is one script of one function. `facts` is the record, `params` is the table it is given in the row, and `entering` is true on the step the state started.

| Selector | Parameters | What it does |
| --- | --- | --- |
| `selector_direct` | `clip` | Plays the clip |
| `selector_by_fact` | `fact`, `cases: [{ value, clip }]` | Plays the clip of the first case whose `value` equals the fact. Plays nothing when none matches |
| `selector_by_band` | `fact`, `cases: [{ from, clip }]` | Plays the clip of the first case whose `from` the fact reaches with `>=`, so order the cases from the highest limit down |
| `selector_ladder` | `fact`, optional `unless`, `bands: [{ from or above, clip, pace }]` | Does nothing on the entering step or while the fact named by `unless` is true. Otherwise plays the first band the value reaches, with `>=` for `from` and `>` for `above`. The `pace` has an optional `map: [a, b, c, d]` that maps the value from the range `a, b` to `c, d`, and an optional `limit: [low, high]` that clamps the rate. With neither, the rate is the value itself |
| `selector_start` | `clip`, `fact`, `pace: { map }`, optional `effect: { object, sprite }` | Does nothing when the clip already plays. Plays it at the mapped pace, and creates the effect with `vfx_create` at `x, y`, with the angle `facts.rotation` and the clip as its `hook`. `vfx_create` makes none while one of that object exists |
| `selector_while_fact` | `fact`, `clip` | Plays the clip on every step the fact is true |
| `selector_on_count` | `fact`, `then` | When the value differs from its mark and the step is not the entering one, runs the selector in `then`. Always stores the mark |
| `selector_on_change` | `fact`, `cases: [{ to, then }]` | When the value differs from its mark and the step is not the entering one, runs the `then` of the first case whose `to` equals the value. Always stores the mark |

`entering` has one effect on every selector that takes it: it stops the reaction from firing on the step the state starts, and the mark is still stored, so a change that happened before the state started is not replayed. A selector that plays a clip in `follow` repeats the request every step, which `animation_play` accepts because it does nothing when the clip already plays.

The order of `follow` is the order the selectors run, and a later one that calls `animation_play` wins over an earlier one in the same step. The row of `run` relies on it: the ladder runs first and `selector_while_fact` of `pushing` runs after, so the push clip wins while `pushing` holds, and the ladder gives way with `unless: "pushing"`.

## The rows of the player

`player_create_presentation(clips, effects)` returns `{ rows }`. It has 16 rows, one for each state of `01. Base/02. States` except `player_state_debug`, `player_state_init` and `player_state_lock`. In this table a selector is written without its `selector_` prefix. The shared parts are `jump_pose`, a `selector_start` of `roll_jump`, `curl_up`, an `on_count` of `curl_ups` that runs `jump_pose`, and `fall_slow`, an `on_count` of `monitor_bounces` that plays `fall_slow`.

| State | `entry` | `follow` |
| --- | --- | --- |
| `player_state_idle` | `by_fact ledge`: 0 `idle`, 1 `balance_front`, -1 `balance_back` | none |
| `player_state_crouch`, `player_state_lookup`, `player_state_dashpanel`, `player_state_knockout` | `direct` of `crouch`, `lookup`, `dashpanel`, `knockout` | none |
| `player_state_hurt`, `player_state_death` | `direct hurt` | none |
| `player_state_airbone` | `by_fact rolling` false gives `fall_fast`, then `while_fact rising` gives `rise` | `on_change rising`, true gives `rise` and false gives `fall`, then `curl_up`, then `fall_slow` |
| `player_state_homing` | `jump_pose` | none |
| `player_state_jump` | `jump_pose` | `curl_up` |
| `player_state_launch` | `direct launch` | `fall_slow` |
| `player_state_turn` | `by_fact braking_turn`: true `skid_turn`, false `turn` | none |
| `player_state_skid` | `by_band speed`: from 6 `skid_fast`, from 0 `skid_slow` | none |
| `player_state_roll` | none | `ladder speed`: above 5 `roll_fast` with the pace mapped from 5 to 12 into 1.25 to 2.25, from 0 `roll_slow` with the pace limited to 1 to 1.5 |
| `player_state_run` | none | `ladder speed` with `unless: "pushing"`: from 6 `sprint`, from 4.5 `run`, from 3 `jog`, from 1.5 `walk`, above 0 `stroll`, then `while_fact pushing` gives `push` |
| `player_state_spindash` | `direct spindash` | `on_count spindash_revs` gives `spindash_charge` |

In `airbone`, a state entered while rolling plays no clip on entry, so the jump ball keeps playing.

## Clips, fallbacks and transitions

A character builds a struct `clips` with `animation_create`. `sonic_create_animations` makes 45 clips. A clip made with `next` leads into another, and the `next` clip is created first. `player_resolve_clips` fills every key of the table of `player_define_fallbacks`, 27 keys, that the character lacks, with the first clip its chain leads to, and prints a `[WARN]` for each. Every chain ends at `idle`. `idle` is not a key of the table, so a character without it prints an `[ERROR]` only when another missing clip chains to it.

A transition is a triple `from, to, via`: when `to` is requested while `from` plays, `via` plays first. `sonic_init_transitions` registers 26 of them once, guarded by a `static`. A character with no transitions registers none. The entrance and exit behaviour is in [reference/resnip.md](../reference/resnip.md#what-plays-next).

## Enemies

An enemy has an enum of states, a script `<enemy>_init_animations` and a child object of `obj_enemy`. The function holds a `static clips` and a `static presentation` of rows such as `{ state: motobug_states.move, entry: [{ run: selector_direct, clip: clips.attack }] }`, then runs `animation_init`, `presentation_init(presentation, { state: state })` and `presentation_update`. Its `Create` event calls `event_inherited`, sets `state`, and calls `<enemy>_init_animations` after it, because the first record copies `state`. The rows of the five enemies use only `selector_direct` and have no `follow` list. The durations of their states are counters in steps that the logic owns.

## Interfaces

| Function | Meaning |
| --- | --- |
| `animation_create(_sprite, _options={})` | Makes a clip. The options are `speed` (`ANIMATION_DEFAULT_SPEED`, 1), `first_image` (0), `last_image` (the whole sprite), `reversed` (false) and `next`, a clip. A clip leads into `next` with `ANIMATION_USE_TRANSITIONS`, true |
| `animation_init()` | Sets `animation` to `noone` and creates `__animation_playback` |
| `animation_update()` | Steps the playback and copies its frame to `sprite_index` and `image_index`. Inlined |
| `animation_play(_animation, _speed=ANIMATION_DEFAULT_SPEED)` | Sets `animation`, sets the speed of the playback and plays the clip with `restart: false`, so a clip that already plays is not restarted. Inlined |
| `animation_add_transition(_from, _to, _via)` | Registers a transition |
| `animation_is_playing(_animation)` | True when `animation` is that clip or the playback now plays its snip. Inlined |
| `animation_set_time_scale(_scale)` | Scales the default clock of Resnip. Only `game_set_step_rate` calls it |
| `animation_debug_draw(_x, _y)` | Draws the sub-images of the sprite with the current frame marked |
| `game_set_step_rate(_rate)` | Calls `game_set_speed(_rate, gamespeed_fps)` and scales the clock by `_rate / MAX_FPS`. `framework_start` calls it with `MAX_FPS`, and `game_reduce_power` with `MAX_FPS` on focus and 20 off focus. Nothing else sets the game speed ([0007](../decisions/0007-let-the-logic-own-the-durations-that-matter-to-the-game.md)) |
| `presentation_init(_set, _facts)` | Stores the set and the record, and clears the marks, the row and the follow list |
| `presentation_update()` | The controller above |
| `player_publish_facts()`, `player_update_animation()`, `enemy_update_animation()` | The calls of the step above. The first two are inlined |
| `player_create_presentation(clips, effects)`, `player_define_fallbacks()`, `player_resolve_clips(_clips)` | The rows, the fallback table, and the fill of missing clips |

All the clips of the project come from sprites of one playback speed type, so `animation_set_time_scale` moves them together. A sprite of the other type would not follow the game speed, as [reference/resnip.md](../reference/resnip.md#the-rate-of-a-frame) states.

## Invariants

- Outside a `Presentation` folder and the adapter, no code calls `animation_*`, reads `animation`, names an `anim_*` identifier or reads a source of time (`current_time`, `delta_time`, `fps`, `fps_real`, `game_get_speed`, `get_timer`, `room_speed`) outside `Bootstrap`, `Display`, `Tooling` and `Vendor`. The check `zones` detects it, with the uses of the debug manager and the rings frozen in `tools/zones_baseline.txt`.
- The scripts of `03. Presentation` name nothing that belongs to a character, an enemy or the art. The check `names` detects it.
- Each selector script holds one function named like the script, starting with `selector_`, with at most 6 branches. `selector_ladder` has exactly 6. The check `selectors` detects it.
- Every player state except `debug`, `init` and `lock` has a row, every row names a state, every clip a shared row uses has a fallback, no fallback chain loops or misses `idle`, every character that builds clips defines `idle`, and every sprite of an `animation_create` exists. The check `clips` detects it.
- No file outside a character names what is inside one, except four uses in two files of the roster. The check `characters` detects it.
- Every resource declares a folder that the project file declares. The check `folders` detects it.
- The facts are written after the state, the clamp, the grid and the rotation, and the enemy advances before it chooses. Held by attention alone, and by [0012](../decisions/0012-keep-the-enemy-animation-one-step-behind-its-state.md).
- A fact named in a row, in `fact:` or `unless:`, is a field of the record. Held by attention alone, because a missing field reads as undefined and no error appears.
- A fact is written to the initial record of its instance, to its publish function and to a selector in the same change. Held by attention alone.
- `presentation_set` is replaced only before the first `presentation_update`. Held by attention alone.
- A selector reached through `entry` or `then` does not use `entering`. Held by attention alone.

## Change map

`python tools/gm.py check` is the command of every row, and it is run first. The replay column means the scenarios of [replay.md](./replay.md), compared with the original code.

| To | Edit, in this order | Confirm with |
| --- | --- | --- |
| Add a clip for an existing selector | The clip in `sonic_create_animations`, with its `next` created first. A key in `player_define_fallbacks` when a shared row uses it. The case or band in the row of `player_create_presentation`. A pair in `sonic_init_transitions` when it needs an entrance or an exit | `check` for the fallback, the `idle` and the sprite. A replay that reaches the state |
| Add a state | The script `player_state_<name>` in `04. Player/01. Base/02. States`, which sets and clears its flags. The row in `player_create_presentation`. A fallback if the row uses a new key | `check` for the missing row. A replay that reaches the state |
| Add a fact | The variable in the logic, with its clearing rule. The field in the initial record of `obj_player` and in `player_publish_facts`. The selector parameters that read it, in the same change. For an enemy, a line in `enemy_update_animation` and the field in its initial record | A replay, because no check reads the names in the rows |
| Add a selector | A script `selector_<name>` in `02. Selectors`, one function, up to 6 branches, which calls `animation_play` and names nothing outside Core. Its row in the table of this document | `check` for the name, the count and the branches. A replay that runs a row that uses it |
| Add a character | A folder `04. Player/NN. <Name>` with `Logic`, `Sprites`, `Audio` and `Presentation`. In `Presentation`, `<character>_create_animations` with an `idle`, `<character>_create_presentation` that calls `player_create_presentation` and adds rows for its own states, `<character>_init_animations` with the statics, `animation_init`, `presentation_set` and the transitions. An object that inherits `obj_player`. The roster in `_setup_globals` and `game_reset_player` | `check` for the clips and the character rule. A replay with that character |
| Add an enemy | A folder `07. Enemies/NN. <Name>` with `Logic`, `Sprites` and `Presentation`. An enum `<enemy>_states` in its `_setup_enums` script. An object that inherits `obj_enemy`, whose `Create` sets `state` and then calls `<enemy>_init_animations`. The function with its clips and rows. Its durations as parameters in steps | `check` for the sprites and the folders. The `enemies` replay, because no check reads enemy rows |
| Remove a clip | Its rows, its key in the fallback table and every key that falls back to it, its transitions, then the clip | `check` for a fallback that misses `idle` or a clip with no fallback |
| Remove a state | Its row, then its script | `check` for a row of a state that does not exist |
| Remove a fact | The selectors that read it, the publish line, the initial record, then the variable | A replay |
| Remove a selector | Every row that uses it, then the script | A replay that reaches those rows |
| Remove a character or an enemy | Its folder, its object, its roster lines or its enum | `check` for the character rule |
| Rename a clip | The key in `sonic_create_animations`, in `player_define_fallbacks` as a key and as a value, and in each `clips.<key>` of the rows | `check`, which reads `clips.<key>` and the fallback table |
| Rename a state | The script and its row, which compare by identity | `check` |
| Rename a fact | The variable, the initial record, the publish line and every `fact:` and `unless:` string in the rows | A replay, because the strings are not checked |
| Change a band, a pace or a case | The values in the row | A replay that runs the state, compared by picture lines |
| Change a duration | The parameter of the logic, never the clip ([0007](../decisions/0007-let-the-logic-own-the-durations-that-matter-to-the-game.md)) | The replay at the original rate and at another rate |
| Change the order of calls in a step | Do not, without a ruling ([0012](../decisions/0012-keep-the-enemy-animation-one-step-behind-its-state.md)) | Every scenario against the original code |

## What the checks watch

`python tools/gm.py check` runs the library boundary and then these. Their code is in `tools/commands/zones.py` and `tools/commands/fitness.py`.

| Check | Detects |
| --- | --- |
| `zones` | A request, a read, an `anim_*` name or a source of time outside the presentation and the adapter, with a count that may only go down in the baseline file |
| `names` | A name of a character, an enemy or the art in the shared presentation |
| `selectors` | A selector script with more than one function, a wrong name or more than 6 branches |
| `folders` | A resource whose folder the project file does not declare |
| `characters` | A file that names what is inside a character, with the roster frozen |
| `clips` | A state with no row, a row of a missing state, a clip with no fallback, a fallback that does not reach `idle`, a character with no `idle`, a missing sprite |

No check detects the order of the calls in a step, a wrong or missing fact name in a row, a row of an enemy, a selector that is called with the wrong arguments, a clip created before its `next`, or a counter that is reset. Only a replay shows them.

## Cost and limits

The cost is measured in [0010](../decisions/0010-accept-the-cost-of-the-generic-presentation.md) against the budgets of [reference/frame-budget.md](../reference/frame-budget.md), by the method of [0011](../decisions/0011-measure-a-cost-in-the-real-step-against-a-rebuild.md), and the cost of GML operations is in [reference/gml-performance.md](../reference/gml-performance.md). Nothing here repeats those numbers.

## Risks and gaps

- Fact names are strings in the rows, so a typo changes nothing visibly and no check finds it.
- The rows of enemies are not checked by `clips`, which reads only `player_state_` rows.
- `selector_ladder` is at the limit of branches, so any new branch needs a split.
- The roster of characters is named in `_setup_globals` and `game_reset_player`, which the baseline freezes.
- The cost of a repeated request to Resnip is reported as item 10 of [PENDING.md](../PENDING.md).
