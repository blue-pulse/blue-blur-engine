# Input

## About this document

This document describes Input, a GameMaker library that unifies keyboard, mouse, touchscreen and gamepad control. It is for a maintainer who has never seen the library and needs to understand, predict or repair code that depends on it without opening the upstream repository. It contains the version, licence and provenance, what the library is, its concepts, the setup and settings, the checkers, players and devices, rebinding, the pointer and touch functions, the plug-ins, examples from the official guides, the errors a caller can see, the steps to update between versions, the quirks of each platform and device, and the places where the documentation and the code differ. It leaves out the internals of the library, the detail of each plug-in and the setup of platform SDKs. It describes version 10.5.0, last read against its package on 2026-10-15. Update it when a new version changes a function, a setting or a behaviour listed here, by re-reading the package against this text.

Each fact carries one of two marks. **Documented** means the official documentation states it, and it is the promise a caller may rely on. **Source** means it comes from reading the code of the version 10.5.0 package, and from comparing it with the 10.3.0 package where it says so. It is how this version behaves, and nobody should build on it as a promise. The library has one function per script and the script has the function's name, so a **Source** fact is found in the script of that name. Nothing in this document was run.

When the documentation and the code disagree, the code is what runs. This document gives both, and the section on differences lists them.

## Version, licence and provenance

