# Pending work

## About this document

This document is the project's long-term backlog. It is for anyone choosing what to work on next, or who needs to know what is deliberately unfinished.

Each entry states the problem, the shape of the fix, and how you know it is done, so you can pick it up cold. Entries are ordered by priority and carry no dates. Items cite each other by number, so when an item is finished it is deleted and the others keep their numbers, which means the list can start above 1 and have gaps.

It does not record what was done, because the code and git record that. It holds no rules, which are in [CONTRIBUTING.md](./CONTRIBUTING.md), and no deliberate choices, which are in [decisions/](./decisions/). Nothing here is acted on unless the maintainer asks.

Update it when an item is found, changes shape, or closes.

## 2. Improve the code line by line

Problem. Much of the code works but was not designed on purpose. Some of it was copied without much thought, many values are bare literals, and many names were chosen for being short or good looking at the time. It does not yet follow the rules in [CONTRIBUTING.md](./CONTRIBUTING.md), and there are no automated tests to protect a change.

Shape. Work one domain at a time in dependency order, starting with `02. Core` as a pilot so the patterns are fixed before the larger domains. In each domain make these passes in order, and keep the passes that change behaviour apart from the ones that do not.

- Audit the domain without editing it and group the findings by pass.
- Mechanical pass, with no change in behaviour: comments, language, plain words and formatting.
- Names pass: the user approves a table of renames in one batch before anything is renamed.
- Constants pass: move bare literals into enums, macros and configuration functions.
- Structure pass: split long functions, remove duplication, and look at the engine depending on content and at work that grows with the number of instances every frame. The user approves each change in behaviour first.
- Commit once per domain and pass, with a short manual checklist for the user to run, because the game cannot be run by an agent.

The player's movement, collision and state code waits for item 3.

Done when every domain has gone through all the passes and follows the rules in [CONTRIBUTING.md](./CONTRIBUTING.md).

## 3. Review the physics against its three origins

Problem. The physics and collision code descend from three external projects: one written for another version of GameMaker, an unfinished work in progress that is the origin of this project, and an updated version of that work in progress that has never been read. How far this project matches each of them is unknown, so it may hold bugs they avoid, miss improvements they have, or skip behaviour they implement. Which functions came from which project, and under what licence, is not recorded either (`E003`, `E004`, `E008`). Only ClusterFramework is recorded, by folder, in [NOTICE.md](../NOTICE.md).

Shape. Do it after the rest of the engine works, over several sessions.

- Read each origin to find bugs in this project's implementation, improvements the origin has, and behaviour this project skipped.
- Compare the work in progress with its updated version to see what its author fixed.
- Record the origin and licence of every borrowed function in [NOTICE.md](../NOTICE.md).
- Leave the player's movement, collision and state code out of the code cleanup until then, because this review is likely to rewrite it and renaming it first would make the comparison harder.

Done when each origin has been reviewed, every finding is fixed or rejected with a reason, every borrowed function has its origin and licence recorded, and the player's movement, collision and state code has gone through the passes of item 2, which includes the leading underscore of `S015` on its locals and parameters that `check` warns about.

## 5. Verify the tools on macOS and Linux

Problem. The tools in `tools/` were only run on Windows. The folders they search on macOS and Linux, and the Igor program they start there, come from reading the source of another tool and not from a run. The manual runs Igor on macOS as `dotnet Igor.dll`, while that source starts a file named `Igor`, so one of the two is wrong.

Shape. Run `python tools/gm.py doctor` and `run` on each system, fix the folders and the command that differ, and mark the result as observed in [reference/igor.md](./reference/igor.md). Then drop the warning the tools print outside Windows.

Done when `doctor` and `run` pass on macOS and Linux and the Igor guide marks those rows as observed.

## 6. Run the project in continuous integration

Problem. Nothing checks that the project still compiles and starts after a change, and the check depends on somebody running it.

Shape. A GitHub Actions workflow that installs the runtime, creates the licence file from an access key kept as a secret, makes the prefabs available on a clean runner, and runs the project. Three points are open, which are how the runner gets the prefabs, whether the game can start there without a screen, and whether Igor passes the exit code of the game on. The two community actions used by other studios, `bscotch/igor-setup` and `bscotch/igor-build`, are the first thing to read. This needs a decision record before it is built.

Done when a workflow runs on every push and fails when the project does not compile.

## 9. Pause the game and step it for the dev tools

Problem. The dev overlay cannot pause the game or advance it one step at a time, which inspecting an animation needs. Nothing owns whether the world advances, so a pause would make every Step event ask a flag, and that is a rebuild and not a small change. The debugger of GameMaker pauses and steps already, and it is the tool to use meanwhile.

Shape. Decide first who owns "the world advances", the way `game_set_step_rate` owns the speed, and only then add the pause and the step to the table of commands of `10. Debug`.

Done when the overlay has a pause command and a step command that each act through that one owner.

## 10. Report the cost of a repeated request to Resnip

Problem. Asking again for the snip that already plays, with `resnip_set_speed` and `resnip_play` with options, costs about 500 ns on YYC per call in a hot loop, as [reference/resnip.md](./reference/resnip.md) records. The presentation pays it on every step of the ladder. Resnip is an independent library, so the fix belongs upstream and `Vendor` is not edited (`E001`).

Shape. Reproduce the cost with the benchmark of the Resnip repository, then open an issue at [blue-pulse/resnip](https://github.com/blue-pulse/resnip) with the case and the number. A likely shape is to check `restart: false` against the current snip before reading the other options.

Done when the issue is open with a reproducible number, and the release that fixes it, if any, is taken in through `Vendor` as usual.

## 11. Run every replay scenario from one build

Problem. The replay scenario is chosen by the macro `REPLAY_SCENARIO`, so each scenario needs its own YYC build, and the builds are most of the time of a batch, as [0013](./decisions/0013-choose-the-verification-by-what-a-change-can-alter.md) measures.

Shape. Keep a compile-time switch that turns the harness on, so a shared build stays unchanged, and read the name of the scenario at run time from a source that needs no build, such as a parameter of the executable or a file beside it. Check first that the executable Igor builds can be started again with such a parameter, which has not been tried. Then update [replay](./components/replay.md) to describe it.

Done when one build runs every scenario with lines identical to those of a build per scenario, and the time of a batch is measured again in 0013.
