# 0009. Verify behaviour with rules, replays and the original code

## About this document

This record decides how a change to the animation or to the logic is checked, because the project has no test commands. It is for anyone about to change the presentation, the enemies or the states, or to loosen one of the checks. It states the checks that run by themselves, the replay harness, the original code kept as a reference and the sessions of the maintainer, and it says what none of them cover. It does not state the rules of the project, which are in [CONTRIBUTING.md](../CONTRIBUTING.md). Update it when a check is added or when one of the limits changes.

- Status: accepted
- Date: 2026-10-29
- Decision-makers: the maintainer

## Summary

- A rule that can be automated is a check in `python tools/gm.py check`, and each check was broken on purpose once to see it fail.
- A change to behaviour is compared step by step with the original code on the same recorded inputs.
- The recorded sessions have limits, listed below, and a result is reported with them.

## Decision outcome

### Checks that run by themselves

These are fitness functions, in the sense of Ford, Parsons and Kua, checks that run on every change to keep a property of the architecture.

| Check | What it keeps |
| --- | --- |
| Library boundary | A symbol of a library with an adapter is used only in its adapter (`E006`) |
| Zones of animation and time | The logic makes no request to the animation, reads none and uses no source of time, outside the presentation and the adapter |
| Names of the shared presentation | The controller and the selectors name nothing that is not in Core or Vendor |
| One function for each selector | Each selector is one script with a limit of 6 branches |
| Character dependency | No file outside a character names what is in it, except four uses in two files of the roster, which are frozen |
| Rows, clips, fallbacks and sprites | Every state has a row, every clip has a fallback, no chain of fallbacks loops, every character has an `idle` and every sprite exists |
| Folders of resources | The folder of a resource is declared in the project file, so the game loads |

The uses that existed when a check was added are frozen in `tools/zones_baseline.txt`, as `FreezingArchRule` of ArchUnit records existing violations and reports only new ones. A line may only go down, and a count that dropped must be lowered, so it cannot grow back. The zone rule has only the debug manager and the rings left in it. The ArchUnit user guide was read on 2026-10-29 through the summary of a fetch tool. The book of Ford, Parsons and Kua was not read.

### The replay harness and the original code

- The harness runs a scenario of buttons by step, with the random numbers fixed, and prints one line for each step and a hash of the logic and of the picture. It is off while `REPLAY_SCENARIO` is empty, and the plug-in that sets the buttons is not even defined then.
- The original code is checked out as a `git worktree` of `HEAD` with only the harness copied on top, and the worktree is removed when the work ends. The same scenario runs in both trees and the lines are compared. A difference is explained, fixed or approved by the maintainer.
- A scenario is a recorded session of the maintainer or a short set of buttons. The recording mode writes the buttons held at each step.
- A comparison counts only for what it goes through. A scenario that never reaches a state proves nothing about it, so the lines are checked for the states they claim to test.

This is the method of the characterization tests of Feathers, where the current behaviour is pinned before it is changed. The book was not read.

### The limits

- A recorded session covers what the maintainer did. A turn after a roll was not in the first two sessions and was found in the third, so a clean result is not a proof.
- The trace of the enemies used for their migration was a temporary addition to the harness. It covered the position, the state, the frame and the bullets of each enemy, and not the hitbox of an enemy, the damage of a bullet or the sound.
- When the maintainer approves a change, the original code is patched with the same rule so that the comparison can go on. So far the only patch is the turn, which lasts 4 or 12 steps by a counter.
- The comparison against the original code ran on the VM. The benchmark ran on YYC, and the game was not played on YYC.
- The replay needs the window to stay still. The real keyboard is live until the script starts, and the window losing focus lowers the game speed.
- The warning for a missing clip and the fallback it names were run only through a temporary block of the harness, which was removed.

## Considered options

- **A unit test framework.** Not built, because nothing in the project is written for it and the project has no test commands.
- **Compare only the final hash.** Refused, because a hash that matches can come from a run that never reached the case. The comparison is by line.
- **Trust the reading of the code.** Refused by [0006](./0006-replace-a-read-of-the-animation-by-explicit-state.md).

## Consequences

- Without the checks, a rule holds by attention alone. A wrong folder path, for one, stops the game from loading, and only the folder check finds it before the first run.
- Without the original code, a change of structure cannot be told from a change of behaviour.
- Loosening a check or raising a frozen count needs a decision of the maintainer.
