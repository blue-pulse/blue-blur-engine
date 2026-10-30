# 0006. Replace a read of the animation by explicit state

## About this document

This record decides what to do when the logic reads the animation. It is for anyone about to remove such a read, to call one "a patch for a rare case", or to add a variable to the logic in its place. It states the rule, the two cases that taught it and how to check one. It does not cover the boundary between the logic and the animation, which is [0004](./0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md). Update it when a third case is found.

- Status: accepted
- Date: 2026-10-29
- Decision-makers: the maintainer

## Summary

- A read of the animation by the logic can be the anchor of a behaviour, and not a quirk. The animation was the memory of a state.
- When the read leaves the logic, replace it with a variable of the logic that is cleared by the same rule the animation had without anyone writing it: any other request replaced it.
- Run the case before you call it rare. Reading the code is not enough.

## Context and problem statement

The logic read the animation in 13 lines of 9 files. Some read it to wait for the end of a clip, and those are timers in disguise. Two did something else.

- In the running state, the line `if (dir == input_dir and animation_is_playing(anim_push)) break;` looked like a patch for a rare case. It held the state "I am pushing a wall". A contact with a wall is registered only when the movement crosses a pixel, so between two contacts the speed is above zero and the speed ladder would put the walk animation over the push. The push animation was the memory of the state.
- In the airborne state, the test `animation == anim_rise` ended the rise of a spring when any other animation replaced it, such as the jump ball or the fall after a monitor. A flag cleared only at the apex ended the rise too late, and the fall played over the jump.

Reading the code made both lines look like patches for rare cases. Playing the game showed that they held a state, so this record asks for a run and not a reading.

## Decision outcome

- The state the animation remembered becomes a variable of the logic: `is_pushing`, set by the wall contact and cleared when the direction pressed no longer matches the facing and when the running state starts, and `is_rising`, set by an upward spring and cleared at the apex, when the body curls into the ball, at a monitor bounce and when the state stops.
- The variable has the clearing rule that the animation had: it ends when anything else takes its place. A rule that only ends it in one place is wrong.
- The presentation reads the variable through the facts of [0004](./0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md), and the logic never reads the animation.
- The case is checked by running it. The recorded sessions of the maintainer contain the spring case five times, a scenario holds the wall push, and the replay against the original code must give the same logic and the same picture.

## Considered options

- **Call the read a patch and remove it.** Refused for the reason above. Chesterton's fence asks to know what a line is for before removing it, and the essay was not read for this record.
- **Keep the read of the animation in the logic.** Refused by [0004](./0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md).

## Consequences

- Undoing the decision, by reading the animation again or by clearing the flag in one place only, brings back the flicker of the push and the fall over the jump.
- The wait for the last frame of the turn was a third case, which a session with enemies showed. [0007](./0007-let-the-logic-own-the-durations-that-matter-to-the-game.md) states what the turn does now.
- The reads that waited for the end of a clip became timers in steps, which [0007](./0007-let-the-logic-own-the-durations-that-matter-to-the-game.md) states.
- The zone rule counts such reads and fails the check on a new one, and the replay harness and the original code are the way to check a case. [0009](./0009-verify-behaviour-with-rules-replays-and-the-original-code.md) states them.
