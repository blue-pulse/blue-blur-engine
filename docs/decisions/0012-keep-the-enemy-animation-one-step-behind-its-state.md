# 0012. Keep the enemy animation one step behind its state

## About this document

This record decides the order in which an enemy advances its animation and chooses its next clip, and says that the delay this gives is deliberate. It is for anyone about to swap the two calls of `enemy_update_animation`, move the animation of an enemy to the Step event, or make an enemy show a new clip on the step its state changes. It covers the order, why it looks like a defect and is not, and what changing it would break. It does not cover the boundary between the logic and the animation, which is [0004](./0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md), or the cost of the presentation, which is [0010](./0010-accept-the-cost-of-the-generic-presentation.md). Update it only with a new ruling from the maintainer.

- Status: accepted
- Date: 2026-11-12
- Decision-makers: the maintainer

## Summary

- An enemy first advances its animation and then chooses the clip of its state, so a clip chosen on a step is the one that advances on the next.
- The player does the reverse, and that is correct for the player.
- Never swap the two calls in `enemy_update_animation`, never move the call to the Step event, and never add a second call to catch up. The delay is the behaviour of the original code, and nothing that has to be repaired.

## Context and problem statement

When the state of an enemy changes, its sprite shows the new clip one step later. On the reference trace of the enemies, a Balloon spent 235 steps in its attack state and 234 with the attack sprite, measured on 2026-11-12 in the session that migrated the enemies and not repeatable from the repository. It looks like a defect, and one line seems to fix it.

It is not a defect. In the code before the migration, `obj_enemy` advanced the animation in its Step event, and every enemy inherited that event at the top of its own Step. The logic of the enemy then changed its state and asked for the clip, so the clip was shown by the update of the next step. The migration to the presentation controller moved the update to the End Step event and kept the order inside it: advance first, choose after. What is drawn on each frame did not change.

The player works the other way. Its states run in the Step event, and `player_update_animation` chooses the clip first and advances it after, so the player shows the new clip on the step its state changes. That order was the original one too.

## Decision outcome

`enemy_update_animation` keeps its order: `animation_update`, then the publication of `state`, then `presentation_update`, all in the End Step event of `obj_enemy`.

- The enemy keeps the delay it always had, and the player keeps its lack of one.
- The durations that matter to the game are counted by the logic in steps and never by the animation, as [0007](./0007-let-the-logic-own-the-durations-that-matter-to-the-game.md) states, so the delay moves no state change. The mask of each enemy is set once in `Create`, and no logic of an enemy or a bullet reads its sprite or its animation, which was read on 2026-11-12 and is held by no check.

## Considered options

- **Choose the clip before advancing, as the player does** was refused. The enemy would show each clip one step earlier than the original, and every frame of every enemy would differ from the comparison against the original code that [0009](./0009-verify-behaviour-with-rules-replays-and-the-original-code.md) relies on, with no change anybody asked for.
- **Run the animation of the enemies in the Step event, after their logic** was refused for the same reason, and because it changes which event owns the animation, which [ARCHITECTURE.md](../ARCHITECTURE.md) states.
- **Call the controller a second time in the same step to catch up** was refused. It adds a call per enemy and step for a gain that nobody asked for, and a clip would be requested twice.
- **The maintainer asked that nobody try to fix it.** The delay is kept as a fact of the game, not as a debt.

## Consequences

- An enemy has a state and a sprite that disagree for one step after each change. Code that reads the sprite of an enemy to know its state is wrong by one step, so read `state`.
- Only a comment in `enemy_update_animation` guards the order. No check detects a swap of the two calls, because the trace of the enemies that showed the delay was a temporary addition to the replay harness and is not kept, so a swap would pass `python tools/gm.py check`. That is accepted.
- Undoing this decision changes what is drawn for every enemy, so it needs a new ruling and a comparison against the original code by the method of 0009.
