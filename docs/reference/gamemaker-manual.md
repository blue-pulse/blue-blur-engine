# GameMaker manual repository

## About this document

This document explains how to read the GameMaker manual repository, which holds the source of the official manual. It is for anyone, or any tool, that needs to find a page in it without wasting time on the files that are not content. It contains what the repository is, its branches, which folders matter and which do not, how to find a page, how a page is built and how to cite one. It leaves out how to edit or build the manual. Update it when the repository changes its layout.

Facts here were checked by reading a clone of the `develop` branch and, for the branch list, the repository page on GitHub.

## What it is

The repository is [YoYoGames/GameMaker-Manual](https://github.com/YoYoGames/GameMaker-Manual). It is the source from which the final manual is built with Adobe RoboHelp. The README says it is not meant for end users, who should read the published manual at `manual.gamemaker.io` or the offline manual that the IDE downloads. It is still the quickest way to search the whole manual as plain files.

## Branches

The default branch is `develop`. Other branches exist for features and for versions, such as `2026.0.0-main`. The README does not say how they relate.

A page can differ between branches. The Igor page on `2026.0.0-main` is older than the one on `develop` and lacks several options. When the exact version matters, say which branch a page comes from. The pages named in this document are on `develop`, which can describe features newer than a given runtime.

## What to read and what to ignore

The repository holds about 6,000 files and almost all of them are not content.

| Path | What it is | Read it |
| --- | --- | --- |
| `Manual/contents/` | The pages, about 3,100 files ending in `.htm` | **Yes** |
| `Manual/contents/assets/snippets/` | Small `.hts` files of text that pages insert | When a page shows an empty marker |
| `Manual/contents/assets/` (the rest) | Styles, scripts, images, videos and fonts | No |
| `Manual/toc/Default.toc` | The table of contents as XML | To see where a page sits |
| `Manual/variable/Default.var` | The values behind the `data-keyref` markers | When a page shows a marker with no text |
| `Manual/index`, `condition`, `glossary`, `seealso`, `settings`, `publish`, `_page_generation` | RoboHelp build settings and templates | No |
| `Manual/GMS2_Manual.rhpj`, `*.bat`, `GenerateKeyboardShortcutTableFromJson.py` | RoboHelp project and build scripts | No |
| `ZeusDocs_keywords.json`, `ZeusDocs_tags.json`, `glossary.json`, `glossary_no_index.json` in the root | Search metadata. The two ZeusDocs files list paths that do not match the current layout, and the glossary values are empty | No |
| `.github/` | Issue forms and build workflows | No |

## Finding a page

A page is one `.htm` file and its name is its title. Choose the first way that fits.

1. **By name.** Search the file names for the page name. The function `game_end` is `GameMaker_Language/GML_Reference/General_Game_Control/game_end.htm`, and the page on Igor is `Settings/Building_via_Command_Line.htm`.
2. **By topic.** Open `Manual/toc/Default.toc`. Each `book` and `page` element has an `href` to a page, and the nesting is the structure of the manual.
3. **By keyword.** Search the text of the `search-keywords` and `rh-index-keywords` tags in the `head` of the pages.

The top-level folders in `Manual/contents/` group the pages. The GML functions are in `GameMaker_Language/GML_Reference/`, split by category such as `Drawing`, `Maths_And_Numbers` and `Movement_And_Collisions`. Build, runner and project settings are in `Settings/`, the asset editors in `The_Asset_Editors/`, the IDE tools in `IDE_Tools/` and the licence and version pages in `Setting_Up_And_Version_Information/`.

## How a page is built

A function page has a title, a short description, a syntax line, a table of arguments, the return value and an example. A page ends with links to the previous and next pages.

Two kinds of marker hide text in the file.

- `<span data-keyref="Type_Real">` stands for a variable. The text between the tags is a fallback, and the real value is in `Manual/variable/Default.var` under the same name.
- `<span data-conref="...Tag_optional.hts">` stands for a snippet. The text is in the named `.hts` file under `Manual/contents/assets/snippets/`.

Links between pages are relative paths. Read the page as plain text by dropping the tags, the scripts and the styles, and keep the tables.

## Citing a page

Cite a page by its path from `Manual/contents/` and the branch, so a reader can open it without a guide. For example: `Settings/Building_via_Command_Line.htm` on `develop`. Its address is `https://github.com/YoYoGames/GameMaker-Manual/blob/develop/Manual/contents/Settings/Building_via_Command_Line.htm`.
