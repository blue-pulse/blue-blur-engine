# Painfully learned lessons about GameMaker

## About this document

This document condenses a public list of problems that GameMaker users hit and the causes and remedies its author gives for them. It is for a programmer who meets a crash, a build failure, a slowdown, a graphics oddity or a platform quirk and wants to know whether it is a known behaviour of GameMaker before debugging their own code. It covers the stability, performance and graphics entries of the list, the page on debugging HTML5 and the page on Spine runtime problems. It leaves out the long optimisation tier list that the repository archives, which is a different author's post and was not read, and it leaves out any advice on how to write a game. Update it when the upstream repository changes, by reading the changed files again and replacing the commit and the date below.

## Source, version and licence

- Upstream: [JujuAdams/painfully-learned-lessons](https://github.com/JujuAdams/painfully-learned-lessons), maintained by Juju Adams, with contributions welcome.
- Version documented: branch `main` at commit `21ebbb4c386853e3c9e22add491540f006f2193c`, committed on 2026-04-04. Files read: `README.md`, `HTML5.md` and `spine.md`, downloaded on 2026-11-19.
- Licence: the repository has no licence file and the GitHub metadata declares none. The text is therefore paraphrased here and never copied, and a reader who wants the exact wording opens the upstream file.
- Not read: `optimization.md` (90 KB), an archive of a forum post by another author.

## How to read the claims

Every entry is a claim of the upstream author, read on 2026-11-19 and not checked against the manual or by running GameMaker. Two marks qualify it.

- **Stated** means the author gives it as a fact about GameMaker, often with the runtime version where it appeared. Versions and dates are the author's.
- **Relayed** means the author quotes another person. The upstream text names the source, a Reddit user for the policy error, and the author does not vouch for it.

Behaviour changes between runtime releases, so a claim that names a version may no longer hold on a newer one. Check the version before relying on it.

## Stability

| Symptom | Cause given | Remedy given |
| --- | --- | --- |
| The game closes with no error message | Not stated | Run it on YYC to generate a C++ project, then run the generated solution under the Visual Studio debugger. If that does not solve it, it still makes a better bug report for YoYo Games (**Stated**) |
| No export options with a subscription or a permanent licence | The IDE is not logged into the Opera account, or it shows a stale login | Log in. If the exports are still missing, log out and in again from the blue account icon at the top right. The author calls it a bug present since 2022.2.0.71, dated 2023-03-03 (**Stated**) |
| A gamepad does not work | GameMaker lacks mapping data for that make and model | Use the Input library, or add an updated `gamecontrollerdb.txt` from the SDL game controller database to the Included Files. A Nintendo Switch Pro controller does not work over USB on PC, so use Bluetooth or Steam (**Stated**) |
| YYC stops compiling after a one-line change | The module sometimes loses track of which files changed, mostly after adding scripts or objects | Press Clean Cache, the brush icon beside the run buttons, to rebuild from scratch. Deleting single files from the cache gives a smaller rebuild but is rarely worth the trouble (**Stated**) |
| Error `0x800711C7`, "An Application Control policy has blocked this file" | Anti-virus or Windows Smart App Control blocks a runtime file, `FileIO.dll` in the reported case | Add exclusions for `C:\ProgramData\GameMakerStudio2` and for `AppData\Local\GameMakerStudio2` under the user profile, and restart the IDE if needed. Switching Smart App Control off also works but it is hard to switch back on. The author calls this rare (**Relayed**) |
| HTML5 misbehaves | The author calls the target janky | See "Debugging HTML5" below |

## Performance

| Symptom | Cause given | Remedy given |
| --- | --- | --- |
| The game is slow on Windows 11 or a recent Windows 10 | Often a broken, missing or outdated Visual C++ redistributable | Install the Visual C++ Redistributable for Visual Studio 2012 Update 4 (**Stated**) |
| `fps_real` is high but `fps` is low | `fps_real` measures only the CPU, so the game is probably GPU bound | Turn off graphical effects, shaders and effect layers, reduce particles and the rendering resolution, draw less, and find the hot spots with RenderDoc (**Stated**) |
| `delta_time` jumps while the window is dragged | The animation system pauses when frames drop, but `delta_time` keeps growing | Cap `delta_time`, because a very large value can break timings (**Stated**) |
| A library takes 50 percent of the Step in the profiler | The profiler's percentage is calculated in a misleading way and is almost useless | Read the execution time instead. Under 1 ms is nothing to worry about (**Stated**) |
| `fps_real` fell from 5000 to 4000 after adding an object | Frame rate is inversely proportional to frame time, so a tiny change in a tiny frame time moves it a lot | Compare frame times. 5000 is 0.2 ms and 4000 is 0.25 ms, a difference of 0.05 ms, against a budget of about 16.6 ms at 60 frames per second, so the same change could be repeated about 300 times (**Stated**) |
| A target of 5000 on `fps_real` | It is a poor metric and far above any display's refresh rate | If a very high target is wanted, aim for 240 on the native `fps`, which the author still calls ridiculous (**Stated**) |
| The IDE lags when instances are added to a room | Feather analysing the room | Turn Feather off during heavy room editing. From GameMaker 2023.11 its preferences can skip rooms or room instances with auto-generated names (**Stated**) |
| GameMaker Studio 1 with unexplained slowness | Not stated | Try the `gmsched` tool (**Stated**) |

## Graphics

| Symptom | Cause given | Remedy given |
| --- | --- | --- |
| A shader fails to compile in GameMaker 2023, 2022 or Studio 2 | Often the same Visual C++ redistributable problem | Install the 2012 Update 4 redistributable (**Stated**) |
| A shader fails to compile in GameMaker Studio 1 | Often a broken or missing DirectX 9c runtime | Install the June 2010 DirectX End-User Runtimes (**Stated**) |
| The GPU scissor functions give the wrong area | They work in surface pixel space, not room or view space | Count pixels on the surface itself. On the backbuffer in Draw GUI events that is the pixels of the window, and the scissor ignores the GUI offset, width, height and scale (**Stated**) |
| On consoles, especially Xbox, rectangles and other primitives are offset | A known issue, not fixed at the time | Adjust the position by hand. On Xbox the top left corner of `draw_rectangle()` needs 1 pixel right and 1 down. Many primitive functions are affected on every platform (**Stated**) |
| On Switch the colour channel order looks wrong in vertex buffers | The order matches Windows although the backend is OpenGL, unlike other OpenGL platforms | Expect the Windows order (**Stated**) |
| Fonts look larger than in a mockup | Image editors default to 72 DPI and GameMaker uses 96 | Multiply the editor's point size by 0.75, so 48 pt becomes 36 pt, or set the editor to 96 DPI without resampling (**Stated**) |
| Which GLSL ES version is used | 1.00 revision 17 | Older GameMaker versions support standard derivatives only in part, and no version up to 2023.6 supports vertex texture fetch outside HTML5 (**Stated**) |
| Nothing draws and the log says "Draw failed due to invalid input layout" | The drawn thing lacks an attribute the shader needs, such as texture coordinates on `draw_rectangle()` | Keep one shader variant per vertex format, for example basic, textured and textured with normals (**Stated**) |
| A sprite vanishes after a vertex shader moves it | The runner culls sprites, tilemaps and other graphics outside the view frustum before the shader sees them | `gpu_set_sprite_cull()` turns the culling off, added in 2024.6. Do not confuse it with `gpu_set_cullmode()` (**Stated**) |
| Spine misbehaves | Several runtime problems | See "Spine runtime" below |

## Debugging HTML5

The author's procedure, in short (**Stated**):

1. Get the open-source HTML5 runtime from the YoYoGames `GameMaker-HTML5` repository, at the commit or tag that matches the runtime in use, so the runtime code is not obfuscated and stack traces mean something.
2. Point the HTML5 runner path in the platform settings of the preferences at the `scripts` subfolder of that checkout.
3. Untick Obfuscate and tick Pretty Print and Verbose, so the game code is readable and the console is informative.
4. Run the project and open the browser developer tools with Ctrl+Shift+I, which the author tested in Chrome.
5. Read output and errors on the Console tab. On the Sources tab, enable pausing on caught and uncaught exceptions, and expect some pauses inside the runner that are not fatal.
6. Find the game code under `html5game` as `GameName.js` and the runtime under `scripts`, and click a line number to set a breakpoint. The Scope and Call Stack panels correspond to the Locals, Globals and call stack of the GameMaker debugger, and Watch expressions are written in JavaScript with the HTML5 variable names.
7. Run JavaScript directly in the Console to read variables or call functions.

## Spine runtime

Four problems and the workaround the author uses (**Stated**):

- **The animation update event.** The documentation is wrong. The event does not run once per step before draw. It runs each time `draw_self()` is called and never when a `draw_sprite` function draws the sprite, so it can run zero, one or many times per step. Bone data updates between the Step and End Step events, so the author moves that code to End Step, runs the state machine of every Spine object there and avoids the event altogether.
- **Event frames that never fire.** `skeleton_animation_get_frame` drifts a little on each loop, in either direction, so an exact comparison with an event frame passes the first time and fails later. Compare within a tolerance instead. The author's helper uses 0.5 frames. Resetting the frame to 0 on each loop reduces the drift but not for events late in a long animation, and flooring the value does not work because the drift can be negative.
- **Drawing some slots separately.** No function draws a single slot. The workaround sets the alpha of the slots to hide to 0 with `skeleton_slot_color_set`, calls `draw_self()`, then resets the alphas or swaps which slots are hidden to draw the rest.
- **Different speeds on different tracks.** No function sets the speed of one track. Set `image_speed` to 0 in the Create event and advance each animation by hand with `skeleton_animation_set_frame`.

## Where the source disagrees with itself or is uncertain

- The repository states runtime versions in different forms (GameMaker Studio 1, Studio 2, "GMS2023.11", "2024.6"). The names are the author's and are not checked against the release notes.
- The performance claims, such as the 0.05 ms and 300 repetitions, are arithmetic on the numbers in the question and no measurement of GameMaker backs them.
- The profiler claim that the percentage is "nigh useless" has no explanation of how the percentage is calculated.
- The fix for the Application Control error comes from a forum post and is not the author's own test.
