# 0001. Vendor libraries and adapters

## About this document

This record is the decision about how the project reaches the libraries in `Vendor` and how its own libraries are written. It is for anyone about to add a library, rename one of its functions, or call a library from game code. It states the two layers, the naming of each and the one exception. It does not list the functions of any library. Update it only when the way libraries are reached changes.

- Status: accepted
- Date: 2026-10-10
- Decision-makers: the maintainer

## Summary

- A library lives in `Vendor` and is written in the style of Julian Adams, in snake_case, with its brand as the prefix of every public name.
- Game code never calls EasyFade, EasyAudio, or any library other than GMUtils. It calls an adapter in `02. Core/09. Adapters`, named for the domain and not for the library.
- No symbol of a library crosses the adapter, so replacing the library changes the adapter files and nothing else.
- GMUtils is the exception. Its functions keep their plain names and game code calls them directly.
- Never copy the shape of a library into its adapter, and never call a library from outside its adapter.

## Context and problem statement

EasyFade, EasyAudio and GMUtils were written quickly and each named things its own way. Game code called them in 171 places, so replacing a library meant editing every one of those places. EasyAudio also read the game's globals from its own configuration, so the library depended on the game and not the other way round.

The wrappers the project already has for Input and AESnips work, but nobody designed them. They copy the signature of the library, and some pass the library's enums on to the game. A wrapper like that moves the dependency without removing it.

## Decision outcome

There are two layers, each with its own convention.

**The library layer.** A library is a general package that knows nothing about Blue Blur Engine, written the way Julian Adams writes Input, SparkleStore, DB and Sphinx, with snake_case in place of his PascalCase.

- Every public function carries the brand as a prefix, such as `easyfade_` or `easyaudio_`, which no GameMaker function uses.
- Everything internal starts with `__`, and internal macros are `__BRAND_*`.
- Public constants and enums are uppercase and carry the brand.
- Arguments and local variables are `_snake`, and private members of an instance or struct are `__snake`.
- Internal scripts live in an `_Internal` folder. A library has `__brand_constants` for its version and date, `__brand_config` for its own defaults, and `__brand_system` for its state and its welcome message.
- A library never reads a global, an asset or a setting of the game. The game hands such values in through a function.
- Every public function has JSDoc with `@param`, and says how it differs from the native function it resembles, if there is one.
- One function per script.

**The adapter layer.** An adapter is the only code that mentions a library. It lives in `02. Core/09. Adapters`, one folder per domain, and follows the project's own rules.

- It is named `domain_action` as `C003` asks, with the domain taken from what the game does, such as `mixer_` for audio and `scene_` for changing room.
- It offers one function for each use the game really has, and not one for each function of the library.
- No type, enum or macro of the library appears in its arguments or its results. Core defines its own and the adapter translates.
- Its settings come from `02. Configuration`, and it passes them to the library when the game starts or in each call.

**The exception.** GMUtils is a set of pure functions such as `print`, `fmod`, `map` and `angle_wrap`. Nothing in it can be replaced by a better service, so an adapter over it would be a wrapper with one implementation. Game code calls its functions directly and they keep their plain names, as if they were native. The risk accepted is that a future GameMaker version adds a function with one of those names.

The practices behind this are Ports and Adapters by Alistair Cockburn, the Interface Adapters ring of Robert Martin's "The Clean Architecture", and the Facade pattern of the Gang of Four. Library versions follow Semantic Versioning, so a library whose public names change takes a new major version. The library conventions were taken from reading the Input, SparkleStore, DB and Sphinx scripts in this repository, and not from his documentation, which was not read.

## Consequences

- Replacing EasyAudio or EasyFade rewrites the files in its adapter folder and the library folder, and no other file. A search for `easyfade_` or `easyaudio_` outside those two places must find nothing.
- Without this decision, game code starts calling a library directly again, the library's types leak into the game, and a replacement becomes a rebuild.
- The adapters add a layer to read. That cost is accepted for the two libraries that wrap a service and refused for GMUtils.

## Considered options

- **PascalCase public names, as Julian Adams writes them.** Refused by the maintainer, who does not like the style. A snake_case name with the brand as its prefix does not collide with a GameMaker function either.
- **An adapter for GMUtils too.** Refused because its functions are pure and have no service behind them.
- **Prefixing the GMUtils functions with `gmutils_`.** Refused by the maintainer, who wants them to read as native functions.
- **Adapters that mirror the library function by function.** Refused because a mirror keeps the library's shape, so replacing the library still changes every caller.
