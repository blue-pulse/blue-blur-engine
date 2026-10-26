# Resnip

## About this document

This document describes Resnip, a GameMaker library that plays sprite animations from a fixed definition and a separate playback state. It is for a maintainer who has never seen the library and needs to understand, predict or repair code that depends on it without opening the upstream repository. It covers the version and licence, the model of snips, playbacks and clocks, the step algorithm, what plays next, the published API with its real defaults, every error a caller can see, the measured cost, and the behaviour that surprises callers. It leaves out how any project uses Resnip, why a project would choose it, and how a project works around its gaps, which belong to that project's own records. It also leaves out the internals of the debug panel and the test harness that ships with the repository. Update it when the version changes, by re-reading every cited file and line against the new tag.

Each behaviour claim carries one of two marks. `(contract)` means the JSDoc of the public function or the README promises it, so a caller may rely on it. `(impl)` means it is only how this version behaves, read from the source, so never build on it. Each claim also says how it was established: read from the source, pinned by a test of the upstream suite, or measured. Line numbers in `file:line` citations belong to tag `v0.2.0`. Last checked against that tag on 2026-10-25.

## Version, licence and provenance

- Upstream: `https://github.com/blue-pulse/resnip`.
- Version documented: 0.2.0, tag `v0.2.0`, commit `cee1a2a` (2026-10-19). The version is read from `scripts/resnip_constants/resnip_constants.gml:2` (`RESNIP_VERSION "0.2.0"`) and `:3` (`RESNIP_DATE "2026-10-19"`).
- The version string does not identify one build. Commits from `87cf5e6` to the commit before `4229a81` also carry `0.2.0` and `2026-10-19`. Their library logic is the same, but the public constants live in a script named `__resnip_constants` and the demo sprites lack the `spr_` prefix. A copy that has a script named `resnip_constants` matches the tag.
- `main` at `45a09be` has the same code as the tag. Only the README, `LICENSE`, `NOTICE.md` and the documentation differ.
- Licence: MIT. The `LICENSE` file at the tag reads "Copyright (c) 2025 William Jones", inherited from the repository it was forked from. On `main` after the tag it reads "Copyright (c) 2026 Blue Pulse", and `NOTICE.md` credits AESnips 0.1.4 (MIT, William Jones) and states that the demo sprites are his, under the same licence. The file in the copy you hold governs.
- Lineage: the repository is a git fork of AESnips (`https://github.com/angelwire/AESnips`), and its history holds the AESnips commits. A line by line comparison of the library code with the AESnips 0.1.4 source, on lines of 30 characters or more, found 4 matches, all generic declarations in `resnip_debug_draw` (`var _width = sprite_get_width(_sprite);` and the like). The demo shares a script, explanation texts and one line of an object with the AESnips demo.
- Runtime dependencies: none. It uses only built-in GameMaker functions.
- Platforms: the README asks for GameMaker LTS 2026 or later. The upstream suite was run on Windows 11 with runtime 2026.0.0.23, on the VM and on YYC. HTML5 and other targets were not run.
- Distribution: the README links a local package, `resnip.yymps`, from the latest GitHub release. Whether a release with that asset exists for `v0.2.0` was not checked.
- Global names: public functions start with `resnip_`, public macros and enums with `RESNIP_`, internal ones with `__resnip_` and `__RESNIP_`. Private fields of the structs start with `__`.

## What it is

Resnip replaces the built-in advance of `image_index` by `image_speed`. A game describes an animation once, as a snip, and plays it on any number of playbacks, each owning its own state. Over the built-in mechanism it adds per-frame speeds, loops with a repeat count, frame and completion callbacks that run for every frame crossed, transitions between animations, a queue, a successor, backward play, shared pause and time scale, the frame durations of the sprite editor, and starting on any frame. It has no instance mode: an instance copies the state of a playback when it needs `sprite_index` and `image_index` (`(contract)`, `resnip_instance_sync`).

