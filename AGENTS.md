# AGENTS.md

Blue Blur Engine is a 2D game engine written in GML for GameMaker LTS 2026, with a focus on movement physics. Everything about it lives in `docs/`, and the project is complete without this file.

## Sandbox

This directory is your whole sandbox. Never leave it, not to look for a file you did not find and not to read the user's system. The only exception is a path the user gives you for one specific task (`A011`).

## Read first

1. `docs/CONTRIBUTING.md` in full. Its rules bind you like any contributor, and the ones under code `A` are written for you.
2. `docs/PRINCIPLES.md` and `docs/ARCHITECTURE.md`.
3. `docs/decisions/`, before you change anything that looks wrong.

## Navigating the repository

- The code is in `scripts/<name>/<name>.gml`, one function per script, and in `objects/<name>/<Event>_<n>.gml`, such as `Create_0`, `Step_1` and `Alarm_0`.
- On disk, resources are grouped by type. The folder a resource belongs to in the project is `parent.path` in its `.yy` file. Read it before you edit, to tell third-party code (`folders/1. Vendor/...`) from the project's own.
- A search over `scripts/` returns a lot of third-party code, so filter by that folder.

## Checks

- The repository has no build or test commands. Behaviour is checked by running the game in GameMaker, which you usually cannot do. Report what you could not run (`A006`).
- After a change, run `git status` and `git diff`, and look at every `.yy` file that changed, because the IDE rewrites them (`G002`).
