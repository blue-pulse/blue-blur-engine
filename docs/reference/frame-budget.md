# Frame budget

## About this document

This document states how much time a game has to produce a frame and how established engines share that time, with the figures their makers publish. It is for anyone who has to say whether a measured cost is large or small for a game. It covers the frame budget at common frame rates, the part of it that is safe to use, and the published budgets and measured costs of animation in two commercial engines. It leaves out how to measure a cost and how any one game spends its budget. Update it when an engine changes the defaults it cites, and re-read every source before citing a figure again.

Each figure says where it comes from. **Docs** means the official documentation or blog of the engine's maker, read on 2026-11-12. **Forum** means a measurement posted by one user, with no independent check. **Summary** means it was read through the summary of a search tool and not on the page itself.

## The budget of a frame

- A frame lasts 1/rate of a second: 16.66 ms at 60 frames per second and 33.33 ms at 30 (**Docs**, [Unity, "Optimize your mobile game performance"](https://unity.com/blog/games/optimize-your-mobile-game-performance-tips-on-profiling-memory-and-code-architecture-from), 2021).
- Unity recommends using only about 65 percent of it on mobile, so a device does not overheat, which gives about 11 ms at 60 frames per second and 22 ms at 30 (**Docs**, same page).
- Valve gives 16.6 ms at 60 frames per second as the recommended target and 33.3 ms at 30 as the lowest acceptable, and says the graphics usually take most of the budget (**Summary**, [Valve Developer Community, "Budget"](https://developer.valvesoftware.com/wiki/Budget)).
- No source found states a standard share of the frame for animation. Each studio sets its own.

## What engines give to animation

- Unreal Engine's Animation Budget Allocator reserves a fixed time on the game thread for the work of all animated skeletal meshes together, and cuts that work when it would exceed it. The console variable `a.Budget.BudgetMs` sets it, and its default is 1.0 ms. The budget is meant to be set per platform, and the page's example raises it from 1.0 to 2.5 ms with the quality level (**Docs**, [Animation Budget Allocator](https://dev.epicgames.com/documentation/en-us/unreal-engine/animation-budget-allocator-in-unreal-engine), Unreal Engine 5.9).
- In one Unreal Engine 5.7 project, a character driven by a state machine cost about 0.07 ms on the game thread and 0.43 ms of worker thread time, and one driven by motion matching about 0.14 ms and 0.50 ms. The figures are averages over 19 characters taken with Unreal Insights in one frame, on a machine the author does not name, with the game bound by the GPU (**Forum**, ["State Machine vs. Motion Matching - Demo Performance Analysis Share"](https://forums.unrealengine.com/t/state-machine-vs-motion-matching-demo-performance-analysis-share/2721152)).

These figures are for three-dimensional skeletons, whose cost grows with the number of bones, and not for sprites. They set the scale that an engine considers normal for animation, not a target for a sprite.
