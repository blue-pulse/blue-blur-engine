# Pending work

## About this document

This document is the project's long-term backlog. It is for anyone choosing what to work on next, or who needs to know what is deliberately unfinished.

Each entry states the problem, the shape of the fix, and how you know it is done, so you can pick it up cold. Entries are ordered by priority and carry no dates. Items cite each other by number, so a closed item keeps its number with a one-line note and nothing is renumbered.

It does not record what was done, because the code and git record that. It holds no rules, which are in [CONTRIBUTING.md](./CONTRIBUTING.md), and no deliberate choices, which are in [decisions/](./decisions/). Nothing here is acted on unless the maintainer asks.

Update it when an item is found, changes shape, or closes.

## 1. Finish the folder reorganization

Problem. The project follows the structure rules in [CONTRIBUTING.md](./CONTRIBUTING.md) only in part. The `Vendor` and `Core` folders follow them. The other domains still use the legacy numbered folders: the leftovers of `2. Framework`, `3. Visuals`, `4. Player`, `5. Enemies`, `6. Items`, `7. Stages` and `8. Usable`. Until they move, the layout of those domains is provisional.

Shape. Migrate one domain at a time, so that each step leaves the project opening and running.

Done when no legacy numbered folder remains and every folder satisfies the `S` rules.
