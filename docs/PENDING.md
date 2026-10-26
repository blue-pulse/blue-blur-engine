# Pending work

## About this document

This document is the project's long-term backlog. It is for anyone choosing what to work on next, or who needs to know what is deliberately unfinished.

Each entry states the problem, the shape of the fix, and how you know it is done, so you can pick it up cold. Entries are ordered by priority and carry no dates. Items cite each other by number, so when an item is finished it is deleted and the others keep their numbers, which means the list can start above 1 and have gaps.

It does not record what was done, because the code and git record that. It holds no rules, which are in [CONTRIBUTING.md](./CONTRIBUTING.md), and no deliberate choices, which are in [decisions/](./decisions/). Nothing here is acted on unless the maintainer asks.

Update it when an item is found, changes shape, or closes.

## 2. Improve the code line by line

Problem. Much of the code works but was not designed on purpose. Some of it was copied without much thought, many values are bare literals, and many names were chosen for being short or good looking at the time. It does not yet follow the rules in [CONTRIBUTING.md](./CONTRIBUTING.md), and there are no automated tests to protect a change.

Shape. Work one domain at a time in dependency order, starting with `02. Core` as a pilot so the patterns are fixed before the larger domains. In each domain make these passes in order, and keep the passes that change behaviour apart from the ones that do not.

- Audit the domain without editing it and group the findings by pass.
- Mechanical pass, with no change in behaviour: comments, language, plain words and formatting.
- Names pass: the user approves a table of renames in one batch before anything is renamed.
- Constants pass: move bare literals into enums, macros and configuration functions.
- Structure pass: split long functions, remove duplication, and look at the engine depending on content and at work that grows with the number of instances every frame. The user approves each change in behaviour first.
- Commit once per domain and pass, with a short manual checklist for the user to run, because the game cannot be run by an agent.

The player's movement, collision and state code waits for item 3.

Done when every domain has gone through all the passes and follows the rules in [CONTRIBUTING.md](./CONTRIBUTING.md).

## 3. Review the physics against its three origins

Problem. The physics and collision code descend from three external projects: one written for another version of GameMaker, an unfinished work in progress that is the origin of this project, and an updated version of that work in progress that has never been read. How far this project matches each of them is unknown, so it may hold bugs they avoid, miss improvements they have, or skip behaviour they implement. Which functions came from which project, and under what licence, is not recorded either (`E003`, `E004`, `E008`). Only ClusterFramework is recorded, by folder, in [NOTICE.md](../NOTICE.md).

Shape. Do it after the rest of the engine works, over several sessions.

- Read each origin to find bugs in this project's implementation, improvements the origin has, and behaviour this project skipped.
- Compare the work in progress with its updated version to see what its author fixed.
- Record the origin and licence of every borrowed function in [NOTICE.md](../NOTICE.md).
- Leave the player's movement, collision and state code out of the code cleanup until then, because this review is likely to rewrite it and renaming it first would make the comparison harder.

Done when each origin has been reviewed, every finding is fixed or rejected with a reason, every borrowed function has its origin and licence recorded, and the player's movement, collision and state code has gone through the passes of item 2.

## 5. Verify the tools on macOS and Linux

Problem. The tools in `tools/` were only run on Windows. The folders they search on macOS and Linux, and the Igor program they start there, come from reading the source of another tool and not from a run. The manual runs Igor on macOS as `dotnet Igor.dll`, while that source starts a file named `Igor`, so one of the two is wrong.

Shape. Run `python tools/gm.py doctor` and `run` on each system, fix the folders and the command that differ, and mark the result as observed in [reference/igor.md](./reference/igor.md). Then drop the warning the tools print outside Windows.

Done when `doctor` and `run` pass on macOS and Linux and the Igor guide marks those rows as observed.

## 6. Run the project in continuous integration

Problem. Nothing checks that the project still compiles and starts after a change, and the check depends on somebody running it.

