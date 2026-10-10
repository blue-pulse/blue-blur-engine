# Contributing to Blue Blur Engine

## About this document

This document holds the rules for working on Blue Blur Engine. It is for anyone who works on the project, and it binds everyone the same way. Follow each rule exactly as written. Only the maintainer may override a rule.

It contains what you must always do and what you must never do. It does not explain how the project is built, which is [ARCHITECTURE.md](./ARCHITECTURE.md), and it does not argue unusual choices, which are the records in [decisions/](./decisions/). The principles behind every rule are in [PRINCIPLES.md](./PRINCIPLES.md), and the backlog is [PENDING.md](./PENDING.md).

Each rule carries a stable code, the way Ruff codes its lint rules: a letter for its section and three digits, such as `C003` or `S011`. Cite a rule by its code, in a document, a code comment or a review. Always and Never share one sequence per letter.

| Code | Section | Always | Never |
| --- | --- | --- | --- |
| `C` | Code | [Always](#code) | [Never](#code-1) |
| `S` | Structure | [Always](#structure) | [Never](#structure-1) |
| `E` | External dependencies | [Always](#external-dependencies) | [Never](#external-dependencies-1) |
| `G` | Version control | [Always](#version-control) | [Never](#version-control-1) |
| `V` | Verification | [Always](#verification) | [Never](#verification-1) |
| `D` | Documentation | [Always](#documentation) | [Never](#documentation-1) |
| `A` | Agents | [Always](#agents) | [Never](#agents-1) |

A new rule takes the next free number of its letter and goes at the end of its section. A code is never reused or renumbered, and a retired rule keeps its line as `Retired` with one sentence saying why.

Update this document when a rule is added, changed or retired. Each rule is one line with its reason. A choice that looks wrong but is deliberate also gets a record under `decisions/`, as [0000](./decisions/0000-record-architecture-decisions.md) states. Anything smaller stays a line here.

## Always

### Code

- `C001` Write everything in English, including identifiers, comments, commit messages and documents, so one language serves every reader.
- `C002` Prefer code that works, then code a newcomer understands on first read, then code made of small replaceable units, and weigh brevity or speed only once those three hold, so of two approaches that work pick the more obvious.
- `C003` Name functions `prefix_action` in snake_case, with the prefix naming the area, such as `player_` or `stage_`, because GML has one global namespace and the name is its only context.
- `C004` Use the standard industry term for a concept, and define a term that belongs to the domain or to GameMaker once in the glossary of [ARCHITECTURE.md](./ARCHITECTURE.md), so a professional who has never made a game can read the code.
- `C005` Put constants in enums and macros and never repeat a literal, so each fact has one owner, as Fowler's *Refactoring* catalogues it under Replace Magic Literal.
- `C006` Keep configuration data in dedicated init or setup functions, apart from behaviour, so changing a value never means editing logic, which is the separation of concerns Dijkstra describes in "On the role of scientific thought".
- `C007` Log with `print("[INFO] ...")`, naming the level in brackets and taking the level names from the syslog severities of RFC 5424, such as informational, warning, error and debug, so every line reads the same.
- `C008` Use a comment as a one-line label that organizes and segments code, such as `// Variables`, `// Speed variables` or `// Create user without email`, and use one to explain code only where it is hard to follow, saying why and not what.
- `C009` Mark a short script that runs often with `gml_pragma("forceinline")`, which makes a YYC build compile it inline as the GameMaker manual describes, and keep it to short scripts because inlining also grows the executable and the compile time.
- `C016` Use the plain word in code, comments and documents, such as `use` over `utilize`, so a newcomer understands on first read, as the Google developer documentation style guide asks for clear and straightforward language.
- `C017` Make a message that reports a failure say why it failed and what would change it, in the words of somebody who has not read the code, so a log line saves them opening a file.

### Structure

- `S001` Group by domain and not by resource type, so everything about one element lives together. GameMaker already gives the by-type view on disk and in the IDE filters, so the virtual folders give the other view. This is the structure that shows a project's purpose in Martin's "Screaming Architecture", and Godot's project organization guide advises grouping files by feature.
- `S002` Order top-level folders by dependency, so a layer depends only on those above it, and what stops the game from starting comes first, which is the Dependency Rule of Martin's "The Clean Architecture".
- `S003` Prefix folders with `N. Name` to make the intended order explicit in the IDE, and keep to 9 per level so lexical order matches numeric order.
- `S004` Name folders with standard software vocabulary, such as Bootstrap, Persistence or Configuration, and keep a domain noun only where it is the product's own vocabulary.
- `S005` Keep the depth to 4 levels at most, because past that a level becomes a label and not a grouping, and PEP 20 says flat is better than nested.
- `S006` Keep 5 to 9 items per folder, subdivide over 9 by responsibility and consider merging under 5, following Miller's "The Magical Number Seven, Plus or Minus Two" as a heuristic and not a law.
- `S007` Give sprites and sounds their own subfolder, because they are bulky and would bury the code.
- `S008` Put a shared resource in the nearest common ancestor of its users, so no asset is duplicated or arbitrarily owned.
- `S009` Name a resource for clarity over brevity, because the name is its only context in code and autocomplete makes length cheap.
- `S010` Use a leading underscore only to mark something private or internal, as PEP 8 does.
- `S011` Edit the GameMaker project files, `blue-blur-engine.yyp`, each `.yy` and `blue-blur-engine.resource_order`, as little as possible, keep the exact line format the IDE writes, and reopen the project to verify, because the IDE is fragile with them.

### External dependencies

- `E001` Keep third-party code in `Vendor` and never edit it. Only the package folder may be renamed, because its internal structure belongs to its author and would be lost on update.
- `E002` Reach a third-party component through the project's own wrappers in `Core`, so replacing a component changes one place.
- `E003` Keep each component's licence file in `datafiles/licenses/` and list the component in the third-party table of [ARCHITECTURE.md](./ARCHITECTURE.md), so provenance is never in doubt.
- `E004` Read a component's licence from its shipped file before adding it, and review licence and provenance across the whole set and not only the newest arrival.

### Version control

- `G001` Make each commit one logical change, so it can be reviewed and reverted alone, as Git's own `SubmittingPatches` guide asks.
- `G002` Check that every modified `.yy` file in a commit changed on purpose, because the IDE rewrites project files on its own.

### Verification

- `V001` Verify a change on the path a player actually takes, because a shortcut can pass while the real path is broken.
- `V002` State how a change was verified and what was not, so nobody assumes a check that never ran.
- `V004` Test with the VM runtime and build every executable you share with YYC, because YYC compiles the code to native code for performance while the VM only needs to run quickly while you test.

### Documentation

- `D001` Keep each document to its own role, as [0000](./decisions/0000-record-architecture-decisions.md) states, so a reader knows where to look.
- `D002` Open every document under `docs/` with an "About this document" section saying who it is for, what it contains, what it leaves out and when to update it.
- `D003` Give each fact one owner and link to it instead of restating it.
- `D004` Write a decision record only when a reasonable newcomer would be tempted to change the choice and changing it would do harm, as [0000](./decisions/0000-record-architecture-decisions.md) states.
- `D008` Name the industry standard or practice a rule rests on, with its author or issuer, and say when a rule departs from one, so somebody who disagrees can check the reasoning, as [PRINCIPLES.md](./PRINCIPLES.md) asks. Say plainly when you could not read the source.

### Agents

- `A001` Read this whole document before you change anything, then [PRINCIPLES.md](./PRINCIPLES.md) and [ARCHITECTURE.md](./ARCHITECTURE.md), and read [decisions/](./decisions/) before you change anything that looks wrong.
- `A002` Treat every rule as binding. Only the user may override one, and only in the conversation.
- `A003` Stop and ask when a task seems to need breaking a rule, and do not choose silently.
- `A004` Add a file under `docs/` only when the user asks.
- `A005` Act on [PENDING.md](./PENDING.md) or reopen a decision record only when the user asks.
- `A006` Report in the conversation what you did and what you verified, and say plainly what you could not verify, including anything that needs the game to run.
- `A007` Keep to the scope of the request, and mention what you notice elsewhere without changing it.
- `A012` When the user asks for a commit, give it a simple and clear title and a short description that explains itself, and use no colon, semicolon, dash or complex word in either, so the history reads easily.

## Never

### Code

- `C010` Never golf code, write clever one-liners, add abstractions to save lines, or shave milliseconds at the cost of clarity.
- `C011` Never add features, abstractions or future-proofing nobody asked for, including a flag for an absent feature, which is the YAGNI principle of Extreme Programming.
- `C012` Never refactor unrelated code while you fix a bug, and never optimise prematurely, as Knuth warns in "Structured Programming with go to Statements".
- `C013` Never add error handling for a case that cannot happen.
- `C014` Never write a decorative comment such as `// ===== Variables =====`, a comment over more than one line, two comments stacked together, a docstring or block comment, or a comment that explains a whole file, so a comment is always one idea on one line.
- `C015` Never use a semicolon in comment text, so one comment holds one idea.

### Structure

- `S012` Never put resources and subfolders in the same folder, because a mixed folder hides its structure and invites loose items.
- `S013` Never use a leading underscore as a type marker.

### External dependencies

- `E005` Never add a component whose licence you have not read.

### Version control

- `G003` Never rewrite the history of a shared branch, as the Pro Git book warns about rebasing commits that others have.

### Verification

- `V003` Never report a result you did not observe.

### Documentation

- `D005` Never restate in prose what the project files already state, such as the list of resources.
- `D006` Never narrate a correction inside a document, because git keeps how the text changed.
- `D007` Never write a rule for an AI agent outside the Agents section, and never write the shared documents as if addressed to one.

### Agents

- `A008` Never edit `blue-blur-engine.yyp`, `blue-blur-engine.resource_order` or anything in `Vendor` unless the user asks for that change.
- `A009` Never make a commit or a push unless the user asks for it in that request, because the user is the only person responsible for each commit.
- `A010` Never mention the agent, its model or the company behind it in a commit, a pull request or any file, such as a co-author line, even when the tooling suggests it, because the user alone answers for the work.
- `A011` Never leave the project directory, not to look for a file you did not find and not to read the user's system, because the project is your whole sandbox. The only exception is a path the user gives you for one specific task.