| Term | Meaning |
| --- | --- |
| Sub-image | One image of a GameMaker sprite, counted from 0 in the sprite |
| Snip | An immutable definition: sprite, a range of sub-images, speeds, loops, scripts, end mode, completion rule and successor |
| Frame | One image of a snip, counted from 0 at its first sub-image. Loops, frame speeds and frame scripts use frames, never sub-images |
| Playback | A mutable struct holding the state of one animation: the snip, the frame, the direction, the progress inside the frame and what plays next |
| Clock | A struct with `paused` and `scale`, shared by the playbacks that follow it |
| Loop | A run of frames of a snip that plays once and then repeats a count of times. A count below 0 skips it |
| Transition | A snip registered to play between two others, found by the pair (from, to) |
| Step | One game step, the unit of `resnip_step` |
| Gamespeed | `game_get_speed(gamespeed_fps)`, the steps per second the game is set to, not the measured rate |
| VM, YYC | The two GameMaker compilers: bytecode, and C++ compiled to native code |

## The core model

### Objects and ownership

- A snip is plain data, fixed after creation, and safe to share between any number of playbacks (`(contract)`, JSDoc of `resnip_snip_create`). Pinned by the tests `playing never changes the snip` and `playbacks on one snip do not affect each other`, 200 seeded cases each. The only allowed change is `resnip_snip_set_next`, during setup (`(contract)`).
- A playback holds all the state of one animation. Its public fields are `clock`, `snip`, `frame`, `direction`, `speed`, `paused` and `stopped`. A caller may read them, may write `paused`, and may write `direction` as 1 or -1. Every other field is private (`(contract)`, JSDoc of `resnip_playback_create`). A playback has 17 fields (`(impl)`, read).
- Per-playback overrides change one playback and never the snip: `resnip_set_loop_repeats`, `resnip_set_frame_speed` and `resnip_set_speed` (`(contract)`). A loop count override survives `resnip_play`. A frame speed override lasts while the playback plays the same snip, and playing another snip drops it (`(impl)`, pinned by `restarting the same snip keeps the frame speeds of a playback` and `playing another snip drops the frame speeds of a playback`).
- Library state lives in one struct behind `__resnip_system()`: the default clock, the transition registry and an id counter (`(impl)`, read). Nothing is added to an instance (`(contract)`, README).

### The rate of a frame

```
rate = frame speed / duration * snip speed * sprite speed * playback speed * clock scale  [/ gamespeed]
```

The rate is in frames per step. The division by the gamespeed applies only when the sprite runs in frames per second (`(impl)`, `resnip_step.gml:18`). For a sprite in frames per game frame the gamespeed has no effect, so a change of gamespeed changes the real-time pace and not the per-step pace, the same as a sprite in GameMaker (`(impl)`, read, pinned for a fixed gamespeed by `a sprite in frames per game frame ignores the gamespeed`). The duration term is 1 unless the snip asks for `sprite_durations`. The snip stores `snip speed * sprite speed` and whether the sprite runs in frames per second at creation (`(impl)`, read), and the gamespeed is read at every step, so a change applies at once (`(impl)`, pinned by `a gamespeed set during play changes the pace of a sprite in frames per second`).

### One step

`resnip_step(playback, [steps])` spends `steps` (default 1, a fraction for delta time) frame by frame (`(contract)`):

1. Return at once if the playback has no snip, is stopped, is paused or its clock is paused (`resnip_step.gml:7`).
2. Compute the rate of the current frame. A rate of 0 or below ends the step and spends no time, so a speed of 0 holds a frame.
3. If the remaining time does not finish the frame, add it to the progress inside the frame and return.
4. Otherwise spend `(1 - progress) / rate`, set the progress to 0 and move one frame in the playback direction. A move inside a loop that is not at its edge, or to a frame with no loop to enter or skip, is made inline. Every other move handles the loop edge and the end of the snip.
5. Run the script of the frame entered. After a script or a move at an edge, return if the playback was stopped or paused, and reread the snip, since a callback may have played another (`resnip_step.gml:57`).
6. Repeat with the speed of the new frame until the time is spent. Edge comparisons tolerate `1e-6` (`__RESNIP_EPSILON`).