Shape. A GitHub Actions workflow that installs the runtime, creates the licence file from an access key kept as a secret, makes the prefabs available on a clean runner, and runs the project. Three points are open, which are how the runner gets the prefabs, whether the game can start there without a screen, and whether Igor passes the exit code of the game on. The two community actions used by other studios, `bscotch/igor-setup` and `bscotch/igor-build`, are the first thing to read. This needs a decision record before it is built.

Done when a workflow runs on every push and fails when the project does not compile.

## 7. Share the animations of Sonic between instances

Problem. Each Sonic builds its own animations and 26 transitions when it is created, and removes the transitions in its Clean Up event, because the transition registry of Resnip holds its animations until they are removed. Every load of a stage rebuilds about 45 animations. One set per character, shared by every instance, would remove both the rebuild and the cleanup, and it is the design the Resnip repository recommends. It changes the roughly 200 references to `anim_*`, which today live in instance variables.

Shape. Build the set once per character, keep it where every instance of the character can read it (`S008`), point the references at it, and remove `animation_free` and the Clean Up event of `obj_player`. The enemies build no transitions, so they can stay as they are.

Done when no instance builds the animations of its character and `animation_free` is gone.

## 8. Stop the logic from depending on animation

Problem. States and enemies read the animation to decide what to do, when the state machine should own the logic and the animation should only present it. Five places do it today. `player_state_turn` leaves its state when `animation_is_last_frame()`. `player_state_airbone` reads `animation == anim_rise` to switch to the fall. `player_state_run` reads `animation_is_playing(anim_push)` to avoid asking for the run animation again. `obj_jumpball` destroys itself when `owner.animation` stops being its hook. The enemies `obj_balloon`, `obj_buzzer`, `obj_newtron` and `obj_motobug` fire their bullets on a frame number, return to idle on the last frame, and `obj_newtron` removes itself when its frame falls below 1.

Shape. Study how the state machine works today before changing anything, then decide with the maintainer where each duration and event should live. Resnip offers frame scripts and completion scripts if an animation has to tell the logic something. Keep it apart from the passes of item 2, because it changes behaviour.

Done when no state, physics routine or enemy reads the animation, and the animation functions have no caller outside the code that presents.

## 9. Make the debug tools professional

Problem. The debug overlay works but was not designed on purpose. Its shortcuts are one chain of `if` statements that run with the player as `self`, with the keys written in the code. Specific faults were found by reading, none by running.

- `obj_debug_manager` `Step_0` uses `exit` inside `with (Protagonist)`, which ends the whole event, so while the player is dying the text freezes and no shortcut works, Esc and R included.
- Two functions change the game speed, the FPS shortcut and `game_reduce_power`, and the focus change overwrites the shortcut. Closing the overlay does not restore the speed.
- Esc is also the `BACK` verb of Input, and R and Esc act with no modifier.
- Lowering the FPS does not slow the animations, because Resnip reads the game speed at every step and a sprite in frames per second keeps its pace in real time.
- The restart-stage shortcut has no `scene_is_changing` guard, the HUD shortcut fails without `obj_hud`, and the camera shortcut says random but takes the first instance and may compare an instance with an object.
- Every enemy draws the full strip of its animation each frame, and the data text is rebuilt each step.
- The shortcuts need a numeric keypad, and the manager reads both `Protagonist` and `Player`.

Shape. Audit once more before editing, then work in this order, with the user approving each change in behaviour.

- Fix the `exit` fault, give the game speed one owner that the focus and the debug tools both use, restore it when the overlay closes, and add the missing guards.
- Move the shortcuts to a table in `02. Configuration` with key, name, function and context, split into game commands and player commands that receive their target, and add alternative keys and an on-screen list of them.
- Add pause with step by step advance for inspecting animations, and switches to draw the collision masks and the animation panels, with the panels limited to enemies in view.

Done when each shortcut is a row of the table, no debug command depends on `self`, the fault list above is closed, and the overlay leaves the game as it found it.
