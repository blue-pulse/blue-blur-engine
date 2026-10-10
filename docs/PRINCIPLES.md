# Principles

## About this document

This document states the design principles behind Blue Blur Engine. It is for anyone who designs, reviews or argues a change to the project. The rules in [CONTRIBUTING.md](./CONTRIBUTING.md) and the records in [decisions/](./decisions/) apply these principles to this project.

It contains what the product is, the six axes every change is judged against and their order, the Bluetooth speaker analogy, and the principles the project applies in practice. It deliberately leaves out any rule specific to one area, which lives in `CONTRIBUTING.md`, and any single decision, which lives in its record.

The principles are written to hold for any software project, so they use the vocabulary of software engineering and not of one genre. Update this document only when the maintainer rules a change of principle.

## What the product is

Blue Blur Engine is a 2D game engine built on GameMaker, with a focus on movement physics. It is designed for Sonic-style games with boost gameplay, and it can be adapted to other genres and styles. It is built from parts that each do one thing, so that adapting it means changing parts and not rebuilding the engine.

- The engine provides the services every game needs. Content such as characters, stages and enemies depends on the engine and never on other content.
- Removing a piece of content leaves the rest working.
- No single game or genre is the product, however much of the code serves one today. Judge scope by that shape.

## The six axes

Every decision is judged against these six, from the most important to the least. A change says how it stands on each, and naming an axis it does not touch is part of the answer.

1. Modularity and systemic thinking. One responsibility per unit, one owner per fact, and a change judged by its effect on the whole system rather than on the file being edited. Two mechanisms answering one question is a defect, and so is a responsibility nobody holds.
2. Established practice before invention. Every decision rests on something nameable and external to the conversation.
3. Resource efficiency and scale by construction, above all for work whose cost grows with something the player or the designer controls. Ask what happens at n, not at two.
4. Long-term sustainability. Prefer retiring a mechanism to adding one, and look first for one that already exists and only lacks a second caller.
5. Scalability, including of content and of people.
6. Cybersecurity, over the CIA triad, with confidentiality, integrity and availability each named separately. For this project that is mostly the files it reads and writes, such as save data, and the code it brings in from outside.

## The Bluetooth speaker

Somebody owns an analog speaker built long before Bluetooth existed, and buys a Bluetooth receiver separately. Opening the case they find no instructions, no labelled socket and no arrow saying where to plug it in. The speaker was never designed for this, and nobody ever asked what would happen if a user wanted Bluetooth one day. An electronics engineer solders the module in anyway, without redesigning the speaker and without buying a different one. That works because the speaker is honestly built out of parts that each do one thing, and its signal path carries a general medium rather than a private arrangement with one source.

Build every solution so that story is possible. Three rules follow from it.

- Build for legibility, not for futures you are guessing at. The speaker earns its upgrade by being comprehensible and cleanly divided, never by being extensible. Give each unit one responsibility, put boundaries where responsibilities differ, never let one unit reach around another to touch a third, and state every interface in the general terms of its domain, such as a signal, a position or a record, rather than in the terms of the only caller that exists today. That is all the future-proofing available, and it costs nothing now.
- A seam is discovered, not installed. You get one by refusing to fuse two different responsibilities, never by putting a layer in front of one. A wrapper with a single implementation, a flag for an absent feature, a hook nobody calls, a branch for hardware that is not there and a field reserved for a case that does not exist are all dust-capped sockets for a port nobody ordered. They make the eventual change harder, because the next engineer has to understand the guess as well as the code.
- Soldering is allowed, reinventing is not. The engineer does open the case, desolder a wire and cut a trace, and editing existing code when the new part finally arrives is expected and correct. The failure to avoid is opening the case to find the amplifier welded to the turntable, so that adding Bluetooth means rebuilding the speaker. Ask it of any design before you commit it: when the part you are refusing to guess at arrives, is the change a soldering job or a rebuild? If it is a rebuild, the defect is here and now.

