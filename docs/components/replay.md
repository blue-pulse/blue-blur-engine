# Replay harness

## About this document

This document describes the replay harness, which plays a scripted or recorded set of buttons into the game and prints one line for each step, and how to use and change it. It is for anyone about to run a scenario, record a session, add a scenario, or compare a change with the original code. Read it before you change `REPLAY_SCENARIO`, `obj_replay_manager`, `replay_create_source`, `replay_define_scenarios`, `replay_format_step`, the `input_script_*` functions, or the lines of `obj_init_manager` and `obj_player_spawner` that test the macro.

It contains a summary, the harness as a black box, how a run flows, its parts, its interfaces, its invariants, a map of the edits, how to compare against the original code, and its limits and gaps. It leaves out why behaviour is checked this way and what no method covers, which is in [0009](../decisions/0009-verify-behaviour-with-rules-replays-and-the-original-code.md), the rules for running the game, which are in [CONTRIBUTING.md](../CONTRIBUTING.md), and how to measure a cost, which is in [0011](../decisions/0011-measure-a-cost-in-the-real-step-against-a-rebuild.md).

Update it in the same change as the code it describes. Every name and value here was read from the code.

## Summary

- The harness replaces the keyboard with a list of buttons for each step, fixes the random numbers, and prints the state and the picture of the player at the end of every step, so two runs can be compared line by line.
- Everything follows from one switch: the harness exists only while the macro `REPLAY_SCENARIO` holds the name of a scenario. With the empty string the game is unchanged and the plug-in is not even defined.
- The repository has no command that runs a batch or compares two runs. The harness prints, and the comparison is done by the person or tool that drives it.

## Context

| Question | Answer |
| --- | --- |
| Receives | The macro `REPLAY_SCENARIO` in `_setup_macros`, and the scenario of that name from `replay_define_scenarios` |
| Gives | Lines on the log of the game, one hash of the logic and one hash of the picture at the end |
| Code | `02. Core/08. Tooling/03. Replay` holds `replay_*` and `obj_replay_manager`, and `02. Core/09. Adapters/03. Input` holds `input_script_*` |
| Depends on | Input, for its plug-in interface, through the adapter, and on the player, the stage manager and `Protagonist` |

## How it works

1. The macro is set to a scenario name by editing `_setup_macros`, and the game is run as usual, with `python tools/gm.py run`.
2. At the start, `input_script_define` runs because the macro is not empty, and defines the plug-in `BlueBlur.ScriptedInput` of Input. It registers a callback for `COLLECT_PLAYER`. It runs after Input has collected the device, and it only acts for `PLAYER_SLOT`.
3. `obj_init_manager` sets its `next_room` to the room of the scenario instead of the title or the home room.
4. When that room's `obj_player_spawner` builds the scene, it creates `obj_replay_manager` with `manager_create`, once. The manager reads the scenario and keeps it in `global.replay`, so a restarted room goes on with the same script.
5. In its End Step event, the manager waits until `Protagonist` exists and no scene change is running. Then it calls `random_set_seed(1)`, prints a `[REPLAY] start` line with the ticks, the room and the position, and starts the script with `input_script_start`. In recording mode it does not start a script.
6. From then on the callback of the plug-in sets, for each step and each button from 0 to `vb_y`, the value that the plan gives. It does so unless the player is blocked, and it counts the step.
7. At the end of every step the manager adds two lines to `global.replay` and prints them together after `[REPLAY]`. The logic line is `replay_format_step`: the step, the name of the state script, `x` and `y` with 4 decimals, and `hor_speed` and `ver_speed` with 6. The picture line is the step, the sprite name, `#`, the `image_index`, and ` ball<n>` when `obj_jumpball` instances exist.
8. When the step reaches the length of the plan, the manager stops the script, prints `[REPLAY] logic <md5>` and `[REPLAY] picture <md5>` of all the lines joined, and calls `game_end`.

In recording mode, each step prints `[RECORD] <mask>`, where bit `b` of the mask is set when button `b` is held, and the real keyboard is live.

## Parts

| Part | Where | Responsibility |
| --- | --- | --- |
| `REPLAY_SCENARIO` | `_setup_macros` | The switch, empty by default |
| `replay_define_scenarios()` | `03. Replay` | Returns the struct of scenarios, 11 of them |
| `replay_create_source(segments)` | `03. Replay` | Makes the plan, and a `source(step, button)` function |
| `replay_format_step(step)` | `03. Replay` | The logic line of the player, called with the player as `self` |
| `obj_replay_manager` | `03. Replay` | Starts, records and reports, in `Create_0` and `Step_2` |
| `input_script_define()`, `_start(source)`, `_get_step()`, `_stop()` | `09. Adapters/03. Input` | The plug-in, and the control of the script and its step counter |

