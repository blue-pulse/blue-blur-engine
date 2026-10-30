# 0008. Build the animations once and share them

## About this document

This record decides where the animations of a character or an enemy are built and how a new character gets them. It is for anyone about to build clips in the `Create` event of an instance, copy the rows of a character to make another, or free the transitions of an instance. It states what is shared, what a character provides and how a missing clip is handled. It does not cover the transitions, which are [0005](./0005-use-one-mechanism-for-transitions.md). Update it when a character or an enemy needs something that this structure cannot give.

- Status: accepted
- Date: 2026-10-29
- Decision-makers: the maintainer

## Decision outcome

### One set for each type

The clips, the transitions and the rows of a type are built once and read by every instance. This is the Type Object of Nystrom, where the data shared by all objects of a kind lives in one object and not in each instance.

- A character builds its clips in `<character>_create_animations` and keeps them in a `static`, so the first instance builds them and the others read them. An enemy has one function, `<enemy>_init_animations`, that does the same for its clips and rows.
- A `static` runs its initialiser once with the `self` of the first caller, so the function that holds it belongs to one character. A shared function could not hold it, because it would be shared by all characters.
- An instance keeps only its playback, the last state it saw and the last value of each counter.
- The transitions are registered once, and there is no `animation_free` and no `Clean Up` event for them.

### Base rows and clips by character

This is the Animator Override Controller of Unity, where the structure is shared and each character replaces the clips.

- `player_create_presentation` holds the rows of the states every character shares, as data that names a clip by key. A character gives it its clips and the effects it owns, such as the jump ball of Sonic.
- Sonic uses the shared rows as they are. A character with a state of its own would add its rows to the array that `player_create_presentation` returns, in its own folder, and no character does this yet.
- `player_define_fallbacks` lists, for each key, the key that plays when a character has no clip for it, and every chain ends at `idle`. `player_resolve_clips` fills what is missing and prints a warning for each one that says which clip plays in its place. A character without `idle` prints an error.
- A character with no transitions registers none, and its clips play with nothing between them.

A new character adds files to its own folder. It edits no file of the base. The character roster is outside the animation: `_setup_globals` and `game_reset_player` name `obj_sonic`, and a new character must be added there. The rule for the dependency of characters freezes them as four uses in two files.

## Considered options

- **Each character copies all the rows of a sibling.** Refused. It repeats the 124 lines of the shared rows for each character, and a change to a shared state has to be made in each copy.
- **Build the clips in the `Create` of each instance.** Refused. The registry of Resnip holds its clips until they are removed, so each instance had to remove its transitions in a `Clean Up` event, and each load of a stage rebuilt about 45 clips.
- **A third level of transitions by default.** Refused in [0005](./0005-use-one-mechanism-for-transitions.md).

## Consequences

- Undoing the decision brings back the rebuild of the clips at each load and the cleanup event, and makes a new character copy a sibling.
- Over a scripted scenario of 424 steps, a character reduced to two clips, `idle` and `stroll`, ran with 26 warnings and no error, and played `idle` or `stroll` in every state from the step where it was set, step 5. The logic of that run was identical to the original. This ran in a temporary block of the replay manager, which was removed, so it cannot be repeated from the repository.
- The checks that keep this structure, such as a row for every state and an `idle` for every character, are listed in [0009](./0009-verify-behaviour-with-rules-replays-and-the-original-code.md).
- The Type Object page of Nystrom and the page of Unity about the Animator Override Controller were read on 2026-10-29 through the summary of a fetch tool. Nystrom notes that type-specific behaviour is harder to give than with subclasses, and a character here differs by data and not by behaviour.
- The warning text names the object of the instance that called, which for a character is the character.
- The cost with 200 instances of one enemy is 0.77 µs for each on YYC and 3.10 µs on the VM for the whole step of the animation, of which the controller is 0.15 and 0.80 µs. A pass of 200 takes 154 µs on YYC and 621 µs on the VM. Method: the same temporary block as in [0004](./0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md), 200 instances of the Buzzer, 100 passes, median of 9 repetitions. The culling of the stage deactivates the instances away from the camera, so the real number is lower.