| Item | Fact |
| --- | --- |
| Upstream | [codeberg.org/offalynne/Input](https://codeberg.org/offalynne/Input), documentation at [offalynne.grebedoc.dev/Input](https://offalynne.grebedoc.dev/Input/#/10.5/) (**Documented**). |
| Version | 10.5.0, dated 2026-09-29, read from `INPUT_VERSION` and `INPUT_DATE` in the package and from its `metadata.json` (**Source**). The tag and commit were not checked, because only the package was read. |
| Distribution | A `.yymps` package on the releases page of the repository (**Documented**). |
| Licence | MIT, copyright 2024 Julian Adams, read from the shipped `input_license.txt`. The same file carries a BSD 3-Clause notice for data taken from the Chromium blocklist (**Source**). The package also ships `gamecontrollerdb.txt`, a controller database, whose licence was not checked. |
| Dependencies | Native GameMaker functions only (**Documented**). The Steamworks extension is optional. |
| GameMaker versions | Targets 2024.8 and is expected to work on later versions (**Documented**). The package declares an editor version of 2023.4.0.0 (**Source**). |
| Platforms | All of them, with edge cases on the least tested (**Documented**). What upstream tests was not checked. |
| Authors | Juju Adams and Alynne Keith, with many contributors (**Documented**). Credit is optional, as "Juju Adams, Alynne Keith, and Friends" (**Documented**). |

## What it is

The library gives the following (**Documented**).

- One set of actions, called verbs, that keyboard, mouse, touchscreen and gamepads all trigger.
- Hotswap between devices.
- Rebinding of controls.
- Detection of the type of gamepad.
- Assignment of gamepads to players.
- Deadzones for thumbsticks and triggers.
- Plug-ins for extra features.

The library takes these names in the global namespace (**Source**).

- Every public function starts with `Input`.
- Every public macro and enum starts with `INPUT_`.
- Everything internal starts with `__Input` or `__INPUT`.
- It adds the key constants `vk_semicolon`, `vk_comma`, `vk_hyphen` and others, and `mb_wheel_up` and `mb_wheel_down`.
- It creates one persistent object at start-up when `INPUT_COLLECT_MODE` is 0.

## Concepts

| Term | Meaning |
| --- | --- |
| Verb | An action the player can do, such as jump or pause. A verb is always an integer, normally a member of an enum. |
| Binding | The link between a verb and a physical input. There are two groups of bindings, one for keyboard and mouse and one for gamepads. |
| Alternate | A second, third or later binding for the same verb. There is no limit. |
| Cluster | Four verbs, up, right, down and left, grouped so they can be read as two axes. |
| Player | A slot with its own bindings, one device and its own verb state. |
| Device | A source of input. A gamepad is one device. Keyboard and mouse together are one device. |
| Hotswap | The library moves player 0 to whichever device shows activity. |
| Virtual button | A touchscreen control drawn by the game, such as a button, a pad or a thumbstick. |
| Metadata | Data of your own attached to a player, a verb or a cluster. |
| Plug-in | Optional code that bolts onto the core library. |

**Verbs are integers.** Version 10 does not use strings for verbs. Define them in an enum (**Documented**).

**Bindings use these forms** (**Documented**, **Source**).

- A `gp_*` constant for a gamepad button or axis.
- A `vk_*` constant for a key.
- An `mb_*` constant for a mouse button.
- A one-character string for a key, such as `"A"`.
- An array of any of these, to give alternates, such as `[vk_up, "W"]`.
- `undefined` for no binding on that device.
- A negative axis constant for the left or up half of a thumbstick, such as `-gp_axislh`.

**Players and devices follow these rules** (**Documented**).

- A player has one device and a device belongs to one player. Players cannot share a device.
- A player can hold a device that is not connected. `InputPlayerIsConnected()` says whether it is.
- The mouse is part of the keyboard device.
- Several players cannot share the keyboard or one gamepad.

## Devices

Devices are integers. A value of 0 or more is a gamepad, and it equals the native GameMaker gamepad index. A negative value is a special device (**Documented**).

| Constant | Meaning |
| --- | --- |
| `INPUT_NO_DEVICE` | The player has no device. Set it to disconnect a player. |
| `INPUT_KBM` | Keyboard and mouse on desktop. Not on consoles or mobile. |
| `INPUT_TOUCH` | The touchscreen on mobile. Works with virtual buttons. Not on Switch or Windows. |
| `INPUT_GENERIC_DEVICE` | A passive device that is always connected and collects nothing itself. Verb values come from `InputPlugInVerbSet()`. It suits replay and debugging. |
| `INPUT_ALL_PLAYERS` | Not a device. It stands for every player. Its value is `-3`. |

In version 10.5.0 the values are `INPUT_NO_DEVICE` -1, `INPUT_KBM` -100, `INPUT_TOUCH` -200 and `INPUT_GENERIC_DEVICE` -300 (**Source**). Use the names and never the numbers, because the values changed between 10.3.0 and 10.5.0 (**Source**).

The gamepad types are `INPUT_GAMEPAD_TYPE_NO_GAMEPAD` (0), `UNKNOWN` (1), `XBOX` (2), `PS4` (3), `PS5` (4), `SWITCH` (5), `JOYCON_LEFT` (6) and `JOYCON_RIGHT` (7) (**Documented**, **Source**).

How many gamepads work at once depends on the system (**Documented**).

| System | Gamepads |
| --- | --- |
| Windows XInput, Apple, PlayStation, web | 4 |
| Windows DInput, Switch, Xbox | 8 |
| Linux | Many |

### Hotswap

Hotswap is on by default unless the platform bans it, which is the case on PlayStation 5 with `INPUT_PS5_SINGLE_USER` (**Source**). While it is on, only player 0 can hold a device, and `InputPlayerSetDevice()` raises an error for any other player given a real device (**Source**).

Player 0 moves to another device when its own device has been inactive for a short time and another connected device shows activity (**Source**). By default only button presses count as activity. Thumbstick movement, trigger movement, mouse buttons and mouse movement do not, to stop the control from flicking between devices (**Documented**). The settings `INPUT_GAMEPAD_THUMBSTICK_REPORTS_ACTIVE`, `INPUT_GAMEPAD_TRIGGER_REPORTS_ACTIVE`, `INPUT_MOUSE_BUTTON_REPORTS_ACTIVE` and `INPUT_MOUSE_MOVEMENT_REPORTS_ACTIVE` change that. Hotswap does not exist on mobile (**Documented**).

## Setting up

### Import

1. Put the project under source control.
2. Download the `.yymps` file and import it, choosing to add all assets. An `Input` folder appears in the asset browser and two files appear in Included Files (**Documented**).
3. In Game Options, under Deprecated Behaviours, switch off "Enable Copy On Write Behaviour For Arrays", and switch off the other legacy options too (**Documented**).
4. Never destroy or deactivate the controller object the library creates at start-up (**Documented**).

The `Config` folder holds the scripts you edit. The `(System)` folder holds the code the library needs and you should leave it alone (**Documented**).

### Define verbs and clusters

Verbs are defined in the script `__InputConfigVerbs()` and nowhere else. When the game runs from the IDE, calling the define functions elsewhere raises an error (**Source**).

| Function | Purpose |
| --- | --- |
| `InputDefineVerb(verb, exportName, kbmBinding, gamepadBinding, [metadata])` | Define a verb with its default bindings. The export name is the key used when bindings are exported. `undefined` means the verb is not exported. |
| `InputDefineCluster(cluster, verbUp, verbRight, verbDown, verbLeft, [axisBiasFactor], [axisBiasDiagonals], [metadata])` | Define a cluster. The bias, from 0 to 1, makes straight horizontal and vertical input easier. The default of 0 gives no bias. |

Export names must stay the same between save-file versions, or old bindings cannot be imported (**Source**). A repeated export name raises an error when the game runs from the IDE (**Source**).

### Settings

The settings are macros in the script `__InputConfig()`. The defaults come from the code of 10.5.0 (**Source**). Two differ from the documentation, as the section on differences shows.

| Macro | Default | Meaning |
| --- | --- | --- |
| `INPUT_MAX_PLAYERS` | `1` | The most players the library allows. A higher number costs a little speed. |
| `INPUT_SAFETY_CHECKS` | `true` | Check the arguments of functions. Turn off for the most speed. |
| `INPUT_COLLECT_MODE` | `0` | How input is collected. See below. |
| `INPUT_UPDATE_AFTER_COLLECT` | `true` | Update the library state right after collecting. Set `false` for a fixed timestep and call `InputManualUpdate()` yourself. |
| `INPUT_REPEAT_DEFAULT_DELAY` | `9` | Frames between pulses of `InputRepeat()`. |
| `INPUT_REPEAT_DEFAULT_PREDELAY` | `25` | Frames before the first pulse of `InputRepeat()`. |
| `INPUT_LONG_DEFAULT_DELAY` | `10` | Frames a verb must be held for the long checkers. |
| `INPUT_OPPOSING_DEFAULT_MOST_RECENT` | `true` | Whether the opposing checkers favour the most recent verb when both are active. |
| `INPUT_MOUSE_MOVE_DEADZONE` | `2` | Distance the mouse must move to count as moved. |
| `INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD` | `0.25` | Minimum value of a thumbstick axis. Keep it above 0. |
| `INPUT_GAMEPAD_THUMBSTICK_MAX_THRESHOLD` | `0.8` | Value at which a thumbstick axis counts as full. |
| `INPUT_GAMEPAD_TRIGGER_MIN_THRESHOLD` | `0.05` | Minimum value of a trigger. Keep it above 0. |
| `INPUT_GAMEPAD_TRIGGER_MAX_THRESHOLD` | `0.9` | Value at which a trigger counts as full. |
| `INPUT_GAMEPAD_THUMBSTICK_REPORTS_ACTIVE` | `false` | Whether thumbstick movement triggers a hotswap. |
| `INPUT_GAMEPAD_TRIGGER_REPORTS_ACTIVE` | `false` | Whether trigger movement triggers a hotswap. |
| `INPUT_MOUSE_BUTTON_REPORTS_ACTIVE` | `false` | Whether mouse buttons trigger a hotswap. |
| `INPUT_MOUSE_MOVEMENT_REPORTS_ACTIVE` | `false` | Whether mouse movement triggers a hotswap. |
| `INPUT_REBIND_TIMEOUT` | `5000` | Milliseconds before a rebinding scan cancels itself. |
| `INPUT_KBM_FIRST_PLAYER_ONLY` | `false` | Only player 0 may hold the keyboard and mouse. |
| `INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES` | `10` | Frames of touch history a virtual button records. |
| `INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS` | `false` | Let the keyboard and mouse device use virtual buttons, for testing on a computer. |
| `INPUT_ALLOW_TOUCH_ON_DESKTOP` | `false` | Treat `INPUT_TOUCH` as connected on desktop. |
| `INPUT_MAX_TOUCHPOINTS` | `4` | Touch points to track. |
| `INPUT_TOUCH_EDGE_DEADZONE` | `35` | Pixels around the screen edge where a touch does not count as pressed or released. |
| `INPUT_VIRTUAL_BUTTON_MIN_THRESHOLD` | `50` | Default minimum for 2D virtual buttons, in GUI pixels. |
| `INPUT_VIRTUAL_BUTTON_MAX_THRESHOLD` | `100` | Default maximum for 2D virtual buttons, in GUI pixels. |
| `INPUT_SWITCH_X_KNOWN_GOOD` | `true` | Apply known good controller settings on Switch and Switch 2. |
| `INPUT_PS5_SINGLE_USER` | `false` | Only player 0 may hold a device on PlayStation 5. Single player games only. |
| `INPUT_XBOX_SIMPLIFIED_USER_MODEL` | `false` | Match the Xbox simplified user model. Single player games only. |

**Collect modes** (**Documented**, **Source**).

| Value | Behaviour |
| --- | --- |
| `0` | A persistent invisible instance collects input in the Begin Step event. Verb state is current as early as possible in the frame. |
| `1` | A time source collects input between Begin Step and Step. The state in Begin Step is one frame behind the Step event. |
| `2` | Nothing is automatic. Call `InputManualCollect()` yourself. |

### Steamworks

With the official GameMaker Steamworks extension, Input reaches Steam Input and gets vibration, motion, LED colour and adaptive triggers on Windows, Linux and SteamOS with no extra code (**Documented**). The Steam app must use Steam Input with a gamepad template and not "Custom Configuration", because a custom configuration hides the gamepad from the game (**Documented**). The default test AppID 480 uses a custom configuration, so it does not work for this, and you must use your own AppID before release (**Documented**). With Steamworks active, the code raises an error at start-up when the application ID is 480, and the message suggests the test ID 378090 (**Source**).

## Constants

| Group | Members |
| --- | --- |
| Library | `INPUT_VERSION`, `INPUT_DATE`, `INPUT_RUNNING_FROM_IDE`, `INPUT_SDL_SUPPORT`, `INPUT_BLOCK_MOUSE_CHECKS`. |
| Support | `INPUT_SUPPORT_GAMEPADS`, `INPUT_SUPPORT_KBM`, `INPUT_SUPPORT_TOUCH`, `INPUT_SUPPORT_HOTSWAP`. |
| Bans | `INPUT_BAN_GAMEPADS`, `INPUT_BAN_KBM`, `INPUT_BAN_TOUCH`, `INPUT_BAN_HOTSWAP`. |
| Platform | `INPUT_ON_WINDOWS`, `MACOS`, `LINUX`, `DESKTOP`, `IOS`, `ANDROID`, `MOBILE`, `XBOX`, `PS4`, `PS5`, `SWITCH`, `SWITCH_2`, `SWITCH_X`, `CONSOLE`, `APPLE`, `OPERAGX`, `WEB`. |
| `INPUT_PLAYER_STATUS` | `DISCONNECTED`, `NEWLY_DISCONNECTED`, `NEWLY_CONNECTED`, `CONNECTED`. The two "newly" values last one frame. |
| `INPUT_THRESHOLD` | `LEFT`, `RIGHT`, `BOTH`. |
| `INPUT_STEAM_INFO` | `STEAMWORKS`, `STEAM_DECK`, `BIG_PICTURE`, `ON_WINE`. See the note below. |
| `INPUT_VIRTUAL_TYPE` | `BUTTON`, `DPAD_4DIR`, `DPAD_8DIR`, `DPAD_HORIZONTAL`, `DPAD_VERTICAL`, `THUMBSTICK`, `TOUCHPAD`. |
| `INPUT_VIRTUAL_REFERENCE` | `CENTER`, `TOUCH_POINT`, `DELTA`. |
| `INPUT_VIRTUAL_RELEASE` | `DO_NOTHING`, `DESTROY`, `RESET_POSITION`. |
| `INPUT_PLUG_IN_CALLBACK` | `COLLECT`, `UPDATE`, `GAMEPAD_DISCONNECTED`, `GAMEPAD_CONNECTED`, `PLAYER_DEVICE_CHANGED`, `COLLECT_PLAYER`, `UPDATE_PLAYER`, `LOSE_FOCUS`, `GAIN_FOCUS`, `GAME_RESTART`, `FIND_BINDING_COLLISIONS`. |
| Keys | `INPUT_KEYCODE_MIN` (8) and `INPUT_KEYCODE_MAX` (57343). |

The documentation lists `INPUT_STEAM_INFO` without `BIG_PICTURE`, which the code has and which says whether Steam is in Big Picture mode (**Source**).

## Checkers

A checker reads the state of a verb for the frame. The player index is optional and defaults to 0. Checks are valid after the library has collected input, which is early in the frame in the default collect mode (**Source**).

### One verb

| Function | Purpose |
| --- | --- |
| `InputCheck(verb, [player])` | Whether the verb is active, such as a button held. |
| `InputPressed(verb, [player])` | Whether the verb became active this frame. |
| `InputReleased(verb, [player])` | Whether the verb became inactive this frame. |
| `InputValue(verb, [player])` | The analogue value, such as the depth of a trigger. |
| `InputDuration(verb, [player])` | Frames since the verb was last pressed. |
| `InputRepeat(verb, [player], [delay], [predelay])` | A pulse that repeats while the verb is held, for menus. |
| `InputLongPressed`, `InputLong`, `InputLongReleased` `(verb, [player], [duration])` | Press, hold and release of a verb held past a duration in frames. |
| `InputBufferPressed(verb, duration, [player])` | Whether the verb was pressed within the last frames, for input buffering. |

### Many verbs or players

| Function | Purpose |
| --- | --- |
| `InputCheckMany`, `InputPressedMany`, `InputReleasedMany` `(verbs, [players])` | Whether any of the verbs is active, pressed or released, for any of the players. Each accepts an array or a single value, and `-1` stands for all. |
| `InputMostRecent([verbs], [player])` | The most recently pressed verb that is still active. |
| `InputOldest([verbs], [player])` | The active verb that has been held longest. |
| `InputLast([verbs], [player])` | The most recently pressed verb, active or not. |

Each of the last three takes an array of verbs and uses all verbs by default, and returns `undefined` when none qualifies (**Documented**, **Source**).

### Opposing verbs

| Function | Purpose |
| --- | --- |
| `InputOpposing(negative, positive, [player], [mostRecent])` | `-1`, `0` or `1` for the verb that is active. |
| `InputOpposingPressed(negative, positive, [player], [mostRecent])` | The same, for a verb newly pressed. |
| `InputOpposingRepeat(negative, positive, [player], [delay], [predelay])` | The same, as a repeating pulse. |

When both verbs are active the result is 0, unless `mostRecent` is `true`, which then favours the more recent one (**Documented**).

### Clusters

| Function | Purpose |
| --- | --- |
| `InputX(cluster, [player])` and `InputY(cluster, [player])` | The two components of the cluster vector. |
| `InputDirection(default, cluster, [player])` | The angle in degrees, or the default when the cluster is idle. |
| `InputDistance(cluster, [player])` | The length of the cluster vector. |
| `InputXYNewest(cluster, preferX, [player])` | One of the four cardinal directions, taken from the verb pressed most recently. It returns a struct with `x` and `y`, and one of them is 0. |
| `InputXYOldest(cluster, preferX, [player])` | The same, taken from the verb held longest. |

Cluster checkers apply the thumbstick thresholds in two dimensions, which a hand-made `point_direction()` does not (**Documented**). `preferX` says which axis wins when two verbs were pressed on the same frame (**Source**). The documentation does not describe `InputXYNewest()` and `InputXYOldest()` (**Source**).

## Players

| Function | Purpose |
| --- | --- |
| `InputPlayerGetDevice([player])` and `InputPlayerSetDevice(device, [player])` | Read and set the device of a player. |
| `InputPlayerHasDevice([player])` and `InputPlayerHasDeviceCount()` | Whether a player has a device, and how many players do. |
| `InputPlayerIsConnected([player])` and `InputPlayerConnectedCount()` | Whether the device is connected, and how many players are connected. |
| `InputPlayerGetStatus(player)` | A member of `INPUT_PLAYER_STATUS`. |
| `InputPlayerLowestConnectedIndex()` | The lowest connected player, or `undefined`. |
| `InputPlayerUsingGamepad`, `InputPlayerUsingKbm`, `InputPlayerUsingTouch`, `InputPlayerUsingGeneric` `([player], [complianceSafe])` | Which kind of device the player holds. |
| `InputPlayerGetGamepadType([player])` and `InputPlayerGetLastConnectedGamepadType([player])` | The type of the current or last gamepad. |
| `InputPlayerGetInactive([duration], [player])` | Whether the player pressed nothing for the milliseconds given. |
| `InputPlayerGetBlocked([player])` and `InputPlayerSetBlocked(state, [player])` | Block a player. Verb values become zero and held buttons release. |
| `InputPlayerGetGhost([player])` and `InputPlayerSetGhost(state, [player])` | A ghost player collects no input, for AI control. The device is not reset. |
| `InputPlayerGetMetadata`, `InputPlayerSetMetadata` | Data of your own on the player, by reference or as a copy. |
| `InputPlayerSwap(a, b)` | Swap everything between two players, bindings, device, verb state and metadata. |
| `InputPlayerSetMinThreshold`, `InputPlayerSetMaxThreshold`, `InputPlayerGetMinThreshold`, `InputPlayerGetMaxThreshold` | Thumbstick thresholds per player, from 0 to 1, for `INPUT_THRESHOLD.LEFT`, `RIGHT` or `BOTH`. |

On console, `InputPlayerUsingKbm()` and its three siblings return `false` unless `complianceSafe` is `false` (**Source**).

Check `InputPlayerGetStatus()` every frame to find out when a device disconnects, which some platforms require you to handle (**Documented**).

### Multiplayer

There are two ways to assign devices (**Documented**).

- By hand, with `InputDeviceGetNewActivity()` to find a device that shows activity, `InputPlayerSetDevice()` to assign it and `InputPlayerIsConnected()` to watch it.
- With the Party plug-in, which assigns each new device to the lowest player without one.

## Devices functions

| Function | Purpose |
| --- | --- |
| `InputDeviceEnumerate()` | An array of every valid device on the platform. |
| `InputDeviceGetPlayer(device)` | The player that holds the device, or `undefined`. |
| `InputDeviceIsAvailable(device)` | Whether the device is unassigned. |
| `InputDeviceIsConnected(device)` | Whether the device is connected to the system. |
| `InputDeviceIsGamepad(device)` | Whether the device is a gamepad, even when disconnected. |
| `InputDeviceGetAnyGamepadConnected()` | Whether any gamepad is connected. |
| `InputDeviceIsActive(device)` | Whether the device shows activity right now. |
| `InputDeviceGetNewActivity()` | The first unassigned device that shows activity. |
| `InputDeviceGetNewActivityOnVerb(verb, [player])` | The same, but only activity on the bindings of a verb. It returns `INPUT_NO_DEVICE` if none. |
| `InputDeviceCheckViaPlayer(device, verb, [player])` | Whether an unassigned device is active on a verb of a player. |
| `InputDeviceGetPlayerUsingGamepad([ignoreDisconnected])` | The lowest player that holds a gamepad. |
| `InputDeviceGetPlayerUsingGeneric()` | The lowest player that holds the generic device. |
| `InputDeviceGetDescription(device)` | A label for people. Never use it in game logic. |
| `InputDeviceGetGamepadType(device)` | A gamepad type constant. |
| `InputDeviceGetGamepadValue(device, binding)` | The raw value of a gamepad binding, which skips the deadzones of GameMaker. |
| `InputDeviceGetSteamHandle(device)` | The Steam Input handle, or `undefined`. |

## Hotswap functions

| Function | Purpose |
| --- | --- |
| `InputSetHotswap(state)` | Turn hotswap on or off for player 0. Turning it on sets every other player to `INPUT_NO_DEVICE`. |
| `InputGetHotswap()` | Whether hotswap is on. |
| `InputSetHotswapCallback(method)` | A method to call when a hotswap happens. It gets no arguments. |

## Rebinding

All of these take `forGamepad` first, which is `true` for the gamepad group and `false` for keyboard and mouse. The `alternate` and `player` arguments default to 0.

| Function | Purpose |
| --- | --- |
| `InputBindingGet(forGamepad, verb, [alternate], [player])` | The current binding, or `undefined`. |
| `InputBindingGetDefault(forGamepad, verb, [alternate], [player])` | The default binding from the definition. |
| `InputBindingSet(forGamepad, verb, binding, [alternate], [player])` | Set a binding with no check for conflicts. |
| `InputBindingSetSafe(forGamepad, verb, binding, [alternate], [player])` | Set a binding and resolve conflicts on simple schemes. It returns whether it worked. |
| `InputBindingSetStrict(forGamepad, verb, binding, [alternate], [player])` | Set a binding only if nothing else uses it. |
| `InputBindingSwap(forGamepad, verbA, alternateA, verbB, alternateB, [player])` | Swap two bindings. |
| `InputBindingFind(forGamepad, binding, [player])` | Every verb and alternate that uses a binding. |
| `InputBindingFindCollisions(forGamepad, binding, verb, [player], [alternate])` | The conflicts a new binding would cause. |
| `InputBindingsExport(forGamepad, [player])` | A struct to save. |
| `InputBindingsImport(forGamepad, data, [player])` | Restore a struct from an export. |
| `InputBindingsReset(forGamepad, [player])` | Go back to the defaults. |
| `InputDeviceSetRebinding(device, state, [ignoreArray], [allowArray], [consume])` | Start or stop scanning a device for the next input. |
| `InputDeviceGetRebinding(device)` and `InputDeviceGetRebindingResult(device)` | Whether the device is scanning, and what it found. A negative result means the left or up half of a thumbstick. |
| `InputDeviceStopAllRebinding()` | Stop every scan. |
| `InputGetBindingName(binding, forGamepad, [missing])` and `InputVerbGetBindingName(verb, [alternate], [player], [missing])` | A name for people, `"???"` when unknown. Suitable for debugging, and the Binding Icons plug-in is meant for the finished game. |

**How a rebind runs** (**Documented**). Start a scan with `InputDeviceSetRebinding()`, read the result each frame with `InputDeviceGetRebindingResult()`, then set the binding and stop the scan. Input keeps working normally during a scan, so use the ignore and allow arrays to leave out keys such as the pause key. A scan stops by itself after `INPUT_REBIND_TIMEOUT` so a dead device cannot lock the game (**Source**). Starting and stopping a scan consumes every verb of the player that owns the device, unless the `consume` argument is `false`, so the key that ends a scan does not also trigger a verb (**Source**).

`InputBindingSet*`, `InputBindingFind`, `InputBindingFindCollisions` and `InputGetBindingName` accept a one-character string as well as a key code (**Source**). `InputBindingsImport()` raises an error if a binding has the wrong type for its group (**Source**).

The names `InputGetBindingName()` can return are listed in the page "Binding Names" of the documentation. Keys with no fixed name, such as letters with accents, fall back to the character the key produces (**Documented**).

## Verb functions

| Function | Purpose |
| --- | --- |
| `InputVerbConsume(verb, [player])` and `InputVerbConsumeAll([player])` | Make a verb inactive until the player triggers it again, like `keyboard_clear()`. Useful when a menu closes. |
| `InputVerbCount()` | How many verbs are defined. |
| `InputVerbGetExportName(verb)` | The export name of a verb. |
| `InputVerbGetMetadata`, `InputVerbSetMetadata`, `InputVerbResetMetadata` | Data of your own on a verb, with a way back to the definition. |
| `InputClusterGetMetadata`, `InputClusterSetMetadata`, `InputClusterResetMetadata` | The same for clusters. |
| `InputVerbStateArray([newArray], [player])` | An array of structs with `prevHeld`, `held`, `valueRaw`, `valueClamp` and `duration`, for combos and history. |
| `InputVerbStateWrite(buffer, [player])` and `InputVerbStateByteLength()` | Write the verb state into a buffer, and how many bytes it needs. |

## Mouse and touch

These functions read the pointer directly, apart from verbs. On consoles the three button checks always return `false`, because `INPUT_BLOCK_MOUSE_CHECKS` is on there (**Source**).

| Function | Purpose |
| --- | --- |
| `InputMouseRoomX()` and `InputMouseRoomY()` | Position in room space. |
| `InputMouseGuiX()` and `InputMouseGuiY()` | Position in GUI space. |
| `InputMouseDeviceX()` and `InputMouseDeviceY()` | Position in device space. |
| `InputMouseCheck`, `InputMousePressed`, `InputMouseReleased` `([button])` | Button state. The default is `mb_left`. |
| `InputMouseMoved()` | Whether the mouse moved since the last frame. |
| `InputMouseSetBlocked(state)` and `InputMouseGetBlocked()` | Freeze the position and the buttons. |

### Virtual buttons

`InputVirtualCreate()` returns a struct you set up by calling methods in a chain. The coordinates are in GUI space. Virtual buttons need `INPUT_TOUCH`, or `INPUT_KBM` with `INPUT_MOUSE_CAN_USE_VIRTUAL_BUTTONS` (**Documented**). A virtual button lives until you call `.Destroy()` on it (**Documented**).

| Group | Methods |
| --- | --- |
| Shape | `.Rectangle(left, top, right, bottom)`, `.Circle(x, y, radius)`, `.GetPosition()`. |
| Type | `.Button(verb)`, `.HPad(click, left, right)`, `.VPad(click, up, down)`, `.DPad(click, left, right, up, down, [4dir])`, `.Thumbstick(...)`, `.Touchpad(...)`, `.GetType()`, `.GetVerbs()`. |
| Behaviour | `.Threshold(min, max)`, `.Active(state)`, `.Priority(n)`, `.Follow(state)`, `.ReleaseBehavior(option)`, `.FirstTouchOnly(state)`, `.ReferencePoint(option)`, `.Momentary(state)`, each with a matching `Get` method. |
| State | `.Pressed()`, `.Check()`, `.Released()`, `.GetX()`, `.GetY()`, `.GetTouchX()`, `.GetTouchY()`, `.GetTouchDX()`, `.GetTouchDY()`, `.GetTouchStartX()`, `.GetTouchStartY()`. |
| History | `.RecordHistory(state)`, `.GetHistory()`, `.GetHistoryDirection([frames])`, `.GetHistoryDistance([frames])`, `.GetHistorySpeed([frames])`. |
| Debug | `.DebugDraw()`. |

Two functions work on all of them: `InputVirtualDestroyAll()`, which is useful when a gamepad appears, and `InputVirtualDebugDraw()`. Call both debug functions in a Draw GUI event.

The pads and the thumbstick send digital or analogue verbs as their type says. A touchpad reacts to the speed of the finger, needs `.Threshold()` with a minimum near 1 and a maximum near 20, and ignores `.ReferencePoint()` (**Documented**).

## Other functions

| Function | Purpose |
| --- | --- |
| `InputGameHasFocus()` | Whether the game window has focus. |
| `InputGetSteamInfo(field)` | A boolean for a member of `INPUT_STEAM_INFO`. |
| `InputManualCollect()` | Collect input yourself. Call it only when `INPUT_COLLECT_MODE` is 2. |
| `InputManualUpdate()` | Update the library state. Call it only when `INPUT_UPDATE_AFTER_COLLECT` is `false`, or the library raises an error (**Source**). |

## Plug-ins

Plug-ins are optional features kept out of the core. The package of 10.5.0 holds the code of all eight (**Source**). Several have their own config script, such as Cursor, Vibration, Trigger Effects and Verb Groups (**Source**). Their functions and settings are in the documentation, one page each.

| Plug-in | What it is |
| --- | --- |
| Binding Icons | Returns the icon that matches a binding for the current device and gamepad type. |
| Party Multiplayer | Assigns devices to players as people join and leave a game. |
| Cursor | Gives each player a cursor that works with mouse, keyboard and gamepad. |
| Verb Groups | Lets verbs in different groups share one binding, for example menu verbs and game verbs. |
| Gyro & Motion | Reads the motion sensors of gamepads that have them. |
| Vibration | Plays vibration effects on gamepads. |
| Color | Sets the light colour of gamepads that have an LED. |
| Trigger Effects | Sets resistance and vibration on the adaptive triggers of the DualSense. |

Extended gamepad features work on these platforms (**Documented**).

| Feature | Platforms |
| --- | --- |
| Vibration | Consoles, and Xbox gamepads on Windows. Other gamepads need Steamworks. |
| Gyro & Motion | PlayStation, Switch, and Windows and Linux with Steamworks. |
| Color | PlayStation, and Windows and Linux with Steamworks. |
| Trigger Effects | PlayStation 5, and Windows with Steamworks. |

### Writing a plug-in

A plug-in registers with `InputPlugInDefine(alias, author, version, targetInputVersion, initCallback)` in global scope before the first step, and attaches methods to the events of `INPUT_PLUG_IN_CALLBACK` with `InputPlugInRegisterCallback()` inside its init callback (**Documented**). The rest of the `InputPlugIn*` functions set verb values, block or remap gamepads, check dependencies, read the frame and the time and report errors (**Documented**). `InputPlugInVerbSet()` works only inside a `COLLECT_PLAYER` callback, and `InputPlugInVerbStateSet()` and `InputPlugInVerbStateRead()` only inside an `UPDATE_PLAYER` callback (**Source**).

## Status and errors

The library reports state through `InputPlayerGetStatus()`, `InputPlayerIsConnected()`, `InputDeviceIsConnected()`, `InputDeviceIsActive()` and `InputGetSteamInfo()`. It prints one welcome line with its version and the GameMaker runtime version at start-up (**Source**). It has no function that reports its own health. A gamepad counts as disconnected only after 300 milliseconds without it, so a short drop does not show (**Source**).

The library reports misuse with `show_error()`, and does not return an error code (**Source**). The message starts with "Input" and the version. On the web it also carries the call stack (**Source**). The call passes `false` for the abort argument, so the dialogue itself does not end the game (**Source**).

| Condition | When it is raised |
| --- | --- |
| Player index not a number, below 0 or at or above `INPUT_MAX_PLAYERS` | Any function with a player argument, when `INPUT_SAFETY_CHECKS` is `true`. |
| Cluster index not a number, below 0 or too large | Any cluster function, with the same setting. |
| `InputDefineVerb()` or `InputDefineCluster()` outside `__InputConfigVerbs()` | When the game runs from the IDE. |
| Repeated verb export name | When the game runs from the IDE. |
| `InputPlayerSetDevice()` with a real device for a player above 0 | While hotswap is on. |
| `InputPlayerSetDevice()` with `INPUT_KBM` for a player above 0 | While `INPUT_KBM_FIRST_PLAYER_ONLY` is `true`. |
| `InputManualCollect()` | Unless `INPUT_COLLECT_MODE` is 2. |
| `InputManualUpdate()` | Unless `INPUT_UPDATE_AFTER_COLLECT` is `false`. |
| `InputBindingsImport()` with something other than an export, or a binding of the wrong type | On import. |
| The controller object destroyed, deactivated, made non-persistent or moved in depth | At run time, in collect mode 0. |
| `InputVerbStateWrite()` data with a wrong header, footer or verb count | On read. |
| A virtual button history request over `INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES`, or under 1 | On the call. |
| A rebinding ignore or allow list that is not an array or `undefined` | On `InputDeviceSetRebinding()`. |
| Steam application ID 480 with Steamworks active | At start-up. |
| A plug-in defined twice, defined after start-up, defined at priority 0, missing a dependency or too new for the library | At start-up or at registration. |
| `InputPlugInVerbSet()` outside `COLLECT_PLAYER`, or `InputPlugInVerbStateSet()` and `InputPlugInVerbStateRead()` outside `UPDATE_PLAYER` | On the call. |

All of these are **Source**. What happens after the dialogue was not checked.

## Known defects

None of these was reproduced, and each comes from reading the code of 10.5.0 (**Source**). None was reported upstream as far as this document knows.

| Symptom | Cause |
| --- | --- |
| The doc comment of `InputManualUpdate()` says it collects input | It updates the state. The doc comment was copied from `InputManualCollect()`. |
| The doc comment of `InputDeviceGetNewActivityOnVerb()` has a misspelled `@parma` tag | A typing slip in the comment. |

No defect that changes behaviour was found by reading.

## Examples

These come from the official guides (**Documented**).

Define verbs for a keyboard and a gamepad:

```gml
function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        LEFT,
        RIGHT,
        SHOOT,
    }

    InputDefineVerb(INPUT_VERB.LEFT,  "left",  vk_left,  -gp_axislh);
    InputDefineVerb(INPUT_VERB.RIGHT, "right", vk_right,  gp_axislh);
    InputDefineVerb(INPUT_VERB.SHOOT, "shoot", vk_space,  gp_face1);
}
```

Check them like native input:

```gml
if (InputCheck(INPUT_VERB.LEFT )) x -= 4;
if (InputCheck(INPUT_VERB.RIGHT)) x += 4;
if (InputPressed(INPUT_VERB.SHOOT)) show_debug_message("bang");
```

Give a verb two alternates for each device:

```gml
InputDefineVerb(INPUT_VERB.LEFT, "left", [vk_left, "A"], [gp_padl, -gp_axislh]);
```

Read a cluster as a direction:

```gml
enum INPUT_CLUSTER { NAVIGATION }
InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);

var _direction = InputDirection(-1, INPUT_CLUSTER.NAVIGATION);
```

Save and restore bindings, with a struct written to a file by any method you like:

```gml
var _saved = InputBindingsExport(true);
InputBindingsImport(true, _saved);
```

## Updating

### To a new version

From the documentation (**Documented**).

1. Back up the scripts in the `Config` folder, with source control.
2. Delete the `Input` folder from the asset browser.
3. Import the new `.yymps` file.
4. Restore the config scripts, and check them, because the macros can change between versions.

### From version 8

Version 10 is a rewrite and the names changed (**Documented**).

- The API went from snake_case to PascalCase.
- Verbs are enum integers and no longer strings.
- "Sources" are now called devices.
- Each player has one device, and players can no longer share a device.
- The mouse is part of the keyboard device.
- Binding profiles shrank to two, one for keyboard and mouse and one for gamepads.
- Clusters replace the old 2D checker setup.
- Plug-ins replace several features.
- Dropped features: chords, combos, replay, device-independent cursors, accessibility features, a separate mouse device, the mixed and multi device types, several gamepad profiles, keyboards outside desktop, the built-in debug overlay and tester, and the mouse capture functions.

The documentation has a page that maps each old function to its new one.

### From 10.3.0 to 10.5.0

This comes from comparing the two packages (**Source**).

| Change | What to do |
| --- | --- |
| `INPUT_NO_DEVICE`, `INPUT_KBM`, `INPUT_TOUCH` and `INPUT_GENERIC_DEVICE` have new values | Use the names. Do not store the numbers. |
| The thumbstick and trigger "reports active" settings default to `false`, they were `true` | Set them back to `true` if you want analogue movement to hotswap. |
| `InputBindingGetDefault()` and `InputBindingSetStrict()` are new | None. |
| The binding functions accept a one-character string | None. |
| `InputBindingsImport()` raises an error for a binding of the wrong type | Check saved files. |
| `InputDefineVerb()` accepts `undefined` as an export name and raises an error for a repeated name when run from the IDE | Check for repeated names. |
| `InputDeviceEnumerate()` has no `includeGenericDevice` argument | Remove the argument. |
| `InputPlayerUsing*()` gained the `complianceSafe` argument, and `InputPlayerUsingKbm()` returns `false` on console by default | Pass `false` if you need the real answer. |
| `InputVerbConsume()` also refreshes the clusters that hold the verb | None. |
| Switch 2 is supported, with `INPUT_ON_SWITCH_2` and `INPUT_ON_SWITCH_X` | None. |
| New settings `INPUT_SWITCH_X_KNOWN_GOOD`, `INPUT_XBOX_SIMPLIFIED_USER_MODEL` and `INPUT_KBM_FIRST_PLAYER_ONLY` | Add them to your config script. |
| `INPUT_STEAM_INFO` gained a third member | None. |

## Quirks and troubleshooting

Input already works around the quirks that say so (**Documented**). The rest need your attention.

| Platform | Quirk | What to do |
| --- | --- | --- |
| Windows | Devices 0 to 3 are XInput and carry less data. Devices 4 to 11 are DInput. | Use Steamworks for more vibration. |
| Windows | Xbox Game Bar can freeze or slow the game with Xbox gamepads. | Turn the Game Bar off. |
| Windows | Bluetooth gamepads fail below Windows 10. | None. |
| macOS | The gamepad select button starts a screenshot or a recording. | Do not make it a default binding. |
| macOS, Linux | No gamepad vibration. | None. |
| Linux | Keys outside Basic Latin are not detected. Gamepad indexes are unpredictable. | Bind only Basic Latin keys and assign gamepads by activity. |
| Steam | The overlay takes F12 and Shift+Tab. Native gamepads show up as virtual ones. | Avoid those keys. Set up Steamworks. |
| Switch | The first gamepad index is for the attached Joy-Cons. Keyboard and touch are off by default. Mouse and touch share one device. | Use higher indexes. |
| PlayStation | `gp_select` is the touchpad click. There is no keyboard. | Read names with the binding name functions. |
| Xbox | No keyboard or mouse. | None. |
| iOS | No working keyboard. Gamepad indexes start at 1. Few gamepads work. The select button records the screen. | Assign by activity and check Apple's list. |
| Android | Keys stick with Shift. Gamepad indexes are unpredictable. Some gamepads misreport or lack the d-pad. | Keep the keyboard off, or bind only arrows, Enter, Space and Backspace. Block bad devices. |
| Web | A gamepad needs one button press with the game in focus. The browser takes the fullscreen key. | Ask the player to press a button. |
| Mobile, web | Mouse and touchscreen share one device, so Input cannot tell them apart. | Mouse input is off by default. |

Gamepad problems have a short list of fixes (**Documented**). Check that the gamepad works at the operating system level. Turn off remappers such as Steam Input or DS4Windows. Use Bluetooth for Switch controllers. Send the data of an uncommon model to the SDL community gamepad database.

**Frequently asked** (**Documented**).

- Analogue input does not hotswap by default. Change the "reports active" settings.
- Players cannot share the keyboard or one gamepad.
- To save bindings, export them, write the struct to a file and import it on load.
- The profiler's `Step (%)` column misleads. Read `Time (ms)`.

## Where the documentation and the code differ

They are in order of impact, with the ones that change behaviour first.

| Documentation says | Code has |
| --- | --- |
| `INPUT_NO_DEVICE` is -666, `INPUT_KBM` -1, `INPUT_TOUCH` -2 and `INPUT_GENERIC_DEVICE` -3 | -1, -100, -200 and -300. |
| `INPUT_PS5_SINGLE_USER` and `INPUT_XBOX_SIMPLIFIED_USER_MODEL` default to `true` | Both default to `false`. |
| `InputPlugInVerbSet()` runs from the `UPDATE_PLAYER` callback | It runs only from `COLLECT_PLAYER`. |
| Application ID 480 is unsuitable for Steam Input | It raises an error at start-up. |
| `INPUT_GAMEPADS_TICK_PREDELAY` in frames | `INPUT_GAMEPADS_COLLECT_PREDELAY` in milliseconds, 1000 off consoles and 0 on them. |
| `INPUT_GAMEPADS_DISCONNECTION_TIMEOUT` in frames | The same name in milliseconds, 300. |
| `INPUT_TOUCH_HISTORY_FRAMES` | `INPUT_VIRTUAL_BUTTON_HISTORY_FRAMES`. |
| `INPUT_SWITCH_KEYBOARD_ALLOWED` and `INPUT_ANDROID_KEYBOARD_ALLOWED` | Neither macro exists in the package. |
| `InputPlugInGetExists(alias)` | `InputPlugInExists(alias)`. |
| `InputVerbGroupGet(verb)` | `InputVerbGroupsGet(verb)`. |
| `InputDeviceEnumerate([includeGenericDevice])` | No argument. |
| `InputDeviceGetPlayerUsingGeneric([ignoreDisconnected])` | No argument. |
| `InputPlayerGetInactive(duration, [player])` with a required duration | The duration defaults to 500. |
| `InputPlayerGetStatus([player])` | The player argument has no default. |
| `InputVerbStateByteLength([player])` | No argument. |
| `InputBindingsReset()` with no arguments, for all bindings | It takes `forGamepad` and a player, and resets one group of one player. |
| `InputBindingSetStrict()` returns `undefined` | It returns `true` or `false`. |
| `InputPlayerUsing*([player])` | A second argument, `complianceSafe`. |
| The quirks name `input_binding_get_name()` | The function is `InputGetBindingName()`. |
| The plug-ins page says ten official plug-ins and lists eight | The package holds eight. |

The documentation leaves out `InputXYNewest`, `InputXYOldest`, `InputDeviceGetNewActivityOnVerb`, `InputManualUpdate`, `InputVibrateDirect`, `InputPlugInGamepadGetVendorAndProduct` and `INPUT_PLUG_IN_CALLBACK.FIND_BINDING_COLLISIONS`.
