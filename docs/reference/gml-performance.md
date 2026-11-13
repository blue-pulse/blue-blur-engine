# GML performance

## About this document

This document describes how GML code costs time on the two GameMaker runtimes, the VM and YYC, and how far a measurement of that cost can be trusted. It is for a programmer who has to predict the cost of a piece of GML, choose between two ways of writing it, or judge a benchmark. It covers the cost of common operations, where locals are built, inlining, struct access, the cost of code that runs cold, the limits of the timer and of repeated runs, and what differs between the VM and YYC beyond speed. It leaves out how to make a game fast in general and any advice on a particular design. Update it when the runtime version changes, by measuring again, or when the manual changes one of the pages it cites.

Each claim carries a mark. **Manual** means the GameMaker manual states it, read from the `develop` branch of [YoYoGames/GameMaker-Manual](https://github.com/YoYoGames/GameMaker-Manual) at commit `b4459e2` (2026-10-01). **Measured** means it was observed on runtime 2026.0.0.23, Windows 11, one machine, on the date given, and it was not repeated on another machine. **Unverified** means it is an explanation that no measurement separated.

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
