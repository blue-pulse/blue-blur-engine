# 0000. Record architecture decisions

## About this document

This record is the decision about how decisions are recorded in this project. It is for anyone about to write, supersede or look for a decision record. It states the format, the threshold for a record and the fields each one carries. It does not record any other decision. Update it only when the way records are kept changes.

- Status: accepted
- Date: 2026-10-09
- Decision-makers: the maintainer

## Context and problem statement

Some choices in a project look wrong to a newcomer and are right. Somebody tidies one away, the thing it protected breaks, and the next person rediscovers why it was there. The project needs one place per such choice that says what it is, why it exists and what breaks without it, in a format the industry already knows.

## Decision outcome

Decisions are recorded with MADR (Markdown Architectural Decision Records), which follows Nygard's "Documenting Architecture Decisions", one decision per file in `docs/decisions/`, named `NNNN-title-with-dashes.md` and numbered in order.

A decision earns a record only if a reasonable newcomer would be tempted to change it, and changing it would do harm. It is a fence with its reason written on it, the situation Chesterton's fence describes.

Three things are not records, and each has a home.

| What it is | Where it goes |
| --- | --- |
| A temporary workaround or a known debt | [PENDING.md](../PENDING.md), or a comment beside the code |
| A convention nobody would be tempted to break | One line in [CONTRIBUTING.md](../CONTRIBUTING.md) |
| A description of how the project is built | [ARCHITECTURE.md](../ARCHITECTURE.md) |

Every record carries these fields:

- a title
- status, which is accepted, superseded by NNNN, or deprecated
- date
- decision-makers, written as "the maintainer" where the maintainer ruled
- context and problem statement
- decision outcome
- consequences, which must say what breaks if the decision is undone
- considered options, only where an option was explicitly refused and someone might propose it again

Each record also opens with a short "About this document" section, like every document under `docs/`. A long record adds a "Summary" section after its metadata: a few bullets with the decision and what must never be done, before the detail.

At the repository root, `README.md` introduces the project, and `AGENTS.md` is a convenience that points AI coding agents at the rules. The project must stay complete without it. The documents under `docs/` keep to one layout: `CONTRIBUTING.md`, `ARCHITECTURE.md`, `PRINCIPLES.md`, `PENDING.md`, the records here, and `reference/` for the external libraries the project relies on, once there are any. A reference describes one library alone and cites no other document, so it stays correct whatever happens to the rest. Our documents may cite a reference, and a reference never cites them.

## Consequences

- A record is never rewritten to change its outcome. A new record supersedes it, and the old one's status says so.
- A record states what is true and why. Git keeps how the text changed, so corrections are not narrated in the record.
- A measurement that backs a decision keeps its method and its number.
- A figure that moves over time is stated as it is today, with its date, and re-read before it is cited.
- Without this practice, an unusual choice is only as safe as the memory of whoever made it.
