# 0010. Accept the cost of the generic presentation

## About this document

This record decides how much the presentation may cost and which ways of making it faster are refused. It is for anyone about to speed up `presentation_update`, a selector, `player_publish_facts`, `player_update_animation`, `enemy_update_animation` or `animation_play`. It covers the measured cost, its cause, what was applied and every option that was refused with its reason. It does not cover the boundary between the logic and the animation, which is [0004](./0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md), the sharing of rows and clips, which is [0008](./0008-build-the-animations-once-and-share-them.md), or how a cost is measured, which is [0011](./0011-measure-a-cost-in-the-real-step-against-a-rebuild.md). Update it when the cost is measured again or when the maintainer rules a change.

- Status: accepted
- Date: 2026-11-12
- Decision-makers: the maintainer

## Summary

- The presentation costs about 6.8 µs more per player step on YYC than the code it replaced, mostly because it runs cold, and that cost is accepted.
- A change for speed is kept only if it gains at least 0.5 µs per step in the real step and keeps clear names. Clarity comes first.
- Never skip `animation_play` because the clip looks unchanged, never skip the update of the trail, and never move the animation of an enemy to the Step event. Each one changes what is seen.

## Context and problem statement

Moving the clip requests out of the states into a controller that reads rows of data made the player step slower. Measured on YYC by contiguous segments of the step, over the recorded session `session2` of 7,779 steps, 4 kept runs per build, the step went from 64.1 to 71.0 µs, +6.8 µs net, 95 % interval [+4.9, +8.8]. The controller and `animation_update` rose 8.1 µs, publishing the facts added 1.9, and the states fell 3.0 because the requests left them. A segment that no change touched moved −0.09 µs, and a second build of the same commit differed by −1.2 [−3.3, +0.9]. That is 0.04 percent of a frame of 16,667 µs.

The cost is not in a slow line. Called twice in a row inside the real step, the second call cost 44 percent of the first for `player_publish_facts` and 37 percent for `presentation_update`, so about 61 percent of the 10 µs those two cost is the penalty of running cold after about 50 µs of other logic. Inside the controller, on a running step, the dispatch and guard cost 2.6 µs, walking the bands of the ladder 3.3 µs, and `resnip_set_speed` with `resnip_play` 3.6 µs, which the old code already paid inside the state.

An enemy at rest costs about 1.9 µs per step on YYC, 0.25 µs more than before, measured with 200 Buzzers stepped by `event_perform` in a `with`. With 30 enemies in view that is about 7 µs per frame. Whether only the first enemy of a step pays the cold start was not measured.

## Decision outcome

The generic controller, the rows and the selectors stay, and their remaining cost is accepted. The maintainer set the criterion: clarity first, and a change for speed is kept only if it gains at least 0.5 µs per step and is written with clear names.

Applied in commit `3381d2e`, identical to the code before it in 9 recorded scenarios and the trace of the enemies, on the VM and on YYC:

- The controller keeps the `follow` list of a row when the state changes, in `presentation_follow`, and reads `entry` only on the step a state starts. The controller segment fell by 0.51, 0.53 and 0.63 µs on YYC in three sessions, each interval excluding 0, together with the next item.
- `selector_ladder` reads the bands, their count, `from`, `map` and `limit` once into locals. Its guard still comes before any `var`.
- `player_publish_facts` reads `presentation_facts` once into a local. It saved 0.08 to 0.17 µs, under the threshold, and was kept for clarity.
- The controller returns at once when the state did not change and its row has no `follow` list. It saved 0.00 µs, [−0.16, +0.15], and was kept for clarity at the maintainer's request.

On the VM the same changes moved the controller −0.30 µs, [−1.02, +0.41], and the whole step −0.15 µs. The ladder states got slower there, +0.9 µs in `run` and +1.1 µs in `roll`, which fits the cost of a local on the VM, and that is accepted because YYC is what ships.

## Considered options

- **Skip `animation_play` when the requested clip equals `animation`** was refused, because it is not identical. `animation` is the clip last requested and not the one that plays. When that clip ended with no `next` or its playback is stopped, `resnip_play` with `restart: false` starts it again, and the skip would leave it stopped. On the ladder the pace changes almost every step, so the condition would rarely hold anyway.
- **Skip the update of the trail while there is no trail** was refused, because `trail_alpha` decays by a factor each step and reaches exactly 0 only about 9,000 steps later, so the skip changes an alpha that is drawn.
- **Run the animation of an enemy in the Step event** was refused, because the enemy shows its state one step late today and the reference traces depend on that offset, as [0012](./0012-keep-the-enemy-animation-one-step-behind-its-state.md) states.
- **Let `enemy_update_animation` skip the controller while the state does not change** was refused. It would answer in the enemy a question the rows answer, and an enemy with a `follow` list would stop reacting without a warning. The early exit above gives the same result inside the controller.
- **Normalize the rows to read every field with a dot, or flatten the ladder parameters into arrays** was refused. Removing repeated reads saved a tenth of the cost, so a denser layout attacks the wrong part, and it makes the rows harder to read and to share, against 0008.
- **Merge `selector_while_fact` into the ladder, or publish only the facts that changed** was refused. Each saves about 0.4 µs by the profile and mixes two responsibilities or adds a second path.
- **Mark `presentation_update` with `forceinline` and write the trail division inline** was measured and refused: +0.05 and +0.25 µs, both intervals including 0.
- **Write one function per mode instead of generic selectors** was refused by the maintainer, because it reopens 0004 and 0008 with no data that it would close the gap.

## Consequences

- About 6 µs per player step on YYC stay above the code of `df4a301`, and that is accepted as the price of 0004 to 0008.
- If `presentation_set` is replaced while the state does not change, the controller keeps the old `follow` list, as it already kept the old row. Today the set is replaced only in `Create`, before the first `presentation_update`.
- The cost of `resnip_play` with options belongs to Resnip, which is reported upstream as item 10 of [PENDING.md](../PENDING.md).
- Reopening this record needs a new measurement by the method of 0011, not a new reading of the code.
