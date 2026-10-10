# AESnips

## About this document

This document describes AESnips (AngelEngine Snips), a GameMaker library that plays sprite animations with very little code. It is for anyone who wants to use it, wrap it or know where it falls short. It contains what the library is, its concepts, the two ways to play a snip, the end types, the order of events when a snip ends, the functions, examples taken from the official demo, the steps to update between versions and the faults found in the code. It leaves out the drawing of the demo sprites and the internals of the debug panel. It describes version 0.1.4. Update it when a new version changes a function, an enum or a behaviour listed here.

Each fact carries one of three marks. **Documented** means the author's documentation or change log states it. **Demo** means the official demo project does it. **Source** means it comes from reading the code of version 0.1.4 and was not run.

## What it is

AESnips is made by William Jones (GameMaker Community user `angelwire`) for GameMaker Studio 2.3 or higher (**Documented**). For more information, see the project repository, [angelwire/AESnips](https://github.com/angelwire/AESnips/). The official documentation is a [Google Doc](https://docs.google.com/document/d/1JSGG1mfid8lOiSictlqFUEiaxrTep1TUyvLne1Z2Yr0/edit?tab=t.0), and the **Documented** mark in this guide refers to it. The author's documentation links the [demo project](https://github.com/angelwire/AESnips/raw/master/AESnips%20Demo.zip) and the [library package](https://github.com/angelwire/AESnips/raw/master/AESnips.yyz). The demo package ships no licence file, so read the licence on the project page before you use the library.

The library takes over `sprite_index`, `image_index` and `image_speed` of an instance, or plays on its own without an instance, and automates what animation code usually repeats (**Documented**).

- Play a sprite section with one line of code.
- Give each frame its own speed.
- Repeat chosen frames a number of times.
- Play a connecting animation between two animations.
- Queue an animation to start when the current one ends.
- Run a script on a chosen frame.
- Play forward, backward or back and forth.

It is three scripts.

| Script | Holds |
| --- | --- |
| `AESnipsBase` | The enum `ae_snip_end`, the constructors `Snip`, `Transition` and `Loop`, the instance events, the playback controls and the debug panel. |
| `AESnipsPlayer` | The constructor `SnipPlayer`. |
| `AESnipsArbiters` | The getters and setters. The author asks to use them and not to write the variables directly. |

The library takes these names in the global namespace (**Source**).

- Every function starts with `snip_`.
- The constructors are `Snip`, `Transition`, `Loop` and `SnipPlayer`.
- The enum is `ae_snip_end`.
- The global variable is `AE_SNIP_GLOBAL_IS_PAUSED`.
- The instance variables all start with `ae_snip_`.

## Concepts

| Term | Meaning |
| --- | --- |
| Snip | A struct made from a sprite, or from a run of its sub-images, with a speed. It is the unit that plays. |
| Loop | A struct that holds a run of frames of one snip and a repeat count. |
| Transition | A struct with three snips: `from`, `to` and `use`. When a snip asks to play `to` while `from` is playing, `use` plays in between. |
| SnipPlayer | A struct that plays snips apart from the instance variables, so one instance can play several at once. |
| Successor | The snip a snip plays by itself when it ends. |
| Next snip | The snip queued to start when the current one ends. |

**Frames are relative to the snip.** If a snip takes sub-images 3 to 6 of a sprite, sub-image 3 is frame 0 of the snip. Loops, frame speeds and frame scripts always use the snip frame, never the sprite sub-image (**Documented**). `snip_index_to_frame` and `snip_frame_to_index` convert between them.

**Speed is a product.** The speed of a frame is its frame speed times the snip speed, times the direction, and it is zero while the snip is paused, frozen or the whole system is paused. A snip speed of 0.5 and a frame speed of 0.5 give 0.25 for that frame (**Documented**). Speeds must be positive. To play backward, set the direction (**Documented**). The speed set in the sprite editor is also respected (**Documented**).

## Two ways to play

| | Instance mode | SnipPlayer |
| --- | --- | --- |
| Setup | `snip_create_event()` in Create | `new SnipPlayer()` stored in a variable |
| Step | `snip_step_event()` | `player.step()` |
| Draw | `draw_self()` | `player.draw(x, y)` or `player.draw_ext(...)` |
| Drives | `sprite_index`, `image_index`, `image_speed` of the instance | Its own index, which the instance never sees |
| Snips at once | One per instance | As many as there are players |
| Control | `snip_play(...)` | `player.snip_play(...)` |

Both modes can run in the same instance, as the demo does (**Documented**, **Demo**). Since 0.1.3 the Animation End event is not needed (**Documented**).

## Setting up

Create snips, loops and transitions once and keep their references where every user can read them, either in a global variable or on a holder instance (**Documented**). The runner demo keeps four snips in one object that never plays anything, and every runner reads them from it (**Demo**).

1. Create the snips with `new Snip(sprite, speed, [start], [end])`, `snip_create_ext(...)` or `snip_clone(snip)`.
2. Add loops with `new Loop(snip, start, end, repeat)`.
3. Add transitions with `new Transition(from, to, snip)`.
4. Set frame speeds, frame scripts, the successor, the direction and the end type.
5. Start with `snip_start(snip)`.

A `Snip` throws if its end frame is before its start frame (**Source**).

## End types

The end type says what a snip does when it reaches its last frame and nothing is queued or following. The default is `end_repeat` (**Source**).

| Value | Behaviour | When the snip counts as complete |
| --- | --- | --- |
| `ae_snip_end.end_stop` | Freeze on the last frame played. | At the end. |
| `ae_snip_end.end_stop_head` | Jump to the first frame and freeze. | At the end. |
| `ae_snip_end.end_stop_tail` | Jump to the last frame and freeze. | At the end. |
| `ae_snip_end.end_repeat` | Jump to the first frame and play again, or to the last frame when playing backward. | Each time it wraps. |
| `ae_snip_end.end_pingpong` | Reverse at the first or last frame. | At both ends. |
| `ae_snip_end.end_pingpong_head` | Reverse at either end. | Only when it gets back to the first frame. |
| `ae_snip_end.end_pingpong_tail` | Reverse at either end. | Only when it gets to the last frame. |

All of this is **Documented** and matches the **Source**. When a snip completes, its completion script runs, then the next snip, the successor or the end type decides what follows.

## When a snip ends

The order is the same in both modes (**Source**).

1. If a loop is running, jump back to its start, count one pass and stop here.
2. With `end_pingpong_head` playing forward, or `end_pingpong_tail` playing backward, reverse and stop here without completing.
3. Run the completion script, if any.
4. If a next snip is queued, play it.
5. Otherwise, if the snip has a successor, play it. The code does not check the direction.
6. Otherwise, apply the end type.

A transition snip is played with the target queued, so its own successor is never used (**Documented**, **Source**).

## Loops

A loop plays once and then repeats the number of times set, so it plays `repeat + 1` times in all. A repeat count below 0 skips the loop (**Documented**). The count can change while the game runs, and the demo uses that to set how many shots the cowboy fires (**Demo**). The start and end frames are both included (**Source**).

A loop with a repeat of 0 is easy to take for a loop that does nothing, but it still plays its frames once.

## Transitions

When `snip_play` or `snip_play_next` is called with `should_transition` true, the library looks for a transition from the snip now playing to the requested one. If a transition is already playing, it looks from the snip that transition is heading to (**Source**). If it finds one, it plays the `use` snip and queues the requested one. If not, it plays the requested snip at once.

A transition is held by the lists of both of its snips. Dropping the variable that holds it does not remove it. The red cowboy demo only sets its variables to `-1` in the Step event, which changes nothing (**Demo**, **Source**).

## Frame and completion scripts

`snip_set_frame_script(snip, frame, script, [argument])` and `snip_set_completion_script(snip, script, [argument])` take a script function or a method (**Documented**, changelog 0.1.2). A frame script runs once when the snip arrives on that frame, and again each time the snip comes back to it (**Source**).

Called from instance mode, the script runs with the instance as `self`. Called from a `SnipPlayer`, a script function runs with the player as `self` (**Source**). The demo bullet script creates a bullet only when `self` is not a struct, so the instance fires once and the players do not (**Demo**).

## Functions

"Player" means the function exists as a member of `SnipPlayer`. The others work on a snip, a loop or a transition and need no instance.

### Create and clone

| Function | Purpose |
| --- | --- |
| `Snip(sprite, speed, [start], [end])` | Create a snip. |
| `snip_create_ext(sprite, speed, start, end, end_type, successor)` | Create a snip with an end type and a successor. `-1` stands for the default frame or for no successor. |
| `Transition(from, to, snip)` | Create a transition. |
| `Loop(snip, start, end, repeat)` | Create a loop. |
| `snip_clone(snip)` | Copy a snip with its loops, frame data and transitions. |
| `snip_clone_transitions(source, destination)` | Copy the transitions of one snip to another. |
| `snip_clone_loops(source, destination)` | Copy the loops of one snip to another. |
| `snip_transition_clone_reverse(transition)` | Make the opposite transition with a reversed copy of its snip. |

### Playback

| Function | Player | Purpose |
| --- | --- | --- |
| `snip_start(snip)` | Yes | Play without a transition. |
| `snip_play(snip, should_transition)` | Yes | Play now. It resets loops and unfreezes. |
| `snip_play_next(snip, should_transition)` | Yes | Queue for when the current snip ends, or play now if nothing plays or the snip is frozen. |
| `snip_play_request(snip, should_transition)` | Yes | Play only if the snip, or a transition leading to it, is not playing. |
| `snip_cancel_play_next()` | Yes | Drop the queued snip. While a transition plays, the target stays queued. |
| `snip_pause()` and `snip_resume()` | Yes | Pause and resume one player or instance. |
| `snip_stop()`, `snip_stop_head()`, `snip_stop_tail()` | Yes | Freeze where it is, on the first frame or on the last frame. Only `snip_play` restarts it. |
| `snip_global_pause()` and `snip_global_resume()` | No | Pause and resume every snip. A snip paused on its own stays paused. |
| `snip_reset_loops(snip)` | Yes | Reset the pass count of the loops. |
| `snip_find_transition(from, to)` | No | Return the transition, or `undefined`. |
| `snip_go_to_frame(frame, reset_loops)` | No | Jump inside the current snip. Instance mode only. |

### Read and set

All of these are in `AESnipsArbiters`.

| Group | Functions |
| --- | --- |
| Sprite and speed | `snip_set_sprite`, `snip_get_sprite`, `snip_set_speed`, `snip_get_speed` |
| Direction | `snip_set_forward`, `snip_set_backward`, `snip_reverse`, `snip_get_direction` |
| Frames | `snip_get_start_index`, `snip_get_end_index`, `snip_get_frame_count`, `snip_index_to_frame`, `snip_frame_to_index` |
| Frame speed | `snip_set_frame_speed`, `snip_get_frame_speed`, `snip_get_frame_speed_list`, `snip_reset_frame_speeds` |
| Frame script | `snip_set_frame_script`, `snip_get_frame_script`, `snip_set_frame_script_argument`, `snip_get_frame_script_argument`, `snip_get_frame_script_list` |
| Completion script | `snip_set_completion_script`, `snip_get_completion_script`, `snip_set_completion_script_argument`, `snip_get_completion_script_argument` |
| End and successor | `snip_set_end_type`, `snip_get_end_type`, `snip_set_successor`, `snip_get_successor`, `snip_set_should_transition_successor` |
| Loops | `snip_set_loop_repeat`, `snip_get_loop_repeat`, `snip_get_loop_snip`, `snip_get_loop_start`, `snip_get_loop_end`, `snip_get_loop_count`, `snip_get_loop_list` |
| Transitions | `snip_get_transition_from`, `snip_get_transition_to`, `snip_get_transition_snip`, `snip_set_transition_from`, `snip_set_transition_to` |
| State of the instance | `snip_current`, `snip_is_playing`, `snip_get_current_loop`, `snip_get_remaining_loop_performances`, `snip_get_next_snip` |

`snip_set_successor` turns the transition on by default, but `new Snip` leaves it off. `snip_create_ext` turns it on when it gets a successor (**Source**). A negative speed or a negative frame speed throws (**Source**).

The functions in the last row read the `ae_snip_*` variables of the calling instance, so they work only in instance mode. A `SnipPlayer` has no equivalent (**Source**).

### Destroy

| Function | Purpose |
| --- | --- |
| `snip_destroy_snip(snip)` | Destroy a snip with its loops, transitions and lists. |
| `snip_destroy_transition(transition)` | Remove a transition from both snips and destroy it. |
| `snip_destroy_loop(loop)` | Remove a loop from its snip and destroy it. |

A snip holds three data structure lists, so destroy snips you no longer need (**Source**).

### Debug panel

`snip_draw_debug(x, y)` draws every frame of the sprite of the snip that the instance plays, in instance mode only (**Source**).

| Mark | Meaning |
| --- | --- |
| Frame lifted, green bar | The current frame and its progress. |
| Faded frame | Not part of the snip. |
| Orange dot | The frame has a script. |
| Aqua bracket | A loop that repeats. |
| Green bracket | The loop being played. |
| Yellow bracket | A loop with repeat 0. |
| Red bracket | A skipped loop. |
| Red square | The instance plays no snip. |

## Examples

These are cut down from the official demo (**Demo**).

One snip with loops, frame speeds and a frame script:

```gml
snip_create_event();

my_snip = new Snip(blue_cowboy_sprite, 1);
shoot_loop = new Loop(my_snip, 5, 8, 0);
twirl_loop = new Loop(my_snip, 9, 11, 3);

snip_set_frame_speed(my_snip, 4, .2);
snip_set_frame_script(my_snip, 6, cowboy_fire_bullet, -10);

snip_start(my_snip);
```

Snips with a successor and transitions, played on a key press:

```gml
snip_create_event();

idle_snip = snip_create_ext(red_cowboy_full, .5, 0, 2, ae_snip_end.end_repeat, undefined);
draw_snip = snip_create_ext(red_cowboy_full, 1, 3, 6, ae_snip_end.end_stop_head, undefined);
fire_snip = snip_create_ext(red_cowboy_full, 1, 7, 10, ae_snip_end.end_stop_tail, undefined);
holster_snip = snip_create_ext(red_cowboy_full, 1, 11, 19, ae_snip_end.end_stop, undefined);

snip_set_successor(fire_snip, idle_snip, true);
new Transition(idle_snip, fire_snip, draw_snip);
new Transition(fire_snip, idle_snip, holster_snip);

snip_start(idle_snip);

// In the key press event
snip_play_next(fire_snip, true);
```

The same snip drawn by a `SnipPlayer`:

```gml
// Create
player = new SnipPlayer();
player.snip_start(my_snip);

// Step
player.step();

// Draw
player.draw_ext(x + 64, y, image_xscale, image_yscale, image_angle, c_white, 1);
```

## Updating

From the change log (**Documented**).

| From | Do |
| --- | --- |
| 0.1.2 | Remove `snip_animation_end_event()` from every Animation End event. Replace the `should repeat` boolean of `snip_create_ext` with a value of `ae_snip_end`. Replace `snip_set_repeat()` with `snip_set_end_type()`. |
| 0.1.3 | Replace any negative snip speed with a positive one and call `snip_set_backward()`. |

## Where the documentation and the code differ

| Documentation says | Code has |
| --- | --- |
| `new Transitions(From, To, Snip)` | The constructor is `Transition`. |
| Properties are in the script `AESnipBase` | The script is `AESnipsBase`. |
| `snip_create_ext(..., should repeat, successor)` | The fifth argument is an end type of `ae_snip_end`. |
| `snip_is_playing(Snip, check_transition?)` and the other controls work "with a SnipPlayer" | Only the functions in the Player column of the playback table exist on the player. |

## Problems

All of these come from reading the code of version 0.1.4 and were not run (**Source**).

| Symptom | Cause | What to do |
| --- | --- | --- |
| `snip_pause` and `snip_resume` on a `SnipPlayer` do nothing | They set `ae_snip_is_paused` and the player reads `ae_snip_player_is_paused` | Use `snip_global_pause`, or `snip_stop` and `snip_play` |
| `snip_play_request` on a `SnipPlayer` fails | It calls `snip_is_playing`, which the struct does not have, and that function reads instance variables | Compare with the current snip yourself and call `snip_play` |
| `snip_clone_loops` fails | It uses a variable `_new_snip` that is never set. It also tests the loop bounds against the source snip, which skips loops at its edges | Create the loops by hand |
| A cloned loop is one frame longer | `Loop` adds 1 to its end, and `snip_clone` passes it the value already stored. `snip_transition_clone_reverse` clones too | Set the loop again after cloning |
| `snip_get_remaining_loop_performances` returns 0 inside a loop and fails outside | The test is inverted | Compute it from the loop repeat and `ae_snip_loop_performances` |
| `snip_go_to_frame` lands on the wrong frame | It sets the index to `frame - start` and not `frame + start`, which only matters when the snip does not start at sub-image 0. Skipping a loop with a repeat below 0 has the same sign slip | Start snips at sub-image 0 where this matters |
| `snip_set_sprite` accepts a sprite one frame short | It compares the sub-image count against the end frame and not against the end frame plus one. It also leaves `_frames` as an instance variable | Check the count before calling |
| `snip_get_next_snip` reports the current snip for `end_stop_head` and `end_stop_tail` | It only treats `end_stop` as stopping | Check the end type too |
| Memory grows as snips are made | Each snip holds three lists that only `snip_destroy_snip` frees | Destroy snips you drop, from an instance that ran `snip_create_event` |
| A destroyed snip is still found as a transition target | `snip_destroy_snip` deletes the transitions but leaves them in the lists of the other snips | Call `snip_destroy_transition` first |
