# Thoughts on GameMaker

## About this document

This document condenses a public collection of opinions and GML techniques by a professional GameMaker programmer, who calls it idle thoughts on the engine they use for their job. It is for a programmer who has to choose how to structure startup code, global state, configuration, cleanup of memory that the garbage collector does not manage, or a library's public interface, and wants one practitioner's tested approach and the reasons the author gives. It covers the eight techniques, the miscellaneous advice, the formatting and versioning habits, the pull request rules and the note on code reuse. It leaves out how to apply any of it to a particular project, and it does not judge the advice. Update it when the upstream repository changes, by reading the changed files again and replacing the commit and the date below.

## Source, version and licence

- Upstream: [JujuAdams/ThoughtsOnGameMaker](https://github.com/JujuAdams/ThoughtsOnGameMaker), by Juju Adams.
- Version documented: branch `main` at commit `90e814568c144c5fcb17c7b4e9e0185d20e14209`, committed on 2026-11-08. Files read: `README.md`, `code-reuse.md`, `technique-1-initialization.md` to `technique-8-destructors.md`, and the first lines of `technique-8-destructors-legacy.md`. Downloaded on 2026-11-19.
- Licence: the repository has no licence file and the GitHub metadata declares none. The text and the code are therefore paraphrased here and never copied, and a reader who wants the exact wording or the full code opens the upstream file.

## How to read the claims

The collection is opinion and craft, and not a standard. Each section carries one of three marks.

- **Advice** means the author recommends it and gives no measurement.
- **Stated** means the author gives it as a fact about GameMaker or about a shipped game. Nothing here was checked against the manual or by running the code.
- **Sample** means the claim comes from the example code, which was read and not run. The section at the end lists where a sample does not run as written.

## Miscellaneous advice

- Leave a long comment when a solution is especially clever or especially stupid (**Advice**).
- Reuse code and think in APIs (**Advice**). See "Code reuse" below.
- Give every global function meant for public use its own script, so the asset browser works as a menu of what is available and a glance at it is faster than reading documentation (**Advice**).
- Formatting matters little between projects. Inside one project the first person to write a line sets the style and everyone follows it (**Advice**).

## Formatting habits of the author

The author says these evolved over time, that older libraries differ, and that they are not a recommendation for others (**Stated**).

- Spaces, not tabs, for full control of how code looks.
- A custom order of assets in the asset browser, to control how scripts are introduced to a user.
- Allman style for curly brackets.
- camelCase for variables and assets, PascalCase for functions and static methods, SCREAMING_SNAKE_CASE for constants and macros.
- American spelling in the API and internal code, and British spelling allowed in comments.
- A single leading underscore for a local `var` variable and a double leading underscore for a private variable that nobody should touch.

The author's reason for the capitalisation scheme is that GML shares one global namespace, so telling variables and functions apart by case avoids clashes, which helps most in constructors, and that camelCase and PascalCase never collide with the native snake_case names (**Stated**).

## Versioning

The author prefers `major.minor.patch` for open source libraries (**Advice**).

- Major changes for a breaking change, including the removal of an API feature.
- Minor changes for a backwards compatible change, one a user can adopt without writing new code but may not be able to downgrade from, such as a new API feature.
- Patch changes for a bug fix that leaves the API alone, such as a hotfix or an update of the SDL controller database.
- A new optional argument is usually a minor change, and sometimes a major one when it changes the default behaviour.

## Pull requests

The author accepts a pull request only when it meets six conditions (**Advice**): the maintainer agreed in principle before the work, it is small, it addresses one feature or one bug, it fixes a known issue and does not merely tidy up, its code is commented, and it needs no IDE update and no different runtime than the library targets. The author adds that writing documentation is not a favourite task and welcomes fixes to typos and broken links.

## Code reuse

The note was first written for the GameMaker community forum (**Stated**).

- The author's studio keeps a template project of independent components, each its own API that can be cut out when unused. The list runs to about two dozen items: a shader stack, post-processing, an input layer, a localisation system, a text renderer, a camera and resolution handler, a random number generator that is controllable for networking, a texture manager, an audio manager, a save system built from a database library plus an asynchronous file library, and a few effects.
- A game does not need all of that. A colleague who made well known games shared only a menu system between projects. The author's point is that nobody has to solve every problem before making a game.
- For a first game, write most of the code yourself, because understanding why a library or technique helps takes hands-on experience. Build a personal library over time, and also learn from other people's mistakes (**Advice**).

## Technique 1, application initialisation

**Advice.** Run startup as a finite state machine that advances through a list of states, executed by one dedicated object in a separate room that is the first room visited. Creating it there stops the game from being initialised twice by accident.

- Reason, stated for each platform: on a console a long load can fail the platform holder's compliance check, a long hang on desktop can make the OS think the game froze, and mobile players quit when loading drags (**Stated**).
- Steps of the basic flow: initialise settings to a valid state, start an asynchronous load of the settings, wait for it to finish, apply the window or fullscreen setting, then go to the next room, usually a main menu.
- Each state runs in a Step event, so a phase can end and the next one start on the following step. A countdown variable can pause the machine, which the sample uses for 10 frames after changing the window state because the manual recommends a pause for a smooth fullscreen transition (**Sample**).
- The asynchronous load is chosen for console compatibility. The state machine waits for the matching Async Save/Load event, records success or failure from its status, and always deletes the buffer, whatever the result (**Sample**).

## Technique 2, singletons

**Advice.** One instance of an object, always present and usually persistent, gives one clear owner of global functionality and carries state between rooms without a global variable.

- To build one: mark the object persistent, create the instance in the initialisation room, reactivate it if instance deactivation is used, and never call `instance_destroy(all)`, or re-create it afterwards.
- Good uses: music control, player input handling, menu and GUI controllers, save controllers and networking controllers.
- Limit: only for things that are global in scope. The most common abuse is the player instance, which makes a later multiplayer conversion very hard and risks crashes when code assumes the player always exists.

## Technique 3, evacuating global scope

**Advice.** Treat independent parts of a game as libraries, and keep their state out of GameMaker's global variables, because a game and its libraries share one global scope and names like `global.debugMode` can collide or be overwritten. Many global variables also clutter the debug view.

- The method: a global function holds a `static` struct and returns it, so every call returns the same struct, and the library's other functions read their state through it.
- Lazy initialisation: initialise the static to `undefined`, return it if valid, and otherwise build it on first use. Initialisation then happens whichever function is called first, with no explicit init call.
- The same `static` trick works in constructors.
- For debugging, publish one global variable that points at the struct, and only when a debug flag is on.

## Technique 4, config macros

**Stated.** A macro is replaced by its literal text when the game is compiled, so it needs no memory lookup, and an `if` on a macro can be resolved at compile time and disappear from the build. The author uses this to give libraries configuration with no run-time branch cost in hot loops, and notes that a macro baked into the game is harder for a third party to change, especially on YYC. None of this was measured in the source.

- A macro can have a per-configuration value by writing its name with a colon and the configuration name, for example a debug macro defaulting to true and false in a "Ship" configuration. This keeps development behaviour and expensive safe-mode checks out of release builds (**Advice**).
- **Stated pitfall.** In GameMaker, a change to the project's settings made while a non-default configuration is active applies only to that configuration. The author says this cost the author and colleagues hundreds of lost texture group assignments in the weeks before a release, which had to be redone.
- **Advice** that follows from it: do nearly all work in the default configuration, treat other configurations as special cases that branch off it, switch to one only to produce a build for QA, localisation QA, compliance or production, and switch straight back.

## Technique 5, fluent interface

**Advice.** Let each method return `self` so calls chain in one scope, as in the builder pattern that GameMaker's vertex buffer functions follow, which makes long builder sequences shorter and easier to read.

- The entry function returns a struct built from a constructor, each method does its work and returns the struct, and a final `End` method closes the operation and returns `undefined` to forbid further chaining (**Sample**).
- A larger real use is the Scribble text library, which adds a caching layer on top of the same idea.

## Technique 6, multiline macros

**Advice.** GameMaker has no function macros, but a macro of several lines, each ending with a backslash except the last, can paste a block of code in place. Use it only when code is extremely sensitive to speed and a function call, whose overhead is real but almost always unimportant, costs too much. YYC can inline a function, but only on YYC.

- Constraints: no blank lines inside the macro, and the variables it names must exist, with the right values, wherever it is used.
- The sample moves a shared type check at the top of two functions into one macro.
- Larger real examples are in Scribble and in the Input library.

## Technique 7, pseudo-objects

**Stated.** For about a hundred simple, similar instances that cost too much as full instances, store each one as a row of a `ds_grid` and run most of the logic as bulk grid operations. The author used it for reactive grass in a shipped game, for text layout in Scribble and for projectiles in another game.

- Strip each object to its core variables, one per grid column.
- Keep a list of free rows so an instance is created by filling a free row and destroyed by freeing its row.
- Draw with sprite assets on asset layers, one layer per depth value, and change the sprite on the asset to animate. The author says this alone gave a significant gain.
- Keep one list of row indexes per state, move a row between lists when its state changes, and use the `ds_grid_region_*` functions to update all rows together, such as counting down every timer at once.
- For delta timing, adjust the image speed of the sprite assets when the delta factor changes.
- For objects that never move, replace collision checks with a precomputed grid of cells, each holding the list of instances that overlap it.
- The shift in view, in the author's words, is that each state machine owns its instances and no instance owns a state machine.

## Technique 8, destructors

**Advice.** GML has no destructors, and a struct that holds a surface, buffer or grid leaks it when the struct is garbage collected. Emulate a destructor with a weak reference. The author calls this a second attempt and says the first, kept in a legacy page, was over-complex and not very fast.

- A struct built by a `Destructor` constructor holds a weak reference to its target, a callback and the resources to free. It checks `weak_ref_alive()` on a timer, and when the target is gone it runs the callback once. A `Terminate` method runs it at once.
- The timer is a native time source with a default period of one second. Each destructor starts it after a random delay of up to one period, using `call_later`, so many destructors created in one step do not all check on the same step (**Sample**).
- **Ownership rule.** The destructor must never reference its target, or the target is never collected. Everything the callback needs lives in the destructor and only there, and the target reaches that data only through the destructor and never keeps a permanent reference to it. The author admits this goes against the flat structures that GameMaker code usually prefers and costs readability and speed.
- The sample wraps a surface in a safe surface struct whose destructor owns the surface and frees it when the struct is collected, and a `Destroy` method frees it at once.

## Where the source does not run as written

- Technique 1: the sample passes `buffer` and `filename` to the asynchronous load, but the variable it created is `loadBuffer` and no `filename` is defined.
- Technique 4: the sample defines `TREE_DEBBUG` and uses `TREE_DEBUG`.
- Technique 8: the legacy page is marked as superseded by the current one.
- The claims about compile-time macro evaluation, function call overhead and the gain of asset layers come with no measurement.