The engine is built for one genre today and nothing in it is prepared for the others. What is asked of it is that adding another be a soldering job.

## Justify by established practice

- A design decision rests on an authority that is nameable and external to the conversation: a recognised pattern, a documented standard, a battle-tested library, or the way the surrounding code already solves the problem. "This is more efficient" and "this is better long term" are conclusions, not justifications.
- For the structure of a game, the first authority is *Game Programming Patterns* by Robert Nystrom, with patterns such as State, Game Loop, Update Method and Object Pool. After it come the general references, such as the Gang of Four patterns and Fowler's refactoring catalogue.
- For files and data the project does not control, OWASP is the reference. It is applied in proportion to what is at stake and is not the project's main concern.
- For how a feature, a screen or a task should work so that it is intuitive and clear, the first authority is Nielsen's [10 Usability Heuristics for User Interface Design](https://www.nngroup.com/articles/ten-usability-heuristics/). After it come the [Game Accessibility Guidelines](https://gameaccessibilityguidelines.com/), which cover menus, saving, controls and text, and the [Xbox Accessibility Guidelines](https://learn.microsoft.com/en-us/gaming/accessibility/guidelines).
- Name the practice the choice follows and what it is called, so somebody who disagrees can check the reasoning. Where no standard exists, say so and reason in the open.
- Do not reinvent. A specialised concern belongs to something specialised in it, plugged in behind a seam we own so it stays replaceable.
- Departing from a standard is a decision, not a drift. The departure is stated and argued where it lives.
- A source you never read is never implied to be read. Say when you could not reach it, name what you would have checked, and reason from what you do have.

## Resources are scarce

- Efficiency is a constraint applied when the approach is chosen, never a later optimisation pass, and never a licence to trade clarity for speed.
- Work that runs every frame has a fixed time budget. Its cost is chosen with n in mind, and nothing repeats work whose answer has not changed.
- A solution scales because of how it is built, never because the target machine is faster. If the answer to load is "buy better hardware", the design is the defect.

## Secure by default

- Treat every file the project reads as untrusted input, fail closed when it is malformed, and degrade to a safe default rather than crash or continue on corrupt data.
- Obfuscation is not protection, and the documents say which of the two a mechanism is.
- Security is part of the design of a change, never a feature added after it.

## One owner per fact

- Every constant, limit, rule and piece of state is defined in one place, and everything else reads it. A fact with two calculators has no owner.
- Configuration is data kept apart from behaviour, so changing a value never means editing logic.

## Nothing depends on the environment

- The version of the tools, the operating system, the hardware, the input devices and the export target are unknown and will stay partly unknown. A requirement on the environment is therefore a defect in the design, not a note for somebody else.
- Answer each unknown in one of three ways, in this order. Establish it from what the platform actually reports. Beat it by choosing a bound tighter than any plausible default. Or detect it at runtime and degrade.
- Never assume, and never ship a feature whose failure on an unexpected setup is silence.
- Degrade rather than corrupt. When something holds only under an assumption, it says so where it lives and loses accuracy rather than integrity when the assumption breaks.

## Evidence over belief

- Measure before you claim a number, and distrust the instrument before the code. A uniform zero across independent candidates is the instrument before it is the data.
- Record a measurement as its method and its number, so anybody can measure it again, and say what total it was taken over.
- Where a check can be automated, automate it, because a rule nothing checks tends to expire. Such a check is an architectural fitness function in the sense of *Building Evolutionary Architectures* by Ford, Parsons and Kua. Break the check once to prove it can fail.
- Verify on the path a person actually takes, because a shortcut through the system can pass while the real path is broken.

## Show conformance

A change arrives with its reasoning. Its description, such as a commit message or a review request, says which rule governs it, which established practice it follows, which trade-off it takes and why, and how it was verified. A reviewer should never have to rebuild that reasoning from the diff.

Outcomes are reported honestly. A failing check, a skipped step or a working assumption is said plainly, so nobody finds it later by surprise.
