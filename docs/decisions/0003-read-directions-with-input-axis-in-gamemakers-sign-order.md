# 0003. Read directions with input_axis in GameMaker's sign order

## About this document

This record decides how the game turns two opposing buttons, such as left and right, into one number. It is for anyone about to change `input_axis`, `input_axis_pressed`, the player states that call them or `INPUT_OPPOSING_DEFAULT_MOST_RECENT` in the Input configuration. It states the rule, the order of the arguments and what was refused. It does not state how Input is reached, which is [0001](./0001-vendor-libraries-and-adapters.md), or the list of controls functions, which is in [ARCHITECTURE.md](../ARCHITECTURE.md). Update it only when the maintainer rules a change.

- Status: accepted
- Date: 2026-10-16
- Decision-makers: the maintainer

## Summary

- `input_axis(positive, negative)` returns `input_held(positive) - input_held(negative)`, so it gives -1, 0 or 1, and 0 when both are held.
- The positive button goes first, as in GameMaker's `right - left`, so right and down are positive.
- Never call the library's `InputOpposing` from the game, never subtract two held checks by hand in a state, and never reverse the order of the arguments.

## Context and problem statement

Every ground state asks which way the player wants to go. Until January 2026 the project answered in two ways. `player_state_run` subtracted two held checks, which gives 0 when both directions are held. The idle, skid, turn and ground movement code called a wrapper over the library's `InputOpposing`, whose setting `INPUT_OPPOSING_DEFAULT_MOST_RECENT` is `true`, so it gave the direction pressed last. The maintainer described what the player saw: Sonic did not brake well and felt odd, and the turn around often failed when standing still. Commit `7b1ba7a` moved every state to the subtraction.

The cause is an inference from reading the code: the states disagreed on the answer while two directions were held, and the skid, turn and idle states test for 0. It was not reproduced by a test.

## Decision outcome

The game reads a direction only through `input_axis(positive, negative)`, and a press only through `input_axis_pressed(positive, negative)`.

### The rule

- Both buttons held gives 0. Fighting-game players call this the neutral resolution of simultaneous opposing directions (SOCD). Godot's `Input.get_axis` is strength of the positive action minus strength of the negative action, so it cancels the same way.
- The rule has one owner. No state decides it again.
- The functions call only `input_held` and `input_pressed`, so they live in `02. Core/05. Input` and not in the adapter.

### The order

- The positive button goes first, because GameMaker writes it that way. The official platformer tutorial computes `move_x = keyboard_check(vk_right) - keyboard_check(vk_left);` and explains that right gets 1 and left gets -1. In a room x grows to the right and y grows downwards, so the vertical form is `input_axis(vb_down, vb_up)`.
- The maintainer ruled that GameMaker is the base of everything: the negative-first order is a rule imposed by Godot and by Input, and if both ever disappear, GameMaker remains.
- The names `positive` and `negative` in the signature state the order.

## Considered options

- **The library's `InputOpposing` with its default.** Refused because the last pressed direction wins, which is the answer the states disagreed on.
- **`InputOpposing` with the most recent setting turned off.** Refused because it reverses the order of the arguments, which is the confusion this record removes.
- **The subtraction written in each state.** Refused because the rule would have many copies, which is how the states came to disagree.
- **`input_axis_x()` with no arguments.** Refused because the debug state moves vertically too and needs the same rule for up and down.
- **Negative first, as Godot and Input write it.** Refused by the maintainer for the reason above.

## Consequences

- Undoing the decision, by mixing `InputOpposing` with the subtraction again, brings back the disagreement between states while two directions are held.
- Making the last pressed direction win changes `input_axis` once and changes how skid and turn feel in every state.
- The order is the opposite of Input's, and that is accepted. A reader who knows Input must read the parameter names.
- No automated test holds the rule. It holds by a manual check: hold both directions and the player stays still, and turn around repeatedly from standing still.
- `player_state_debug` still subtracts by hand, so the rule has a second copy there, which is item 7 of [PENDING.md](../PENDING.md).
- The Godot documentation, the Unity documentation and the description of SOCD were read as search summaries and not in full. The GameMaker tutorial was read in full.