The frame is an integer and the progress a fraction in [0, 1), so there is no float drift: a snip at speed 0.1 reaches frame 4 after 40 steps (`(impl)`, pinned by `no drift before the tenth step of a frame` and `no drift on the tenth step of a frame`). Two steps give the same result as one step of their sum (`(impl)`, pinned by a property over 200 seeded cases). The time left at the end of a frame passes to the next frame and to the next snip (`(impl)`).

### Scripts

Every callback is called as `callback(argument, playback)`, for frame scripts and the completion script (`(contract)`). A frame script runs once for every frame the playback enters, on the step the frame appears, including every frame crossed by a large step and the first frame of a snip, which runs inside `resnip_play` or inside the step that started the snip (`(contract)` for "every frame entered", JSDoc of `resnip_step`; the rest `(impl)`, pinned by `the frames a large step crosses run their scripts in order`, `the script of the last frame runs when it is entered` and `the script of the start frame runs when the snip starts`). One script is allowed per frame. The callback runs with the `self` it was created with (`(impl)`). A callback may stop, pause, change speed or play another snip, and the step honours that at once (`(impl)`, pinned by the suite `callbacks`). When a callback pauses the playback, the time left in that step is dropped (`(impl)`).

### End of a snip

The snip ends when a move leaves its range. The order is (`(impl)`, read):

1. Decide whether the snip completes. It always does, except PINGPONG with `complete_on` HEAD, which completes only when it reaches the first frame going backward, and TAIL, which completes only when it reaches the last frame going forward.
2. If it completes, run the completion script. If the script started another snip, stop here.
3. If it completes, play what plays next (below), if anything, and stop here.
4. Apply the end mode.

| End mode | At the end |
| --- | --- |
| `RESNIP_END.HOLD` | Stays on the frame it ended on (last forward, first backward) and stops |
| `RESNIP_END.REWIND` | Goes to the first frame and stops |
| `RESNIP_END.FASTFORWARD` | Goes to the last frame and stops |
| `RESNIP_END.REPEAT` | Starts again at the first frame forward or the last backward. The default |
| `RESNIP_END.PINGPONG` | Turns around without repeating the edge frame |

`complete_on` defaults to `RESNIP_COMPLETE.EDGE` and applies only to PINGPONG. A snip of one frame completes every step in REPEAT and in PINGPONG with EDGE (`(impl)`).

### What plays next

When a snip completes, the first of these that exists plays (`(contract)`, JSDoc of `resnip_play`):

1. The snip queued by `resnip_play` with `queue: true`, with its own `transition` and `backward`.
2. The target of the running transition, in the direction asked for it.
3. The `next` of the snip, with `transition` true and `backward` false unless set.

A transition snip plays in the direction of its registry entry, and its own `next` is ignored while it runs as a transition (`(impl)`). A queued snip asked with a transition continues from the target of the running transition, so the target never plays (`(impl)`, pinned by `a queued snip asked with a transition continues from the target of the running transition`).

### Loops

A loop holds frames `first` to `last` inclusive and plays `repeats + 1` times (`(contract)`, JSDoc of `resnip_snip_create`). A count below 0 skips it, by jumping past it the first time the playback reaches it. A loop count change applies the next time the playback enters the loop or reaches its edge (`(contract)`, JSDoc of `resnip_set_loop_repeats`). When loops with a count below 0 cover every frame, the playback holds its last frame forward or its first backward, stops, and prints a `[WARNING]` (`(impl)`, pinned by `a repeating snip whose every frame is skipped holds on its last frame`).

### A minimal example

```js
// Create event
walk = resnip_snip_create(spr_walk);
playback = resnip_playback_create();
resnip_play(playback, walk);

// Step event
resnip_step(playback);
resnip_instance_sync(playback);   // only if the instance needs sprite_index, image_index or its mask

// Draw event
resnip_draw(playback, x, y);       // or draw_self() after resnip_instance_sync
```

This is the README example.

## Status and health

A playback reports `snip`, `frame`, `direction`, `speed`, `paused` and `stopped` as fields, and `resnip_play` returns whether it started or queued the snip (`(contract)`). `resnip_transition_find` reports a registered transition. `resnip_debug_draw(playback, x, y)` draws every sub-image with the current frame lifted, its progress as a bar, a dot under frames with a script, and a bracket per loop, aqua when it repeats, green while played, yellow when it plays once and red when skipped (`(contract)`).

