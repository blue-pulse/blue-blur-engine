# 0011. Measure a cost in the real step against a rebuild

## About this document

This record decides how a claim about the speed of a change is measured before anyone relies on it. It is for anyone about to claim that a change makes the game faster or slower, to propose an optimisation, or to cite a cost in a record. It covers where the timers go, what each comparison is set against, how many runs are needed and when a difference counts, and which methods were refused. It does not cover how behaviour is compared, which is [0009](./0009-verify-behaviour-with-rules-replays-and-the-original-code.md), the decision about the cost of the presentation, which is [0010](./0010-accept-the-cost-of-the-generic-presentation.md), or the cost of GML operations, which is in [reference/gml-performance.md](../reference/gml-performance.md). Update it when a method is tried again or a new source of noise is found.

- Status: accepted
- Date: 2026-11-12
- Decision-makers: the maintainer

## Summary

- Time the change inside the real event that runs it, in contiguous segments, with a segment the change does not touch as a control.
- Compare against a build of the unchanged code in the same session, in rotated order, with the first round dropped as a warm up.
- Never estimate the cost of code that runs once per step from a hot loop, and never report a difference under about 1 µs in a total as a gain.

## Context and problem statement

A hot loop of 20,000 calls estimated the new presentation at about 2 µs per step. In the real step it cost 6.8 µs net, and the code it measured cost 5 to 7 times what the loop said, because a function called once per step after other code runs cold. Before that, a benchmark that timed the whole step and gave one build per tree measured the gap as +8.6 µs with an interval of [+2.8, +14.3], which could not say where the cost was or tell the build from the code. A small change needs better than that: the changes kept in 0010 save about half a microsecond.

## Decision outcome

### Where to time

- Put `get_timer()` at the borders of contiguous segments of the real event, such as the state, the rest of the step, publishing the facts and the animation, so the segments add up to the event. A pair of timers costs about 0.14 µs on YYC, so time segments and not single lines.
- Keep the mean per segment for all steps and for each state, because a change that gains in one state can lose in another.
- Keep one segment that no change touches. If it moves, the build or the session moved it, not the change.
- Drive the game with a recorded scenario of the replay harness, so every run takes the same path.

### What to compare against

- A build of the unchanged code, run in the same session as the change.
- For a new claim about a gap, also a second build of the same commit in another folder. The difference between the two is the noise of a run and a build, and a real difference must be larger.
- YYC first, because YYC is what ships, as `V004` asks. The VM second, to see that a change for YYC does not lose there.
- Delete the YYC cache of Igor before each build.

### How many runs and when a difference counts

- At least 5 kept runs per build, and one more before them that is dropped as a warm up. Decide the drop before running. One first run was 98 µs where the others were near 70.
- Rotate the order of the builds every round, so each runs first as often as last.
- Take the mean of each run as one value, compare with Welch's interval at 95 percent, and report the values of each run beside it.
- A difference counts when its interval excludes 0 and it is larger than the difference between the two builds of the same commit. A second build alone moved an untouched segment by about 0.9 µs, so a difference under about 1 µs counts only within its own segment and never in the total.

This follows what Resnip found for its own measurements: alternate copies and rotate their order, measure more than one case, and treat a difference under the noise of an identical copy as no difference ([Resnip record 0017](https://github.com/blue-pulse/resnip/blob/8a8f746/docs/decisions/0017-enter-the-next-frame-in-the-step-and-allocate-only-what-is-used.md)).

## Considered options

- **A hot loop to estimate the cost of code in the game** was refused, because it underestimated it by 5 to 7 times. It still serves to rank two ways of writing one function.
- **The mean of the whole event with 5 runs per build** was refused, because with 4 percent of noise between runs it can only detect about 7 percent, and a difference of 1 percent would need about 280 runs per build.
- **One build per tree with no second build of the same commit** was refused, because then the effect of the build cannot be told from the effect of the code.
- **Calling the measured function twice in a row and timing each call** was kept only to find the cause of a cost. A tree that runs a function twice is not the game, and its picture differs.
- **A timer on every line** was refused, because each pair of timers adds about 0.14 µs to what it measures.

## Consequences

- A comparison of two builds with 6 rounds of a scenario of 2.5 minutes takes about 30 minutes, plus the builds, and needs the machine left alone, as `A014` asks.
- The timers are a temporary patch on a throwaway copy of the code, so a figure cannot be repeated from the repository alone. Each record keeps the method and the number instead, and that is accepted.
- One machine, one runtime and one scenario were used for the figures cited in 0010. Another machine may shift the totals, and the comparison between builds is what carries over.
- Without this method, a gain of half a microsecond cannot be told from the build, and a hot loop can approve a design that costs several times its estimate.
