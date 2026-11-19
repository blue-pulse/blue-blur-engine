# 0013. Choose the verification by what a change can alter

## About this document

This record decides how much verification a change gets, from reading the diff to a batch of replays, and on which runtime. Read it before you choose how to verify a change, ask the maintainer for a batch of runs, share a build with a player or report how a change was verified. It covers the classes of change, the evidence each class needs, the two stages and their runtimes, how scenarios are selected, which references are kept, and what no replay can verify. It does not cover how a change of behaviour is compared with the original code, which is [0009](./0009-verify-behaviour-with-rules-replays-and-the-original-code.md), how the harness works, which is [replay](../components/replay.md), or how a cost is measured, which is [0011](./0011-measure-a-cost-in-the-real-step-against-a-rebuild.md). Update it when the cost of a batch changes, when a class proves too weak, or with a new ruling from the maintainer.

- Status: proposed
- Date: 2026-11-19
- Decision-makers: the maintainer ruled that a small change never justifies hours of runs and that the VM serves while developing and YYC is the step before a player sees the game, and the classes below were proposed in the same conversation for the maintainer to accept

## Summary

- Classify a change by what it can alter, and give it the evidence of its class and no more: a search for a rename, a written proof and one scenario for an equivalent rewrite, and a comparison for a change that can alter behaviour.
- While developing, compare on the VM against the code before the change. Before a build goes to a player, compare on YYC against the last build that was shared, once for all the changes since then.
- Run only the scenarios whose lines reach the changed code, and reuse the stored outputs of a reference while nothing they depend on changed.
- Never run a batch that the class of the change does not ask for, never share a build without the YYC comparison, and never report as verified by replay code that no scenario reaches.

## Context and problem statement

A replay on YYC is slow because the scenario is a macro, so each scenario needs its own build. Measured on 2026-11-19 on one machine, a YYC build took a median of 88.5 s to reach the first line of the game, a scenario took 93 to 276 s from build to exit, and the 9 scenarios with segments took 20 to 25 minutes on one tree and twice that when the reference was rebuilt too. The 25,476 steps of the 9 scenarios play in about 7 minutes at 60 steps per second, so most of the time is spent in builds. A timing comparison by the method of 0011 took longer still, about 96 minutes for 8 rounds of 3 builds on one scenario. Every batch needs the user's machine left alone, as `A014` asks.