The library does not report the progress inside a frame, the snip queued, the target of a transition, the pass count of a loop, whether the last step completed a snip, or the contents of the transition registry. Those live in private fields (`(contract)`: do not read them).

## Every failure a caller can see

Errors are thrown as strings that start with `[ERROR] `, raised by `__resnip_error` (`__resnip_error.gml`). Each message names the function, the value received and what to pass instead (`(impl)`, read).

| Error | Raised by | State after |
| --- | --- | --- |
| Sprite that does not exist | `resnip_snip_create` | No snip is created |
| `first_image` or `last_image` outside the sprite | `resnip_snip_create` | No snip is created |
| Snip speed below 0 | `resnip_snip_create` | No snip is created |
| `end_mode` not a value of `RESNIP_END` | `resnip_snip_create` | No snip is created |
| `complete_on` not a value of `RESNIP_COMPLETE` | `resnip_snip_create` | No snip is created |
| `on_complete` that cannot be called | `resnip_snip_create` | No snip is created |
| `next` that is not a struct, or `next_options` that are not a struct | `resnip_snip_create` | No snip is created |
| `sprite_durations` not a bool | `resnip_snip_create` | No snip is created |
| A frame script that cannot be called, or two scripts on one frame | `resnip_snip_create` | No snip is created |
| A frame speed below 0 | `resnip_snip_create` | No snip is created |
| A loop whose first frame comes after its last, or whose `repeats` is not whole | `resnip_snip_create` | No snip is created |
| `next` that is not a struct, or options that are not a struct | `resnip_snip_set_next` | The snip is unchanged, since the checks run before the writes |
| A frame outside `[0, count - 1]` or not whole | `resnip_play_from`, `resnip_set_frame_speed` | Not checked |
| A playback that plays no snip, or a speed below 0 | `resnip_set_frame_speed` | Not checked |
| A count that is not whole | `resnip_set_loop_repeats` | Not checked |
| A speed below 0 | `resnip_set_speed` | Not checked |
| A scale below 0 | `resnip_clock_set_scale` | Not checked |

"Not checked" means the order of the validation and the writes was not read. Warnings go to the debug output and do not throw:

| Warning | When |
| --- | --- |
| A playback holds its last frame because loops with a count below 0 skip every frame of its snip | Loops skip every frame. The playback stops |
| A sprite gives a sub-image a duration that is not a number above 0 | Only with `sprite_durations`. The frame plays with a duration of 1. Not observed in practice |

An exception thrown by a user callback propagates out of `resnip_step` or `resnip_play`, with the playback partly advanced. No upstream test covers it (`(impl)`, read).

`resnip_play`, `resnip_step` and `resnip_stop` do not validate that the playback or the snip is a struct of the right kind (`(impl)`, read). The drawing functions were not read for this.

## The published API

Signatures transcribed from the source at the tag, with the real defaults. A parameter in brackets is optional. Where the signature has no default and the function reads the value inside (`?? value`), the default is given in the right column.

### Snips

| Signature | Notes |
| --- | --- |
| `resnip_snip_create(sprite, options = {})` | Options: `first_image`, `last_image` (sub-images, default the whole sprite), `speed` (0 or above, default 1), `frame_speeds` (array of `{frame, speed}`), `sprite_durations` (bool, default false), `frame_scripts` (array of `{frame, callback, argument}`), `loops` (array of `{first, last, repeats}`), `end_mode` (default REPEAT), `complete_on` (default EDGE), `on_complete`, `on_complete_argument`, `next`, `next_options` (`{transition, backward}`). Returns the snip |
| `resnip_snip_clone(snip, overrides = {})` | A new snip from the options of another, with some replaced, including `sprite`. Loops get new identities, so loop overrides of a playback do not apply to the clone. Transitions are not copied |
| `resnip_snip_set_next(snip, next, options = {})` | Options `transition` (default true) and `backward` (default false). `next` may be `undefined`. Setup only (`(contract)`) |

