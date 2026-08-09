# TwinkTracker

TwinkTracker is a compact planning companion for **World of Warcraft Classic
Era and Classic Hardcore twinks**. The current profile is built for the
**level-19 bracket**, bringing gear, enchants, consumables, preparation guides,
XP-safety reminders and automatic exploration progress into one movable and
resizable in-game window.

The header is already prepared for multiple brackets:

- **19** — available now with the complete current reference
- **29** — Coming soon
- **39** — Coming soon

The 29 and 39 emblems are intentionally greyed out and cannot be selected yet.
They are a preview of planned future bracket guides, not unfinished content
presented as usable.

## Current features

### Gear

- Curated Tier S, A and B choices for all nine Classic Era classes
- Every applicable armor, weapon, ring and trinket slot
- Equal-tier faction, role, survivability and budget alternatives
- Blue `A` and red `H` badges for faction-specific recommendations
- Live green highlighting when a recommended item is equipped
- Normal item tooltips and Shift-click insertion into chat
- Copy-ready Wowhead Classic links for every real item

TwinkTracker presents a curated planning reference rather than claiming one
universal mathematical BiS list. Recommendations may differ by faction, role,
weapon setup, random suffix or availability.

### Enchants and consumables

- Class-specific enchant recommendations for relevant equipment slots
- HEAD and LEGS Arcanum/Libram choices with their real acquisition cautions
- Naxxramas shoulder augments with the white, non-binding shoulder requirement
- Consumables grouped into bandages, food and drink, potions, elixirs, scrolls,
  Engineering, weapon supplies and class resources
- Native item icons plus normal item or spell tooltips
- Level-20-and-higher consumables excluded from the level-19 profile

### Twink Basics and guides

- Clear Classic Era XP-safety reminders, including the absence of XP locking
- Step-by-step First Aid preparation from skill 1 to 225
- Fishing and Engineering preparation routes
- Faction-specific trainers, vendors, coordinates and travel cautions
- Interactive related-item icons, tooltips, chat links and Wowhead links

### Automatic Exploration progress

Exploration is divided into faction-specific route groups:

- Starting & Core Zones
- World PvP Targets
- Travel & Twink Events

Each zone displays automatically detected visible-map progress as a colored
bar, `x/x` explored areas and a percentage. Horde and Alliance receive
different world-PvP destinations. Stranglethorn Vale is retained for Gurubashi
Arena and Fishing Extravaganza activity, while Swamp of Sorrows remains part of
the Horde mountain route into Redridge.

Progress is based on the Classic Era map API and a matching visible-overlay
table. It updates from map-exploration events and is saved by the game for the
character; there is no manual checklist. A displayed 100% means that all known
visible map overlays were revealed. It does **not** guarantee that every hidden
exploration-XP trigger has fired or that no exploration XP remains.

### Community and interface

- Community page for faction-specific Classic Era twink guild information
- Compact bracket emblems below the TwinkTracker logo
- Movable and resizable window with remembered position, size and selected page
- Draggable minimap button with remembered position
- Per-character settings
- No external addon libraries or required dependencies

## Commands

- `/twinktracker` — open or close TwinkTracker
- `/twt` — collision-safe short command
- `/tt` — short command when another addon does not already use it
- `/twink` — alternative command
- `/tt show` — open the window
- `/tt hide` — close the window
- `/tt reset` — reset the saved window position and size
- `/tt help` — display command help

If another addon already owns `/tt`, TwinkTracker reports the conflict and
`/twt` remains available.

## Compatibility and safety

- World of Warcraft Classic Era
- World of Warcraft Classic Hardcore
- Lua 5.1
- No required dependencies

TwinkTracker is strictly informational. It never automates movement, combat,
targeting, equipment changes, quest actions, experience gain or battleground
queues. Realm-specific availability, exact random-suffix rolls and selected
vendor, quest, event or drop details may still require confirmation in the live
Classic Era client.
