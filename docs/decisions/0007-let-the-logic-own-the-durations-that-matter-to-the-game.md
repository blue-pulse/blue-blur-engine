# 0007. Let the logic own the durations that matter to the game

## About this document

This record decides who owns a duration that the game depends on, and who owns the speed of the game. It is for anyone about to make a state or an enemy wait for the end of an animation, fire on a frame number, or change the game speed from a new place. It states the rule, the values of the player and of the enemies and what changed with them. It does not cover the facts that the logic publishes, which are [0004](./0004-publish-the-facts-of-the-logic-and-let-the-animation-follow-the-state.md). Update it when a duration or a rule changes.

- Status: accepted
- Date: 2026-10-29
- Decision-makers: the maintainer

## Summary

- A duration that the game depends on is a number of steps in the logic. The animation follows it and never sets it.
- One function owns the game speed and scales the clock of the animation with it, so a clip lasts the same number of steps at any speed.
- Never wait for the last frame of a clip, never fire on a frame number, and never change the speed of the game from outside `game_set_step_rate`.

## Context and problem statement

The turn of the player, the turn and the attack of the enemies, and the fade of the Newtron ended when a clip reached its last frame, and the enemies fired on a frame number. A change to the art, such as a new frame count or a new speed of the sprite, changed the game. A change of the game speed changed how many steps a clip lasted, because Resnip reads the speed of the game at each step.

## Decision outcome

### The logic counts steps

The logic has no delta time and counts steps, as the game loop of Nystrom and the fixed step of Fiedler do. The simulation advances in constant steps and the rendering only reads. A duration is a parameter set in the configuration of the player or in the `Create` of an enemy, and one counter counts it.

| Where | Parameter | Steps |
| --- | --- | --- |
| Player turn | `turn_steps` | 4 |
| Player turn from a skid | `skid_turn_steps` | 12 |
| Buzzer and Motobug turn | `turn_steps` | 4 |
| Buzzer attack | `attack_steps`, `fire_at_step` | 56, 32 |
| Balloon attack | `attack_steps`, `fire_at_step` | 36, 30 |
| Newtron | `fade_in_steps`, `attack_steps`, `fire_at_step`, `fade_out_steps` | 12, 60, 30, 12 |

Every value is the length the original code gave. The values of the player were timed by hand playing the original. The values of the enemies were read from a trace of the enemy code on a session recorded by the maintainer, before the enemies changed, counting the first step of a state as step 0 of that state.

If the art is moved, the picture and the bullet can disagree, and the game still works. That is the failure the design accepts, because it is cosmetic and not structural.

### Rules the maintainer approved

- The Buzzer and the Balloon fire one bullet at `fire_at_step`. The original fired 4 and 6 in consecutive steps, one for each step of the frame, 24 and 36 in the recorded session, and they overlapped into one streak. The sound probably hid it, because the shot is played in the mode that replaces the one playing, which was inferred from the name of the mode and not checked in EasyAudio. The bullet is now the size of its sprite, which is shorter and has a smaller hitbox.
- The turn with a skid is chosen when the previous state was the skid. The original chose it when the speed equalled the deceleration, which also fired from the running state at exactly that speed. No recorded run showed a difference between the two rules.
- The Motobug, the Newtron and the Chopper fix their collision mask to the sprite they start with. The mask followed the sprite shown before, and the sprites of the Motobug are 30 pixels wide while it moves and 24 while it turns.
- The monitor bounce while the player is hurt keeps the hurt animation. The original played the slow fall in any airborne state that was not rolling.
- A turn after a roll or a fall lasts 4 steps like any other turn, and the landing clip that plays first is cut short. The original waited for the last frame of that clip and lasted 8 steps. The maintainer approved it. The first two recorded sessions had no such turn, and a session with enemies showed it.

### One owner of the speed

`game_set_step_rate` sets the game speed and the scale of the default clock of Resnip to the rate over `MAX_FPS`. `framework_start` and `game_reduce_power` call it, and nothing else changes the speed. At 60 steps per second the scale is 1.

## Considered options

- **Let the clip set the duration and read it from the logic.** Refused, because it makes the art a part of the rules, which [0006](./0006-replace-a-read-of-the-animation-by-explicit-state.md) shows breaks without a warning.
- **Frame scripts of Resnip that tell the logic the end of a clip.** Refused for the logic. The reference of Resnip says a frame script runs for each frame the playback enters, so a clip replaced early never runs it, which is inferred from that line, and the game cannot depend on it. They stay for sound and particles.
- **Scale the game by delta time.** Refused, because the project counts steps and has no delta time.

## Consequences

- Undoing the decision makes a re-timed sprite change the length of an attack, and a change of the game speed change how long a clip lasts. With the owner of the speed in place, the replay at 30 and at 120 steps per second gave the same logic and the same picture as at 60 on a scripted scenario of 424 steps.
- The Buzzer fires at the same step as the first bullet of the original, and the enemy traces of position, state and frame match the original in all the other columns over the 5,678 steps that a recorded session of the maintainer reaches. That session ends in a death. Whether a bullet reached the player in it was not checked.
- The rule for the skid turn and the fixed masks were not exercised by a recorded session, so their effect is not measured.
- The practices behind it are the Game Loop of Nystrom and Fix Your Timestep of Fiedler. The page of Fiedler was read on 2026-10-29 through the summary of a fetch tool. The Game Loop chapter of Nystrom was not read.