0009 decides that a change of behaviour is compared with the original code, but it does not say how much of that a given change needs or on which runtime, so every change risked a full batch on YYC. Most changes cannot alter behaviour at all. A full batch is also not complete: no scenario reaches the title, the home screen, the pause menu or the menus, as the limits of [replay](../components/replay.md#limits-and-gaps) record. A setter called only on the way to the title, renamed on 2026-11-19, would not have run in any scenario.

The maintainer works on the VM while testing, because the game is opened and closed constantly, and uses YYC when the point is to feel the game as a player would, as the step before giving it to a player or running a test with an external player. `V004` already states that split. The comparison of a change has to follow it.

## Decision outcome

### Classify the change by what it can alter

The class follows from an impact analysis of the change, in the sense of the ISTQB glossary, which defines it as identifying the work products a change affects. When a change could fit two classes, it takes the higher one.

| Class | What the change can alter | Examples | Evidence |
| --- | --- | --- | --- |
| 1 | Nothing that runs in the game | Documents, comments, rules, `tools/` | Read the diff, and run `python tools/gm.py check` when `tools/` changed |
| 2 | Names only | A renamed symbol, resource or folder, a macro renamed with the same value | A search for the old name in all text that finds nothing, including the four forms a compiler cannot see (strings, keys such as `s[$ "name"]`, interpolations such as `$"slot_{index}"` and the keys of data tables), and `docs/` and `tools/`, then `check` and a compile that reaches `DoIcon`. No replay |
| 3 | The form of code whose result is proven to stay the same | An explicit comparison for a bare number, a removed return nobody reads, a removed pragma | A written proof by reading, which lists every write of each value involved and shows the result is equal for every reachable value, then one scenario whose lines reach the changed code, compared on the VM with the stored outputs of the reference |
| 4 | Behaviour, or anything a proof does not settle | Physics, collision, states, animation, the order of a step, an update of a library | The comparison of 0009 on the VM, on every scenario that reaches the changed code, and on all of them when the change is in code that every step runs, such as the player step |

A claim about speed is not a class. It follows 0011, only when the claim is made, and on YYC, because the pragma and the cost of a build exist only there.

### Two stages, two runtimes

| Stage | Runtime | Compared with | When |
| --- | --- | --- | --- |
| Development | VM | The VM outputs of the last shared build | Each change of class 3 or 4 |
| Shared build | YYC | The YYC outputs of the last shared build | Once, before a build goes to a player, over every scenario that reaches the code changed since the last shared build |

A shared build is any build given to a player, including a test with an external player.

- The VM serves the loop because it starts the game without the C++ build, which is what the maintainer's day to day needs. The time of a VM build was not measured, and the log of the asset compiler reports about 35 s of the 88.5 s or more of a YYC build.
- YYC is the gate because it is what ships, as `V004` states, and what a player feels is what YYC runs. A VM run cannot show what only YYC changes, such as the order in which `with (object)` visits instances or a function inlined by `forceinline`, as [GML performance](../reference/gml-performance.md) records.
- This is the staged build of continuous integration, where a fast stage runs on every change and a slower stage runs the rest, as Fowler's "Continuous Integration" describes with its ten-minute build, and the milestone of Google's TAP, where the targets a change affects run at the next milestone and not on every commit (Memon et al., "Taming Google-Scale Continuous Testing", ICSE-SEIP, 2017).
- A difference found only at the gate is a difference of the runtime until a commit explains it. Both stages keep their own references, and a VM run is never compared with a YYC run.
- When the gate finds a difference, the commits since the last shared build are searched for its cause, with the history of git.

### Select the scenarios by what they reach

- A scenario counts only if its lines show that it reaches the changed code, as 0009 already states. Among the scenarios that do, the shortest one is enough for class 3.
- This is the idea of a safe regression test selection, which keeps every test that traverses modified code and drops the rest (Rothermel and Harrold, "A Safe, Efficient Regression Test Selection Technique", ACM TOSEM, 1997). The project selects by reading the lines of the scenarios and not by a dependency graph, which is a local simplification.
- When no scenario reaches the changed code, the change is reported as not verified by replay, as `V002` asks, and the maintainer checks it by hand.

### Keep the references

- Each stage keeps its outputs for every scenario in `.sandbox/`, which git ignores. They are reused while the commit of the reference, the harness, the scenarios and the runtime stay the same, so a batch builds only the changed tree. That halved the builds of a batch on 2026-11-19.
- After a gate run is accepted, its outputs become the YYC reference of the next gate, with no extra build.
- A difference is explained, fixed or approved by the maintainer, as 0009 states.
- A difference found in class 3 moves the change to class 4.

### The time each class costs

Class 2 costs no run. Class 3 costs one build and one scenario, about 1.5 to 4.5 minutes on YYC as measured, and less on the VM. Class 4 costs up to the full batch on the VM. The batch on YYC is paid once per shared build. This follows the risk-based testing principle of spending test effort in proportion to the level of risk, which Rex Black's risk-based testing material states and ISO/IEC/IEEE 29119-2 follows as a risk-based approach.

## Considered options

- **A YYC run for every change** was refused by the maintainer, because a small change never justifies hours of runs, and the VM already answers whether a change altered the behaviour.
- **The VM only, with no YYC run before a player** was refused, because `V004` ships YYC and a VM run cannot show what only YYC changes.
- **A full batch for every change** was refused by the maintainer, because it costs the same for a rename as for the physics, and it reaches none of the title, home, pause or menus, so it gives confidence it cannot back.
- **No replay for any change, trusting the compiler and a search** was refused, because the compiler does not see a name built at run time, and a mechanical rename once missed a name inside an interpolated string. A proof by reading can also be wrong, so class 3 still runs one scenario.
- **Choosing the scenarios by habit, such as always the two recorded sessions, or at random** was refused, because a scenario that does not reach the change proves nothing about it.

## Consequences

- Most changes are verified in minutes on the VM, and a full YYC batch is paid once per shared build.
- A failure that shows only on YYC is found at the gate, possibly many changes after its cause, and that is accepted.
- A VM reference of every scenario has to be built once, which costs a VM build and a run for each scenario and was not measured. No reference is kept in the repository, so a new checkout builds them again.
- The class is a judgment that holds by attention alone, and the report of a change names the class it took, so a reviewer can disagree.
- A proof by reading can be wrong, and the one scenario of class 3 only catches an error on its own path, and that is accepted.
- Code that no scenario reaches, such as the title, the home screen, the pause menu and the menus, cannot be verified by replay. That is a gap and not a decision, and the maintainer's own sessions cover it.
- A build per scenario is the largest cost of a batch, which item 11 of [PENDING.md](../PENDING.md) tracks.

## Sources

Each of these was read on 2026-11-19 through the summary of a search tool, and none was read in full.

- ISTQB glossary, for impact analysis, regression testing and change-related testing, through secondary reproductions of the glossary and not the official site.
- Rothermel and Harrold, "A Safe, Efficient Regression Test Selection Technique", ACM TOSEM, 1997, for safe selection and tests that traverse modified code.
- Memon et al., "Taming Google-Scale Continuous Testing", ICSE-SEIP, 2017, for running the affected targets at a milestone.
- Fowler, "Continuous Integration", for the ten-minute build and staged builds, through secondary sources that quote it.
- Rex Black's risk-based testing material, for effort in proportion to risk, and ISO/IEC/IEEE 29119-2, which is a paid standard and was not read.
