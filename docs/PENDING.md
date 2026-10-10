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

Done when each origin has been reviewed, every finding is fixed or rejected with a reason, every borrowed function has its origin and licence recorded, and the player's movement, collision and state code has gone through the passes of item 2.

## 4. Move Input and AESnips behind adapters

Problem. The wrappers around Input and AESnips, such as `input_pressed` and `animation_play`, were never designed. They copy the signature of the library, and the macros `vb_up` and `vb_a` pass the `INPUT_VERB` enum of the library on to the game. This breaks `E002` and `E006`.

Shape. Give each library an adapter folder in `02. Core/10. Adapters`, as [0001](./decisions/0001-vendor-libraries-and-adapters.md) states. Define the verbs in Core and translate them inside the adapter. Offer one function for each use the game has. Then check that a search for `Input` and `snip_` outside the adapter and `Vendor` finds nothing.

Done when no file outside the adapters and `Vendor` mentions a symbol of either library.

## 5. Verify the tools on macOS and Linux

Problem. The tools in `tools/` were only run on Windows. The folders they search on macOS and Linux, and the Igor program they start there, come from reading the source of another tool and not from a run. The manual runs Igor on macOS as `dotnet Igor.dll`, while that source starts a file named `Igor`, so one of the two is wrong.

Shape. Run `python tools/gm.py doctor` and `run` on each system, fix the folders and the command that differ, and mark the result as observed in [reference/igor.md](./reference/igor.md). Then drop the warning the tools print outside Windows.

Done when `doctor` and `run` pass on macOS and Linux and the Igor guide marks those rows as observed.

## 6. Run the project in continuous integration

Problem. Nothing checks that the project still compiles and starts after a change, and the check depends on somebody running it.

Shape. A GitHub Actions workflow that installs the runtime, creates the licence file from an access key kept as a secret, makes the prefabs available on a clean runner, and runs the project. Three points are open, which are how the runner gets the prefabs, whether the game can start there without a screen, and whether Igor passes the exit code of the game on. The two community actions used by other studios, `bscotch/igor-setup` and `bscotch/igor-build`, are the first thing to read. This needs a decision record before it is built.

Done when a workflow runs on every push and fails when the project does not compile.
