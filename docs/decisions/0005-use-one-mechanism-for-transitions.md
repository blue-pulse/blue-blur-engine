# 0005. Use one mechanism for transitions

## About this document

This record decides how one animation leads into another. It is for anyone about to add a default entrance or exit for a pose, resolve a transition when a clip is played, or register a transition outside the setup of a character. It states the two cases and the one mechanism behind them. It does not cover which clip the controller picks, which is [0004](./0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md). Update it only when the maintainer rules a change.

- Status: accepted
- Date: 2026-10-29
- Decision-makers: the maintainer

## Decision outcome

Resnip has one place that answers what plays next, and the game uses only that.

- An entrance is the `next` of a clip, set with the option `next` of `animation_create`. The clip it leads to is created first.
- An exit is a pair of the registry of Resnip, `animation_add_transition(from, to, via)`, registered once per character when the first one is created. The registration is a `static` guard in `sonic_init_transitions`.
- A character without transitions registers none. Its clips play one after the other with no clip between them.

## Considered options

- **A third level, with a default entrance and exit for each pose resolved when the clip is played.** Refused. It has no user, because nothing asks for a default. It would be a second mechanism for the same question. It also contradicts the data, because the exits depend on the target: the crouch exit plays only toward idle, and the landing plays from 6 clips toward 3 targets, which is 18 pairs and not one default per pose.
- **Expand groups of poses into pairs at build time.** Not built. The 26 pairs of Sonic are registered by hand and no second character needs a group.

## Consequences

- Two mechanisms for one question would let a clip play its entrance twice or in the wrong order, and the registry of Resnip already holds the answer.
- A pose added to a character costs at most one line for its exit.
- The registry holds its clips until they are removed, so the pairs are registered once and shared. [0008](./0008-build-the-animations-once-and-share-them.md) states why.
- The registry and the options `next` and `transition` are described in the reference of Resnip, `docs/reference/resnip.md`. Only its lines about transitions and about what plays next were read for this record.
