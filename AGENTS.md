# AGENTS.md

## Project identity

- Display name and addon folder: `TwinkTracker`
- Namespace: `TwinkTracker`
- Per-character SavedVariables: `TwinkTrackerDB`
- Primary slash command: `/twinktracker` (aliases: `/tt`, `/twink`)
- Target: WoW Classic Era / Hardcore, level-19 bracket
- Language: Lua 5.1 compatible with WoW Classic
- Dependencies: none

## Product boundaries

TwinkTracker is an informational, per-character planning addon. It tracks the
current XP bar, automatic visible-map exploration progress, and a curated
level-19 gear reference. It must never automate movement, targeting, combat
actions, quest turn-ins, equipment changes, queues, or any other game action.

`XP Lockdown` is an addon-only caution mode. It cannot and must not claim to
disable XP gain in the game. Its only effects are warnings and filtering of the
addon UI.

The bundled BiS data is an explicitly versioned pilot reference. Keep multiple
TIER S/A/B alternatives per slot/role and mark data that still needs live Era
validation. Do not present a recommendation as a verified current fact merely
because it appears in an old guide.

Every real gear item must have a positive item ID and its exact Wowhead Classic
URL (`https://www.wowhead.com/classic/item=<ID>`). Create or change item data
only through the shared `item()` helper in `Data/Bis.lua`, and keep the
Wowhead-link test passing. Reference placeholders without an item ID are the
only allowed entries without a Wowhead URL.

Follow `DATA_SOURCES.md` for gear audits. In particular, verify required level,
level-19 class proficiency, faction versus acquisition route and random suffix
claims. Keep true faction equivalents in one tier and define the second ring and
trinket slots explicitly instead of rotating tiers.

## Development workflow

- Inspect `git status` before editing.
- Keep user-visible behaviour in `README.md` and `CHANGELOG.md`.
- Run `bash tests/run.sh` before committing.
- Do not push, tag, publish, create a CurseForge project, or add a CurseForge
  project ID unless explicitly requested.
- Generated packages must have exactly one top-level `TwinkTracker` directory.
- The shared Windows deployment tool validates and deploys all four local WoW
  addons together; it must preserve SavedVariables.

## Style

- Four-space indentation and Lua 5.1 syntax.
- Keep static data, persistent database code, XP calculations, UI, and slash
  commands separate.
- Use the addon namespace for all implementation state. The SavedVariables
  table and slash-command globals are the only intended globals.
- No external libraries and no polling; refresh XP from relevant game events.
