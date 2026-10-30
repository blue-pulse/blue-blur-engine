# 0004. Publish the facts of the logic and let the animation follow the state

## About this document

This record decides how the game logic and the animation talk to each other. It is for anyone about to let a state ask for an animation by name, read the animation from a state or a physics routine, add a shared list of activities, or change what the player publishes each step. It states the boundary, the one speed the controller reads, and what was refused. It does not list the facts or describe the controller, which are in [ARCHITECTURE.md](../ARCHITECTURE.md), and it does not cover the transitions, which are [0005](./0005-use-one-mechanism-for-transitions.md). Update it only when the maintainer rules a change.

- Status: accepted
- Date: 2026-10-29
- Decision-makers: the maintainer

## Summary

- The logic writes a record of facts once per step and never names an animation or reads one. The presentation reads the record and chooses.
- The presentation speaks the language of the logic. A row of data is found by the identity of the state, so the animation lists no activity of its own.
- The controller reads the speed at the end of the step, as it is published after the state ran.
- Never ask for an animation from a state, never add a second list of states for the animation, and never read the animation to decide anything in the logic.

## Context and problem statement

The states, the physics routines and the enemies called the animation functions and read the animation, 13 lines in 9 files for the reads alone, and the names of the clips were spread through the state files. When the part of the player was finished, the zone rule still counted 29 requests, 28 names, 8 queries and 1 use of time in 16 files, all in the enemies, the debug manager, the rings and one helper. A new character would have copied the state files, and a new state machine would have had to rewrite every call. The maintainer decided that the names of the states stay and that the state machine will be redesigned in another piece of work, so the animation must not depend on how the states are organised inside.

## Decision outcome

The logic publishes, the presentation consumes.

- `player_publish_facts` copies the facts the animation needs from the variables of the logic into `presentation_facts` once per step, after the state, the speed limits, the grid and the rotation. An enemy publishes only `state`.
- `presentation_update` reads the record and holds no name of a state, a pose or a clip. The data it follows comes from the character or the enemy.
- A fact comes with the selector that reads it and never before. A counter only grows, and the selector compares it with the last value it saw.
- The mode of the body is the identity of the `state` function. A row of the data is `{ state, entry, follow }`, so the logic and the animation use the same word.
- A behaviour that used to live in the animation is a variable of the logic with the same rule for clearing it. [0006](./0006-replace-a-read-of-the-animation-by-explicit-state.md) states why.

### The speed of the step

The controller reads the speed at the end of the step. The old requests ran inside the state, before the speed of that step was final, and read the speed at the start. The maintainer approved the change. Over the two sessions recorded from the maintainer, the picture differs from the original in 174 of 9,245 steps (1.88 percent) and in 4 of 7,779 steps (0.05 percent). In the first session 3 of those steps, and in the second all 4, are a switch between the fast and the slow roll at the limit of 5, and the rest are the roll clip on a different frame. Nothing else in the picture differs.

## Considered options

- **A layer of activities between the logic and the animation, with a closed list in the style of `ACTIVITY_*`.** Refused. The plan estimated about 15 activities for 19 states, which is a second list that answers the question the states already answer, and two mechanisms for one question are a defect.
- **One closed enum shared by the logic and the animation.** Refused. A new character with its own mode, such as flight, would have to edit a file that every character shares.
- **The logic asks for a clip by name.** Refused. This is the push model, and it ties the logic to the art. Every new character and every renamed clip reaches into the states.
- **Compare the speed at the start of the step, as the old code did.** Refused. It needs the record published before the state runs, which puts the presentation between two parts of the logic. The cost of the choice is the measured shift above.

## Consequences

- Undoing the decision brings the animation back into the states. The zone rule checks it: a request, a read or a name outside the presentation fails `python tools/gm.py check`.
- The cost of the controller on the path of the running player is 1.72 µs per step on YYC and 5.53 µs on the VM, and publishing the facts costs 0.24 and 0.71 µs. Method: a temporary block in the replay manager, median of 9 repetitions of 20,000 calls, an empty function subtracted, the order rotated, on 2026-10-29, one machine, runtime 2026.0.0.23. The harness was removed, so the figures cannot be repeated from the repository.
- The state machine of the player can be replaced by another structure if it still writes the same facts and keeps the flags that replaced the reads of the animation. A test with a table that wrote `state` and `speed` drove the rows of Sonic without a change to the presentation.
- The practice behind it is the Separated Presentation of Fowler, where the presentation may call the domain and the domain may not call the presentation, and his Presentation Model, where the state of the presentation is kept apart from the controls. Both pages were read on 2026-10-29 through the summary of a fetch tool and not in full. Unreal's Property Access and the tags of the Gameplay Ability System, which this design resembles, were not read.