### Playbacks

| Signature | Notes |
| --- | --- |
| `resnip_playback_create([clock])` | Default clock: `resnip_clock_default()` |
| `resnip_play(playback, snip, [options])` | Options `transition` (false), `queue` (false), `restart` (true), `backward` (false). Returns true when it started or queued the snip, false when `restart: false` found the snip already playing or already the target of a transition |
| `resnip_play_from(playback, snip, frame, [backward])` | `backward` defaults to false. Starts on `frame` at progress 0, enters it, looks for no transition and queues nothing. Drops a queued snip and the target of a transition. Returns true |
| `resnip_step(playback, [steps])` | `steps` defaults to 1. For delta time pass `delta_time / 1000000 * game_get_speed(gamespeed_fps)` |
| `resnip_stop(playback, where = RESNIP_STOP.HERE)` | `RESNIP_STOP.HERE`, `HEAD` or `TAIL`. Sets `stopped` and forgets the target of a transition. Does nothing without a snip |
| `resnip_cancel_next(playback)` | Drops the queued snip. The target of a running transition stays |
| `resnip_set_speed(playback, speed)` | 0 or above |
| `resnip_set_loop_repeats(playback, loop, repeats)` | `loop` is a struct read from `snip.loops`. `undefined` brings back the value of the loop |
| `resnip_set_frame_speed(playback, frame, speed)` | 0 or above, or `undefined` for the value of the snip. With `sprite_durations` it multiplies the duration |

### Clocks

| Signature | Notes |
| --- | --- |
| `resnip_clock_create()` | Returns `{paused, scale}`. Set `paused` directly |
| `resnip_clock_default()` | The clock of playbacks made without one |
| `resnip_clock_set_scale(clock, scale)` | 0 or above. 0 stops every playback of the clock |

### Transitions

| Signature | Notes |
| --- | --- |
| `resnip_transition_add(from, to, use, backward = false)` | A second call for the same pair replaces the first. Returns `{from, to, use, backward}` |
| `resnip_transition_find(from, to)` | The transition, or `undefined` |
| `resnip_transition_remove(from, to)` | Does nothing if there is none |

### Conversion, instances and drawing

| Signature | Notes |
| --- | --- |
| `resnip_frame_to_image(snip, frame)` | `snip.first_image + frame` |
| `resnip_image_to_frame(snip, image)` | The inverse |
| `resnip_instance_sync(playback)` | Sets `sprite_index`, `image_index` and `image_speed = 0` on the calling instance. Call it in the Step event after `resnip_step` |
| `resnip_draw(playback, x, y)` | Like `draw_sprite`. Draws nothing without a snip |
| `resnip_draw_ext(playback, x, y, xscale, yscale, rot, col, alpha)` | Like `draw_sprite_ext` |
| `resnip_debug_draw(playback, x, y)` | The debug panel. A separate module that a build may leave out |

### Constants

`RESNIP_VERSION`, `RESNIP_DATE`, `RESNIP_FORWARD` (1), `RESNIP_BACKWARD` (-1), and the enums `RESNIP_END` (HOLD, REWIND, FASTFORWARD, REPEAT, PINGPONG), `RESNIP_COMPLETE` (EDGE, HEAD, TAIL) and `RESNIP_STOP` (HERE, HEAD, TAIL). The defaults are macros: `RESNIP_DEFAULT_SNIP_SPEED` 1, `RESNIP_DEFAULT_END_MODE` REPEAT, `RESNIP_DEFAULT_COMPLETE_ON` EDGE.

## Performance

Measured on one Windows 11 machine, runtime 2026.0.0.23, on 2026-10-18 and 2026-10-19, with renamed copies of Resnip and AESnips 0.1.4 in one process and their order rotated in each repetition. 5,000 playbacks of one snip of 20 frames, 10 steps of warm up and 120 measured, the median over 9 repetitions of the mean step. Two runs of the same code differ by about 4 percent, so a difference under 3 percent is noise. The harness is not in the repository, so these figures cannot be repeated from it. The benchmark is synthetic and was not run on a real scene, another machine, another runtime or HTML5.

