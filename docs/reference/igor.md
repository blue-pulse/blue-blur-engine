# Igor

## About this document

This document describes Igor, the command line tool that ships with every GameMaker runtime. It is for anyone who builds, runs or tests a GameMaker project without the IDE, on a developer machine or in automation. It contains where Igor lives, the options and commands that matter, examples, behaviour seen in practice and the problems people meet. It leaves out the IDE, the setup of platform SDKs and the details of platforms other than the ones it names. Update it when a new runtime changes an option or a default.

Each fact carries one of three marks. **Manual** means the official manual states it. **Observed** means it was seen by running the runtime named in the text. **Unverified** means it comes from reading another tool's source, or from the manual without a run to confirm it.

## What Igor is

Igor is a program inside each runtime folder. It compiles, runs, cleans, packages and tests a project, and the IDE calls it too. Running it directly lets a script or a CI service do what the IDE does. The official page is [Building and Testing via Command Line](https://github.com/YoYoGames/GameMaker-Manual/blob/develop/Manual/contents/Settings/Building_via_Command_Line.htm).

Igor needs three things.

- An installed runtime, which holds the Igor program itself.
- A licence file, which exists once somebody has signed in to the IDE on the machine, or which an access key can generate (**Manual**).
- For a project that uses prefabs, the prefab packages of the installation (see [Prefabs](#prefabs)).

## Where things are

`<install>` is the name of the installation folder. It is `GameMakerStudio2` for the stable release, and **Observed** as `GameMakerStudio2-LTS2026` for the LTS 2026 release.

| Item | Windows | macOS | Linux |
| --- | --- | --- | --- |
| Runtime folder | `C:\ProgramData\<install>\Cache\runtimes\runtime-<version>` (**Manual**) | `/Users/Shared/<install>/Cache/runtimes/runtime-<version>` (**Manual**) | Under `~/.local/share`, `/var/opt` or `/opt` (**Unverified**) |
| Igor program | `bin\igor\windows\x64\Igor.exe` inside the runtime folder (**Manual**) | `bin/igor/osx/<architecture>/` inside the runtime folder, run as `dotnet Igor.dll` (**Manual**) | `bin/igor/linux/x64/Igor` inside the runtime folder (**Unverified**) |
| User folder | `%APPDATA%\<install>\<user>_<number>` (**Manual**) | `~/Library/Application Support/<install>/<user>_<number>` (**Manual**) | `~/.config/<install>/<user>_<number>` (**Unverified**) |
| Licence file | `licence.plist` in the user folder (**Manual**) | The same (**Manual**) | The same (**Unverified**) |
| Prefabs folder | `C:\ProgramData\<install>\Prefabs` (**Observed**) | Not checked (**Unverified**) | Not checked (**Unverified**) |

More than one user folder can exist under the installation folder. Only the one that was signed in holds `licence.plist` (**Observed**).

Some tools run the macOS file `Igor` directly instead of `dotnet Igor.dll`. Which one is right is **Unverified**.

## Options

Put every option before the `--` that separates the options from the command. The table is a summary of the manual, so read the [manual page](https://github.com/YoYoGames/GameMaker-Manual/blob/develop/Manual/contents/Settings/Building_via_Command_Line.htm) for the full text and the branch note in the last section.

| Option | What it does |
| --- | --- |
| `/project=<file>` | Path to the `.yyp` project file. |
| `/rp=<folder>` | The runtime folder to use. |
| `/uf=<folder>` | The user folder, from which Igor reads the licence and the device list. |
| `/lf=<file>` | Path to the licence file. It is an alternative to `/uf` (**Manual**). `/uf` alone was enough to run (**Observed**). |
| `/df=<file>` | Path to `devices.json`, needed to build for another device. |
| `/device=<name>` | Name of the target device, as set up in the IDE. |
| `/cache=<folder>` | Cache folder. It defaults to `cache` in the current folder. |
| `/temp=<folder>` | Temporary folder. It defaults to `c:\temp`. |
| `/of=<path>` | Output path without an extension. Without it, Igor writes an `output` folder where the command runs. |
| `/tf=<file>` | Name of the ZIP or installer file to create. |
| `/config=<name>` | Configuration to build. It defaults to `Default`. |
| `/runtime=VM` or `YYC` | Compiler. It defaults to VM. |
| `/j=<number>` | Number of CPUs to use. |
| `/launch` | Launch the result on the device after building. |
| `/v` | More verbose output. |
| `/jsonErrors` | Print unhandled errors as JSON on the error output. |
| `/prefabs=<folder>` and `/projecttool=<file>` | Where the prefab collections are, and the Project Tool needed to use them. They go together (**Manual**). Not tried. |
| `--pf=<folder>` | The prefabs folder of the installation. The manual does not list it. It worked with runtime 2026.0.0.23 on Windows (**Observed**). |

## Commands

A command has the form `Igor.exe <options> -- <Platform> <Action>`.

- **Platform** is one of `Windows`, `Mac`, `Linux`, `HTML5`, `ios`, `Android`, `tvos`, `ps4`, `ps5`, `XBoxOne`, `XBoxOneSeriesXS`, `Switch` or `OperaGX` (**Manual**). Note that the token for macOS is `Mac`.
- **Action** is `Compile`, `Clean`, `Run`, `Package`, `PackageZip`, `PackageNsis` or `PackageDMG`, and `folder` for HTML5. Not every platform has every action (**Manual**).

Igor also has commands that manage runtimes and licences, written `Igor.exe <options> Runtime <Command>` (**Manual**).

| Command | What it does |
| --- | --- |
| `Runtime List` | Lists the runtimes on the feed. |
| `Runtime ListInstalled` | Lists the runtimes in a folder. |
| `Runtime Info` | Shows the newest runtime and its modules. |
| `Runtime Install` | Installs a runtime. `/modules` limits which platform modules are downloaded. |
| `Runtime Verify` | Checks the installed files against the manifest. |
| `Runtime FetchLicense -ak=<key> -of=<file>` | Creates a licence file from an access key. |

`Tests RunTests <folder or tests.json>` runs the project test mode (**Manual**). By default it builds each project it finds and passes the test if the game is still running after the wait time (30 seconds), so it detects crashes and not wrong results.

## Examples

Run a project on Windows (**Observed** with runtime 2026.0.0.23):

```
Igor.exe /uf=<user-folder> /rp=<runtime-folder> /project=<project>.yyp /cache=<cache-folder> /temp=<temp-folder> --pf=<install>\Prefabs -- Windows Run
```

Create a licence file on a machine without the IDE (**Manual**), then pass it with `/lf`:

```
Igor.exe runtime FetchLicense -ak=<access-key> -of=<licence-file>
```

An access key is a secret. Keep it in the secret store of the service that runs Igor, and never in the repository.

## Behaviour seen in practice

These observations come from runtime 2026.0.0.23 on Windows.

- `Run` compiles, starts the game and keeps running until the game closes. Closing the window normally ends Igor with exit code 0.
- `Run` writes its build into an `output` folder where the command runs.
- `game_end([return_code])` sets the return code of the game ([manual page](https://github.com/YoYoGames/GameMaker-Manual/blob/develop/Manual/contents/GameMaker_Language/GML_Reference/General_Game_Control/game_end.htm)). Whether Igor passes it on as its own exit code is **Unverified**.
- `PackageZip` on Windows without `/tf` builds the game and then fails with exit code 1 and `System.ArgumentException: The value cannot be an empty string. (Parameter 'destFileName')`. The executable is already built at that point. Its name comes from the project's Windows game options, so it can differ from the project file name.
- A processor count of one (`DOTNET_PROCESSOR_COUNT=1` in the environment) is set by some tools for the LTS 2026 runtime to avoid crashes (**Unverified**).

## Running a built game directly

A Windows executable accepts parameters (**Manual**, [Command-Line Parameters](https://github.com/YoYoGames/GameMaker-Manual/blob/develop/Manual/contents/Settings/Command_Line_Parameters.htm)). The useful ones are `-output <file>`, which writes the console output to a file, `-noaudio`, `-inawindow` and `-jsonErrors`.

## Problems

| Symptom | Cause | What to do |
| --- | --- | --- |
| `Cannot find the project folder for prefab package '<name>'`, then the asset compiler exits with `-1` | Igor looked for the prefab packages in the project folder only | Pass `--pf=<install>\Prefabs`, or use `/prefabs` with `/projecttool` |
| `The value cannot be an empty string. (Parameter 'destFileName')` at the end of `PackageZip` | No `/tf` on Windows | Add `/tf`, or use `Run` when the aim is only to start the game |
| The build does not start and the user folder holds no `licence.plist` | Nobody signed in to the IDE on the machine (**Manual**) | Sign in once, or create a licence file with an access key |
| Errors about long paths | Some platforms limit the path length (**Manual**) | Use short folders, or map a drive with `subst` |
| `Igor: unknown command` | The command or the platform token is wrong (**Unverified**) | Check the token, for example `Mac` and not `macOS` |

## The manual and its branches

The links on this page point to the `develop` branch of the manual repository. That branch can describe options newer than the runtime in use. The page of the `2026.0.0-main` branch is older and lacks several options, such as `/prefabs`, `/projecttool`, `/jsonErrors` and `/lf` (**Observed**, by a quick read).
