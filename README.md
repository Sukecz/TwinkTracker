# TwinkTracker

TwinkTracker is an in-game planning companion for level **19, 29 and 39**
twinks in **WoW Classic Era, Classic Hardcore and Burning Crusade Classic**.
It brings curated gear, enchants, consumables, profession preparation and
XP-safety guidance into one compact window, without trying to play the game for
you.

The addon selects the correct data automatically. Classic Era and Hardcore load
the Era profile; Burning Crusade Classic loads the TBC profile. There is no
expansion switch to manage, and a discreet footer always shows the active client
and addon version.

## Plan a complete twink

- **Three finished brackets** — switch freely between independent level-19,
  level-29 and level-39 profiles. The selected bracket is remembered per
  character.
- **All nine classes** — browse every applicable armor, weapon, ring and
  trinket slot, including Blood Elf Paladin and Draenei Shaman routes in TBC.
- **Useful tiers, not a single rigid BiS list** — Tier S, A and B choices retain
  meaningful role, faction, survivability, random-suffix and budget
  alternatives. Equal-tier items are not secretly ranked.
- **Gear you can act on** — normal game tooltips, Shift-click item handling,
  copyable expansion-correct Wowhead links, live green highlighting for
  equipped recommendations and a compact binding/source line on every real
  item (`BOE · DUNGEON`, `BOP · QUEST`, `NO BIND · VENDOR`, and similar).
  Random-stat recommendations use an exact rollable suffix itemString, so the
  tooltip shows the selected stats and Shift-click searches the precise named
  variant instead of the generic base item.
  White Era shoulders whose listed value depends on a Naxxramas enchant also
  retain a visible `+ NAXX` enchant warning on that line.
- **Enchants and consumables** — class- and bracket-specific choices with their
  effects, charges, cooldowns, profession requirements, target item-level
  restrictions and other important application cautions.
- **Preparation guides** — self-contained First Aid, Fishing and Engineering
  routes from skill 1 to each bracket's maximum, plus Jewelcrafting in TBC,
  with concrete skill ranges, craft counts, trainers and interactive items.
- **Class Tiers** — a quick community-oriented overview with role, Offense,
  Survival and Utility scores for the selected bracket, with dense tiers
  wrapped into readable rows inside the window.
- **Twink Basics** — short reminders for planning quests, dungeons,
  exploration and other XP-bearing routes before the character reaches its
  final level.
- **Exploration** — automatic visible-map progress and faction-specific travel
  targets. It is a planning aid, not proof that every hidden exploration-XP
  trigger has fired.
- **Comfortable interface** — movable and resizable window, draggable minimap
  button, per-character settings and remembered page, class and size.

Classic Era and Hardcore also retain the **PvP Events** page for confirmed
community battleground sessions and the Era WSG bonus-weekend estimate. This
page is intentionally absent in Burning Crusade Classic because the bundled
Era schedule and Firemaw community announcements must not be presented as TBC
events. The separate recurring **Event Timers** overview loads an independent
TBC profile: the WSG/AB/AV/Eye of the Storm bonus rotation, the three-location
Darkmoon Faire, weekly fishing, Gurubashi and the complete set of TBC-era
seasonal holidays. It remains a planning aid and emergency Blizzard calendar
changes should always be checked against the live client.

## Automatic client support

TwinkTracker ships with two game-selected manifests over one shared codebase:

- `TwinkTracker.toc` — Classic Era and Classic Hardcore
- `TwinkTracker_TBC.toc` — Burning Crusade Classic

Only the matching manifest loads. TBC automatically swaps in its own audited
gear deltas, faction routes, class-tier estimates, enchant cautions,
Jewelcrafting content and Wowhead TBC links. Saved settings remain
per-character; no manual client toggle is required.

## Important limits

TwinkTracker is strictly informational. It never equips items, moves or targets
your character, accepts or turns in quests, queues battlegrounds, stops XP gain
or performs combat actions.

The recommendations are source-audited planning references, not claims of a
universal mathematically proven BiS set. Exact random-suffix rolls, current
realm availability, quest state, PvP vendors and unusual enchant application
rules can still require confirmation in the live client. In particular,
Classic Era and TBC do not offer an XP lock for these routes, so plan
XP-producing objectives before completing them.

See [DATA_SOURCES.md](DATA_SOURCES.md) for the Era audit rules and
[TBC_DATA_SOURCES.md](TBC_DATA_SOURCES.md) for the TBC audit and source index.

## Commands

- `/twinktracker`, `/twt` or `/twink` — open or close TwinkTracker
- `/tt` — short command when another addon does not already own it
- `/tt show` — open the window
- `/tt hide` — close the window
- `/tt reset` — reset the saved window position and size
- `/tt help` — show command help

If another addon owns `/tt`, TwinkTracker reports the collision and `/twt`
remains available.

## Development and verification

Run all local checks with:

```bash
bash tests/run.sh
```

The addon uses Lua 5.1 and has no external addon dependencies. Static Era and
TBC checks do not replace live-client validation of UI geometry, event timing,
realm availability or protected game behavior.

Releases are packaged for CurseForge project `1644210` by the repository
release workflow. The shared Windows helper deploys all four local addons to
both the Classic Era and Burning Crusade Classic clients while preserving
SavedVariables.