### The scenarios

A scenario is `{ room, segments, recording? }`. `segments` is an array of `{ steps, hold }`, where `hold` lists the buttons held for that many steps. The plan ends at the sum of the steps.

| Scenario | Room | Steps | Kind |
| --- | --- | --- | --- |
| `poses` | `rm_test_zone` | 512 | Short, idle, look up, crouch, jumps |
| `skid` | `rm_hub_world` | 345 | Short, run and skid |
| `roll` | `rm_hub_world` | 544 | Short, run and roll |
| `push` | `rm_test_zone` | 395 | Short, wall push |
| `jump` | `rm_hub_world` | 424 | Short, jump and fall |
| `air` | `rm_hub_world` | 362 | Short, air states |
| `session1` | `rm_test_zone` | 9349 | A recorded session of the maintainer |
| `session2` | `rm_hub_world` | 7779 | A recorded session of the maintainer |
| `enemies` | `rm_test_zone` | 5766 | A recorded session with enemies |
| `record` | `rm_test_zone` | none | Recording mode |
| `recordhub` | `rm_hub_world` | none | Recording mode |

## Interfaces

| Function | Meaning |
| --- | --- |
| `replay_define_scenarios()` | Returns the scenarios by name. `obj_init_manager` and `obj_replay_manager` read one with `[$ REPLAY_SCENARIO]` |
| `replay_create_source(segments)` | Returns `{ segments, ends, steps, source }`. `source(_step, _button)` is true while the button is in the `hold` of the segment of that step, and false after the last one |
| `replay_format_step(step)` | Returns `"<step> <state script> <x> <y> <hor_speed> <ver_speed>"` |
| `input_script_define()` | Defines the plug-in. The code at the bottom of its script calls it when the game starts, only if the macro is not empty |
| `input_script_start(source)` | Plays the buttons given by `source(step, button)` and resets the step to 0 |
| `input_script_get_step()` | The step the script has reached |
| `input_script_stop()` | Gives the buttons back to the device |

## Invariants

- With `REPLAY_SCENARIO` equal to `""` the plug-in is not defined, no manager is created and the next room is the usual one. Held by the three tests of the macro, and by attention alone.
- A run starts only when the player exists and no scene change is running, so the first step of a plan is the first step the player can act. Held by attention alone.
- The random numbers are seeded with 1 at the start of the script, so two runs of one scenario on one build give the same lines. Held by attention alone, and by comparing runs.
- The macro is `""` in the code that is shared. Held by attention alone.

## Change map

| To | Edit | Confirm with |
| --- | --- | --- |
| Add a scenario | A new entry in `replay_define_scenarios` with `room` and `segments`, then set the macro to its name | One run, checking that the lines reach the states you claim to test ([0009](../decisions/0009-verify-behaviour-with-rules-replays-and-the-original-code.md)) |
| Record a session | Set the macro to `record` or `recordhub`, play, and turn the `[RECORD]` masks into segments, keeping the room | A run of the new scenario against the recording |
| Add a value to a line | `replay_format_step` for the logic line, or the picture line in `Step_2` of the manager | Both runs of a comparison use the same format |
| Compare against the original code | See below | The lines and the two hashes |

## Comparing against the original code

[0009](../decisions/0009-verify-behaviour-with-rules-replays-and-the-original-code.md) decides that a change of behaviour is compared with the code before it. The method is:

1. Make a `git worktree` of `HEAD`, copy only the harness on top, and run the same scenario in both trees.
2. Wait for the file that the batch writes when it ends ([CONTRIBUTING.md](../CONTRIBUTING.md), `A015`) and check that both outputs are not empty.
3. Compare line by line. A difference is explained, fixed or approved by the maintainer.
4. On YYC, delete the Igor cache before each scenario, and compare the lines of the enemies without their order.
5. Remove the worktree when the work ends.

Ask the maintainer before each batch, as `A014` asks, because a run needs the keyboard and the mouse left alone.

## Limits and gaps

- The keyboard is live until the script starts, and the window losing focus lowers the game speed to 20 steps per second through `game_reduce_power`, so leave the window focused.
- The harness prints the player only. A trace of the enemies has to be added to the manager for a work that needs it, and was removed after use.
- The repository holds no driver for a batch of scenarios, and no stored result to compare with.
- The picture line names the sprite and the frame, not the pixels drawn, so a change in a draw event is invisible to it.
