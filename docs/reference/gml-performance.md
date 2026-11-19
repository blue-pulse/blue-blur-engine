# GML performance

## About this document

This document describes how GML code costs time on the two GameMaker runtimes, the VM and YYC, and how far a measurement of that cost can be trusted. It is for a programmer who has to predict the cost of a piece of GML, choose between two ways of writing it, or judge a benchmark. It covers the cost of common operations, where locals are built, inlining, struct access, the cost of code that runs cold, the limits of the timer and of repeated runs, and what differs between the VM and YYC beyond speed. It leaves out how to make a game fast in general and any advice on a particular design. Update it when the runtime version changes, by measuring again, or when the manual changes one of the pages it cites.

Each claim carries a mark. **Manual** means the GameMaker manual states it, read from the `develop` branch of [YoYoGames/GameMaker-Manual](https://github.com/YoYoGames/GameMaker-Manual) at commit `b4459e2` (2026-10-01). **Measured** means it was observed on runtime 2026.0.0.23, or on 2026.1.0.28 where a section says so, on Windows 11, one machine, on the date given, and it was not repeated on another machine. **Unverified** means it is an explanation that no measurement separated.

## Cost of common operations

Probes of 10⁶ iterations on runtime 2026.0.0.23 on 2026-10-18 and 2026-10-19, order of magnitude only, with about 20 ns of noise on the VM (**Measured**, reported by [Resnip record 0017](https://github.com/blue-pulse/resnip/blob/8a8f746/docs/decisions/0017-enter-the-next-frame-in-the-step-and-allocate-only-what-is-used.md)):

| Operation | VM | YYC |
| --- | --- | --- |
| Call to a function with no locals | ~40 ns | ~4 ns |
| Call to a function with at least one `var` | ~190 ns | ~11 ns |
| Each extra `var` | ~20 ns | ~5 ns |
| A function that writes an argument, which every default argument does | +~50 ns | +~55 ns |
| Read of a field of a struct | ~27 ns | ~8 ns |
| Create a struct of 8 and of 17 fields | ~800 and ~1,400 ns | ~700 and ~1,100 ns |
| Memory of a field of a struct | 16 B | 16 B |
| Memory of an empty array | ~320 B | ~336 B |

The VM builds the locals of a function when it runs the first `var`, so a guard that returns before any `var` costs almost nothing there. YYC builds every local when it enters the function, used or not (**Measured**, same source).

A local that replaces a repeated read pays for itself on YYC. Reading a struct held in an instance variable once instead of eleven times saved about 16 ns per read removed in a real step on YYC (**Measured**, 2026-11-12). On the VM the same kind of change can lose, because each extra `var` costs more there, and a function that gained on YYC was slower on the VM in the paths that took its new locals (**Measured**, 2026-11-12).

## Inlining

`gml_pragma("forceinline")` asks the C++ compiler of YYC to inline the function. The request is not guaranteed, it grows the executable and the compile time, and it is valid only on YYC (**Manual**, `gml_pragma`). The VM never inlines.

Marking a function of about 40 lines that runs once per step gave no gain that could be told from noise on YYC: +0.05 µs, 95 % interval [−0.15, +0.24] (**Measured**, 2026-11-12). Resnip reached the same result for its own functions, and marked none (record 0017 above).

### Removing the request from 51 functions

Measured on runtime 2026.1.0.28, Windows 11, one machine, on 2026-11-19, in a program of 3,121 files where 115 own functions carried the pragma. Build A kept all 115, build A2 was a second build of the same code, and build B removed the pragma from the 51 functions whose body is longer than 3 lines, except the getters, setters and `is` queries. All three builds were YYC builds from an empty cache, with the same temporary timers.

Method:

- `get_timer()` at the borders of contiguous segments of the per-frame events: the player step in 6 segments and its draw in 2, the camera in 2, the interface, and one call of a manager, 13 segments in all. A segment that holds no marked function served as the control. For the scenario with enemies, the call of each marked function that runs once per instance was timed alone.
- Two recorded sessions drove the game. The first has 7,779 steps and no enemies. It ran in 8 rounds of the 3 builds, with the order rotated, and the first round was dropped as a warm-up. Three runs were dropped because the control segment rose from 1.7–1.9 µs to 2.2–2.7 µs, so the machine had moved and not the code. 5 runs of A, 7 of A2 and 6 of B were kept. The second session has 5,766 steps with enemies, 1 warm-up round and 4 kept rounds, with no run dropped.
- Welch's 95 % interval of B minus A, and A2 minus A as the noise of an identical build, as a difference counts only above it.

Results, in µs per step unless said otherwise (**Measured**):

- Player step without enemies: A 70.7, A2 70.4, B 69.6. B minus A is −1.13 [−2.40, +0.15] and A2 minus A is −0.29 [−0.91, +0.34]. Of the 13 segments, 3 ran slower without the pragma by 0.03 to 0.15, with the largest on a function of 0.65 µs that runs once per step (+0.15 [+0.06, +0.25]), 3 ran faster by 0.16 to 1.07 and 7 could not be told from the noise.
- Session with enemies, per call: +0.10 [+0.00, +0.20] for a 4-line function called 11,103 times, +0.17 [+0.01, +0.33] for the same function in another event called 2,398 times, +0.13 [+0.08, +0.18] for a 6-line function called 1,645 times, and +0.03 [−0.00, +0.06] for the same one called 10,040 times. Averaged over the steps that is 0.19, 0.07, 0.04 and 0.05 µs. The whole step differed by +0.86 [−1.02, +2.73] and A2 minus A by +1.53 [−0.35, +3.41].
- Build: from the start of the build command to the first line the game prints, the median was 108.9 s for A and A2 over 22 builds and 88.5 s for B over 11, which is −20.4 s or −18.7 %. The executable went from 13,098,496 to 12,810,752 bytes, −287,744 bytes or −2.2 %, and the data file did not change. That is about 0.4 s of build time and 5.6 kB of executable for each function.

What follows from it:

- Inlining a function that runs once per step, or a few thousand times in a session, gained under 0.2 µs per call on YYC, and no function reached 0.5 µs per step in the real step.
- The cost of the request is certain and the gain is not, so a longer function is better left without it unless a measurement of the real step shows a gain.
- Not measured: functions of 3 lines or fewer, and the getters, setters and `is` queries, which kept the pragma in both builds.

## Struct access

A struct variable whose name is a constant at compile time, as in `s.name` or `s[$ "name"]`, is looked up by a hash computed at compile time. A name that is only known at run time, such as `s[$ name_variable]`, has its hash computed at run time. The struct functions get the same treatment (**Manual**, Compiler Optimisations).

One earlier probe on YYC still saw `s[$ "literal"]` cost about 11 ns more than `s.name`, and a read of an absent key about 16 ns more (**Measured** once, not repeated). Treat the difference as unsettled and too small to steer a design.

## Cold code

A function called once per step, after tens of microseconds of other code, costs several times what the same function costs in a hot loop (**Measured**, YYC, 2026-11-12):

| Code | First call in the step | Second call right after | Hot loop of 20,000 calls |
| --- | --- | --- | --- |
| A function that copies 11 instance variables into a struct | 1.78 µs | 0.78 µs | 0.24 µs |
| A controller that walks small structs and calls functions through variables | 12.46 µs | 5.46 µs | 1.72 µs |

The first call came after about 50 µs of other logic in the same event. The rows are means over 5 runs of about 7,600 steps each, and the spread between runs was 0.02 to 0.5 µs. The hot loop is the median of 9 repetitions with an empty function subtracted.

What follows from it:

- A hot loop underestimates the cost of such code in a real step by 5 to 7 times. Use it to rank two ways of writing one function, never to predict what a frame will pay.
- Most of the cost is the cost of arriving cold, not of any one line. Removing repeated reads saved a tenth of the cost. An early exit that skipped three statements saved nothing measurable (0.00 µs, [−0.16, +0.15]), and neither did inlining a function or removing a call.
- The cause was not separated. Instruction cache, data cache and the timer itself running cold are all possible (**Unverified**).

## Measuring

- `get_timer()` returns the time since the game started in microseconds (**Manual**). The values seen are whole microseconds, so one reading cannot resolve less than 1 µs, and only an average over many steps can (**Measured**).
- A pair of `get_timer()` calls costs about 0.14 µs on YYC (**Measured**, two timers in a row, 2026-11-12).
- Between runs of the same build, the mean of a whole event over about 7,600 steps varied by about 4 percent. A run that timed contiguous segments of the event varied by 1 to 2 percent per segment (**Measured**, YYC, 2026-11-12).
- A second build of the same code moved a segment that no change touched by about 0.9 µs, so a difference under about 1 µs in a total cannot be told from an effect of the build (**Measured**, YYC, 2026-11-12).
- The first run after a build was once far off the rest, 98 µs against about 70 µs, while the same round of an identical build was not (**Measured**, YYC, 2026-11-12). Decide before running that the first round is a warm up and drop it.
- With 5 runs per build and 4 percent noise, the smallest difference in a whole event that a test with α 0.05 and power 0.8 can detect is about 7 percent. A difference of 1 percent needs about 280 runs per build (computed with the normal approximation).

## The VM and YYC beyond speed

- The same logic printed the same values on both runtimes over about 25,000 steps of recorded play, including positions printed to three decimals and the fractional `image_index` of a sprite (**Measured**, 2026-11-12).
- `with (object)` on a parent object visited the instances of one room in a different order on the VM and on YYC, so output written inside such a loop must be compared per step without its order (**Measured**, 2026-11-12). The manual states no order for `with` (**Manual**, `with`).
- A YYC build fails to link after a macro changes if the cache of the previous build is kept, with `LNK2001` on symbols named `gs_constArg` (**Measured**, 2026-11-12). Delete the cache before each build that follows a change of a macro.
