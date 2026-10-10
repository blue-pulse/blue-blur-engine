# 0002. Run the game with Igor Run and the prefabs flag

## About this document

This record is the decision about how the project is run from the command line. It is for anyone about to change the Igor command in `tools/`, switch it to a packaging action or make an MCP server a requirement. It states the command, the flag that matters and what was refused. It does not describe Igor, which [reference/igor.md](../reference/igor.md) does. Update it only when the way the project is run changes.

- Status: accepted
- Date: 2026-10-10
- Decision-makers: the maintainer

## Summary

- The tools in `tools/` run Igor with the action `Run` and pass `--pf` with the `Prefabs` folder of the installation.
- Never remove `--pf`, and never switch to `PackageZip` to start the game.
- No task of the project depends on an MCP server, which stays optional.

## Context and problem statement

The project runs from the IDE. A person, an agent or an automation service also needs a command that works on a clean checkout. Three routes were tried with runtime 2026.0.0.23 on Windows.

- Igor called with the options the manual lists, and no prefabs path. The asset compiler stopped with `Cannot find the project folder for prefab package` for each of the 20 prefab packages the project uses, because Igor only looked inside the project folder.
- `PackageZip`, which the MCP server GMS MCP uses by default. The build finished, then Igor exited with code 1 and an empty `destFileName` error, and the server could not start the executable because its name differs from the project file name.
- `Run` with `--pf`. The game started and closed with exit code 0.

## Decision outcome

The tools build one Igor command and run it. They pass `/uf`, `/rp`, `/project`, `/cache` and `/temp`, `--pf` with the `Prefabs` folder of the installation, and end with `-- <Platform> Run`. The cache and temporary folders live in `.sandbox/`.

The rules for finding the runtime, the licence folder and the prefabs come from reading the source of GMS MCP, which had already solved them. GMS MCP stays an optional helper for reading and editing assets, described in [reference/gms-mcp.md](../reference/gms-mcp.md).

The practice behind this is a thin wrapper over the tool's own command line, as the Gradle Wrapper and Unity's batch mode do. This is from memory and not from their documentation.

## Consequences

- Without `--pf`, Igor stops before compiling and nothing runs.
- With `PackageZip` in place of `Run`, the Windows command exits with code 1 and the executable name depends on the game options, so the launch step breaks.
- Making GMS MCP a requirement ties running the game to a server that hides any error containing `Traceback` and does not start executables with another name.
- `--pf` is not in the manual, so a later runtime may stop accepting it. The manual lists `/prefabs` with `/projecttool` for the same job, and it has not been tried.
- The paths for macOS and Linux were taken from the source of GMS MCP and have not been run.

## Considered options

- **`PackageZip`, then start the executable.** Refused for the reasons above.
- **GMS MCP as the way to run the game.** Refused because it fails on this project and hides the reason.
- **`/prefabs` with `/projecttool`, as the manual documents.** Not chosen because it needs the Project Tool, a separate download, while `--pf` needs nothing extra. It stays the fallback if `--pf` stops working.