Ratio of Resnip over AESnips, where below 1 means Resnip is faster:

| Case | VM | YYC |
| --- | --- | --- |
| A frame crossed every step | 1.00 | 0.94 |
| The same with 4 loops | 0.86 | 0.89 |
| A frame crossed every 2 steps | 0.87 | 0.85 |
| Every 4 steps | 0.80 | 0.80 |
| Every 10 steps | 0.75 | 0.75 |
| Geometric mean of these five | 0.85 | 0.85 |
| Paused | 0.22 | 0.27 |
| Create and play | 1.35 | 1.46 |

With 10,000 playbacks the geometric means were 0.88 on the VM and 0.90 on YYC.

Live memory per playback after 25 steps, read with `debug_event("DumpMemory", true).totalUsed` over 10,000 playbacks: 832 bytes on the VM and 911 on YYC with no loops, against 1,120 and 1,199 for AESnips, and 1,216 on both with 4 loops, against 1,184 and 1,263, which is a tie.

Other costs, by the same method:

- Creating a snip that does not ask for durations: about 5.4 to 5.6 µs on YYC and 10.4 to 11.0 µs on the VM, median of 24 repetitions of 2,000 snips.
- Creating a snip that asks for durations, on a sprite of 20 frames: 25.4 µs on YYC and 44.7 µs on the VM, almost all in `sprite_get_info`, which grows with the number of sub-images of the sprite.
- The gamespeed read at every step costs about 4.5 percent of the step on YYC and nothing measurable on the VM.
- Creation is slower than in AESnips because a struct costs about 45 ns per field to create, and a playback has 17 fields.

The saving over AESnips is small in absolute terms. A game with a few hundred animations will hardly notice it.

## What will bite you

In order of impact:

1. **Stopping inside a completion script does not stop what plays next.** The completion script runs, and unless it started another snip, the queue, the target of the transition or the `next` of the snip plays anyway and clears `stopped` (`(impl)`, read, `__resnip_playback_complete.gml`). To end the animation from a completion script, play the snip you want instead, or call `resnip_cancel_next` before stopping and make sure the snip has no `next`.
2. **Two snips fully skipped by their loops that name each other as `next`, or one that names itself, recurse without end.** The skip limit is reset each time a snip starts, so it never trips between snips. Read from the source and not reproduced, so it is a hypothesis. The expected result is a hang or a stack overflow.
3. **The transition registry holds its snips forever.** The registry is global and keyed by the ids of the two snips, so a snip that takes part in a transition is never collected until `resnip_transition_remove` is called for that pair. There is no function to list or clear it. Creating snips and transitions per instance needs a matching remove, such as in a Clean Up event. Snips without transitions are collected normally (`(contract)` for the retention, JSDoc of `resnip_transition_add`).
4. **Frame scripts run one step earlier than in AESnips, and run for every frame crossed.** AESnips runs a script one step after its frame appears, only for the frame where a step lands, and never for a last frame that lasts one step. Resnip runs it on the step the frame appears. Code ported from AESnips that relies on the delay will act one step early (`(contract)`).
5. **`resnip_snip_set_next` is documented as setup only and enforces nothing.** It can change a shared snip at any time, for every playback of it (`(impl)`, read). Give `next` and `next_options` to `resnip_snip_create` instead, and use `resnip_play` with `queue: true` for a change that belongs to one playback.
6. **`resnip_stop` keeps the queued snip.** It clears the target of a transition but not the queue (`(impl)`, read). The stale queue is reachable only through item 1, because a stopped playback does not step, and any later `resnip_play` or `resnip_play_from` clears the queue.
7. **`resnip_play` with `queue: true` on a stopped playback, or on one with no snip, plays at once** instead of queueing (`(impl)`, read).
8. **Options arrays are copied shallowly.** The snip keeps a shallow copy of the options it was created with, so changing an array that was passed to `resnip_snip_create` changes later clones. Read and not run.
9. **The sprite speed and speed type are read when the snip is created.** A later `sprite_set_speed` does not reach snips that already exist (`(impl)`, read).
10. **`resnip_instance_sync` with a playback that plays no snip does nothing**, and leaves `image_speed` as it was, so the instance keeps animating its own sprite (`(impl)`, read). With a stopped playback it copies the frame where the playback stopped. Backward, it copies the current frame, so the sub-images go down. It does not touch `image_xscale`. Only a forward playback is pinned by a test.

