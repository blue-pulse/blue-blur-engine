# GMS MCP

## About this document

This document describes GMS MCP, a third-party server that lets an AI assistant work on a local GameMaker project through the Model Context Protocol (MCP). It is for anyone who wants to install it, connect it to a client or know where it falls short. It contains what it is, how to install and connect it, its access profiles, its settings, the files it creates, how it runs Igor and the limits seen in practice. It leaves out the internals of the server and the tools for editing assets, which its own documentation covers. It describes version 0.0.15. Update it when a new version changes how it installs, connects or runs Igor.

Each fact carries one of three marks. **Documented** means the project's own documentation states it. **Observed** means it was seen by running version 0.0.15 on Windows with runtime 2026.0.0.23. **Source** means it comes from reading the code and was not run.

## What it is

GMS MCP is an independent open-source project by Ampersand Game Studios under the MIT licence. It is not an official GameMaker product. Its repository is [Ampersand-Game-Studios/gms-mcp](https://github.com/Ampersand-Game-Studios/gms-mcp).

It gives an assistant tools to inspect assets, find GML definitions and references, check a project, compile and run it through Igor, and edit assets. The package also includes the `gms` command line tool, which needs no AI client (**Documented**).

It needs Python 3.10 or newer, a GameMaker project with a `.yyp` file and a client that supports MCP. Building and running also need an installed runtime and a licence (**Documented**).

## Install and connect

Install it with `pipx install gms-mcp` (**Documented**). `uv tool install gms-mcp` also worked (**Observed**). The package installs three commands.

| Command | Purpose |
| --- | --- |
| `gms-mcp` | Starts the server or checks the environment (`gms-mcp doctor`). |
| `gms-mcp-init` | Writes the client configuration. |
| `gms` | Runs project operations from a terminal. |

Run the initializer from the project folder. For Claude Code:

```
gms-mcp-init --client claude-code --scope workspace --action app-setup
```

Useful options (**Observed**):

| Option | Effect |
| --- | --- |
| `--profile safe`, `standard` or `full` | Sets the access profile. |
| `--toolsets core,runtime` | Chooses which groups of tools are enabled. |
| `--gm-project-root <folder>` | Names the folder that holds the `.yyp`. Use it when the tree holds more than one `.yyp`, for example inside a prefabs folder. |
| `--non-interactive`, `--no-star-ask`, `--telemetry off` | Avoid prompts and turn telemetry off for the run. |
| `--dry-run` | Prints what would be written and writes nothing. |

A client reads its tools when it starts, so restart the client after setup. Then ask it to call `gm_capabilities` and `gm_project_info` to confirm the connection (**Documented**).

## Access profiles

| Profile | Access |
| --- | --- |
| `safe` | Read-only core tools. It is the default of the canonical setup. |
| `standard` | The full core set, including tools that change files and build. |
| `full` | Core plus every optional group. |

The profiles `standard` and `full` allow writes and do not require every change to be a dry run (**Documented**). Optional groups are `assets`, `bridge`, `docs`, `events`, `maintenance`, `resourcetool`, `rooms`, `runtime` and `texture-groups`. `safe` accepts none of them.

## Files it creates

For Claude Code, the initializer wrote the first two files in the project folder (**Observed**).

| File | Purpose |
| --- | --- |
| `.mcp.json` | The server entry, with `GM_PROJECT_ROOT`, `GMS_MCP_TOOLSETS` and the safety settings. |
| `.claude-plugin/` | A plugin manifest. |
| `.gms_mcp/runtime.json` | Created by `gm_runtime_pin`, holds the pinned runtime version (**Source**). |

The server also writes diagnostic logs outside the project, in `~/.gms-mcp/logs/<project-id>/` (**Documented**). None of these files is useful on another machine.

## Settings

Environment variables the server reads:

| Variable | Effect | Mark |
| --- | --- | --- |
| `GM_PROJECT_ROOT` | The project the server is pinned to. | **Documented** |
| `GMS_MCP_TOOLSETS` | Enabled groups of tools, or `all`. | **Documented** |
| `GMS_PREFABS_PATH` | The prefabs folder to pass to Igor. | **Documented** |
| `GMS_MCP_HTTP_BEARER_TOKEN` | Token for the optional local HTTP transport. | **Documented** |
| `GMS_RUNTIME_VERSION` | Forces a runtime version. | **Source** |
| `GMS_MCP_RUNTIME_ROOT` | Replaces the folders searched for runtimes. | **Source** |
| `GMS_MCP_LICENSE_FILE` | The exact licence file to use. If it is missing, nothing else is searched. | **Source** |
| `GMS_MCP_IGOR_PROCESSOR_COUNT` | Processors for Igor. It defaults to 1. | **Source** |

## Running the project

The tools `gm_compile`, `gm_run`, `gm_run_status`, `gm_run_stop` and `gm_runtime_list`, `gm_runtime_pin`, `gm_runtime_unpin` and `gm_runtime_verify` need the `runtime` group. `gm_mcp_health` checks the project, Igor, the licence and Python.

The server builds an Igor command from the files it finds. It reads the runtime from the usual install folders, the licence from the user data folder of that installation and the prefabs from the `Prefabs` folder of the installation. It passes `/uf`, `/lf`, `/rp`, `/project`, `/cache`, `/temp` and `--pf` to Igor, the command line tool of the runtime (**Source**).

`gm_run` has two modes, chosen by `output_location` (**Source**).

- `temp`, the default, runs `PackageZip` into a folder in the system temp folder and then starts the executable it finds.
- `project` runs `Run` and lets Igor start the game.

## Limits seen in practice

These were seen with version 0.0.15 on Windows with runtime 2026.0.0.23.

- On Windows, `PackageZip` gets no `/tf`, so it fails at the end with an empty `destFileName`. The server tolerates this and looks for the executable.
- It looks only for `<project name>.exe`, `template.exe` and `runner.exe`. An executable with another name is built but not started, and the server reports `Launch target not found`.
- `gm_compile` reports failure with exit code 1 when `PackageZip` fails, even though the compile finished.
- `gm_run` in the background returned `Internal tool error; host details were withheld`, with no reason. The server replaces any message that contains `Traceback` with that text, so the real error is hidden. The code that applies this filter sits in the MCP server, so the `gms` command line tool should not hide the error (**Source**, not run).
- On macOS and Linux the paths and the Igor program come from the source and were not run.

## Safety and privacy

- Each server process is pinned to one project and checks that paths stay inside it (**Documented**).
- Tools return project source and metadata to the client, so the AI provider sees them (**Documented**).
- Telemetry is off by default, and `gms telemetry disable` turns it off for good (**Documented**).
- The optional HTTP transport listens on the local machine only and needs a bearer token (**Documented**).

## Updating

`pipx upgrade gms-mcp`, then restart the client. `gms-mcp doctor` checks the environment (**Documented**).