Constraints on any caller:

| # | Constraint |
| --- | --- |
| 1 | Write only `paused` and `direction` (1 or -1) on a playback. A `direction` other than 1 or -1 is not checked |
| 2 | Never write a field of a snip. Make a variation with `resnip_snip_clone` |
| 3 | Call `resnip_instance_sync` after `resnip_step`, in the Step event |
| 4 | A speed is never negative. Play backward with `backward` or `direction` |
| 5 | A snip with a frame at speed 0 never completes by itself. The game must play something else |
| 6 | Create snips once, in a Create event or behind a loading screen, above all with `sprite_durations` |

Less-used parts:

| # | Behaviour |
| --- | --- |
| 1 | `sprite_durations` is off by default. A sprite made with `sprite_duplicate` or `sprite_create_from_surface`, or whose frames all last 1, has no durations, and a snip of it plays every frame with a duration of 1, with no warning even when it asks |
| 2 | Durations are found by the `image_index` of each entry of `frame_info`, read on runtime 2026.0.0.23. The manual page of `sprite_get_info` was not read, so the format is observed and not documented |
| 3 | `resnip_play_from` leaves loops that lie wholly before the start frame with their passes at 0, so they play if the direction turns back to them |
| 4 | A character with one sprite per direction keeps its frame, progress, loops and scripts when it turns if one playback is drawn with the sprite of the direction it faces, provided the sprites share their frames and timing. Starting another snip on the same frame at each turn loses the time spent in the frame |
| 5 | `restart: false` refuses a snip that is the current one and not stopped, or that is the target of a running transition |
| 6 | Floating point: the rate multiplies in a different order from the formula above, so the last bit of the progress can differ from a hand computation. The tolerance of `1e-6` absorbs it |

### Differences from AESnips

| AESnips | Resnip |
| --- | --- |
| A loop repeats from its second frame | A loop plays its whole range on every pass |
| A frame script runs one step after its frame, only where a step lands | A frame script runs on the step its frame appears, for every frame crossed |
| A pingpong turn repeats the edge frame | It does not |
| A step that crosses frames uses the speed of the first | Each frame uses its own speed, and the rest of a step passes on |
| A direction on the snip and on the instance | A direction on the playback only |
| Pause, loop counts and frame speeds change the shared snip | They change one playback or one clock |
| Seven end types | Five end modes and three completion rules: `end_stop` is HOLD, `end_stop_head` REWIND, `end_stop_tail` FASTFORWARD, `end_repeat` REPEAT, and `end_pingpong`, `_head` and `_tail` are PINGPONG with EDGE, HEAD and TAIL |
| Snips hold `ds_list` and must be destroyed | Structs and arrays, collected normally |
| Instance mode and a standalone player | One playback type and `resnip_instance_sync` |

Of 106 scenarios run through both libraries on 2026-10-14, 30 gave the same frames and events, 14 the same frames with scripts one step earlier, and 62 differed.

## Known defects

Established by reading the source at the tag, last checked on 2026-10-25. Whether any of them has been reported as an issue upstream was not checked.

| Defect | Status |
| --- | --- |
| Two fully skipped snips that name each other as `next`, or one that names itself, recurse without end | Hypothesis, read and not reproduced |
| A completion script that stops the playback does not prevent what plays next | Read. The upstream backlog lists it as an open question |
| `resnip_snip_set_next` accepts a change after setup | Read. The upstream backlog lists it as a gap |
| Changing an options array after `resnip_snip_create` changes later clones | Read and not run |
| No test covers a callback that throws, `resnip_instance_sync` with a stopped or backward playback, a `direction` other than 1 or -1, or a change of gamespeed during play with a sprite in frames per game frame | Gaps in the upstream suite |
