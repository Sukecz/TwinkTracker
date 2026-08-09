# TwinkTracker

TwinkTracker is a planning companion for **WoW Classic Era / Hardcore
level-19 twinks**. The initial release focuses on Gear, essential XP-safety
rules and automatic Exploration map progress; XP Tracker remains hidden until its
next design pass.

It is deliberately informational. It does not equip items, accept or turn in
quests, stop XP gain, target players, queue battlegrounds, or perform any other
game action.

## Features

- **Gear** — permanent selectors for all nine classes and every applicable
  equipment slot, with an inner `Gear / Enchants / Consumables` switch that is
  remembered per character.
- **Enchants** — class-specific recommendations shown only for relevant gear
  slots, including transferable HEAD/LEGS Arcanums and Naxxramas shoulder
  augments for white, non-binding tradeable shoulders. Slots normally show two
  or three top choices and use a fourth only when a hybrid class needs distinct
  survival, physical, caster and healer options. Every entry includes its exact
  effect, restriction, tooltip and copyable Wowhead Classic link.
- **Consumables** — class-specific tables grouped into bandages, food and
  drink, potions, elixirs, scrolls, Engineering, weapon coatings/ammunition and
  reviewed class resources. Every entry has its native item icon, and each class has at
  least five legal potion and five legal scroll choices. Items requiring level
  20 or higher are explicitly excluded.
- **Tiers** — S, A and B recommendations per class and slot, with up to one
  additional role, faction or budget variant inside each tier.
- **Gear table** — the complete class build is visible as slot rows with compact
  40px icons and S/A/B columns. Equal same-tier choices are stacked vertically
  with identically sized icons and matching item-name styling; rows expand only
  where the extra space is needed. Auxiliary build labels are hidden; mouse over
  either choice for its tooltip, Shift-click it into an open chat message, or
  left-click it to select its Wowhead Classic link for copying.
- **Live equipment status** — matching equipped items receive a green highlight
  and update immediately after an equipment change. Random-suffix alternatives
  are matched by their full item name when one base item ID represents several tiers.
- **Faction badges** — a blue `A` or red `H` on the item icon identifies
  Alliance- and Horde-specific recommendations. The same `A` / `H` convention
  is used in faction headings and route references throughout the addon.
- **Weapon choices** — separate 1H and 2H rows, with S/A/B recommendations for
  every class that can use the corresponding weapon type.
- **Twink Basics** — verified, read-only Classic Era safety rules centered on
  the absence of XP locking and avoiding every XP source after level 19.
- **Guides** — practical, step-by-step First Aid, Fishing and Engineering
  preparation. Each guide includes illustrated related items with normal
  tooltips, Shift-click chat links and copyable Wowhead Classic URLs. First Aid
  includes exact Alliance/Horde trainers, book vendors, coordinates, skill
  breakpoints and the complete route from 1 to 225. Compact interactive item
  icons appear directly inside the instruction line that mentions each item.
  All three professions include level-19-specific shopping lists and sequential
  skill ranges: First Aid reaches 225, while Fishing and Engineering stop at
  150 because their Expert ranks require level 20.
  Warm gold headings and neutral-grey descriptions keep guide structure
  visually separate from the blue Alliance markers.
- **Community** — a scalable guild directory beginning with the Horde guild
  Twink or Treat on the EU PvP Classic Era Firemaw Cluster, including a
  selectable Discord invite address and its supplied guild logo, plus the
  Alliance guild Twink Factory with Sparre as its in-game invite contact.
- **Exploration** — faction-specific routes grouped into Starting & Core Zones,
  World PvP Targets and Travel & Twink Events. Horde and Alliance receive
  different PvP destinations, while Stranglethorn Vale is retained for the
  Gurubashi Arena and Fishing Extravaganza and Swamp of Sorrows remains the
  Horde mountain shortcut into Redridge. Each row shows revealed map areas as
  a color-coded progress bar, `x/x` and a percentage from the Classic Era map
  API. Categories use plain neutral headings without colored accents, so only
  progress carries a completion color. This is visible-map progress, not proof
  that no exploration XP remains.
- **Resizable layout** — drag the lower-right corner to resize the window; its
  size and the selected page are saved per character. Addon-rendered text uses
  a one-pixel readability increase over the matching default Classic font
  objects.
- **Bracket-ready header** — compact `19 / 29 / 39` selectors sit below the
  logo. Level 19 is the active profile; the greyed-out level 29 and 39 profiles
  show `Coming soon` on hover. Bracket selection is stored per character once a
  profile is available.
- **Custom branding** — the supplied TwinkTracker artwork is integrated into the
  window header through a softly feathered, Classic-safe power-of-two TGA
  runtime texture and is included by the shared deployment tool.
- **Minimap button** — a matching gold-and-blue `T` icon opens or closes the
  addon with a left-click and can be dragged around the minimap; its position is
  saved per character.

The reference is intentionally curated rather than presented as a universal
mathematical ranking. Exact random-suffix rolls and realm-specific vendor,
quest, event and drop availability still require live-client confirmation.

All nine class tables have received independent slot-by-slot source audits.
They now keep faction equivalents together, define both ring and trinket slots
deliberately, separate major role variants and exclude items that exceed level
19 or cannot be equipped by the class. The complete guide index and the rules
for future item changes are in [DATA_SOURCES.md](DATA_SOURCES.md). Random
suffix rolls and current realm-specific vendor, quest, event and drop
availability remain live Firemaw Era validation points.

## Usage

- `/twinktracker`, `/tt`, `/twt` or `/twink` — open or close TwinkTracker
- `/tt show` — open it
- `/tt hide` — close it
- `/tt reset` — reset the saved window position and size
- `/tt help` — show command help

Hover an item choice to open its normal WoW tooltip. With a chat input open,
Shift-click a choice to insert its normal item link. Left-click a real item to
select its Wowhead Classic URL in the link row, then press Ctrl+C to copy it.
The same tooltip, Shift-click and Wowhead behavior applies to item-based entries
inside Enchants and Consumables; spell-based enchants use their spell tooltip
and Wowhead spell page.
Reference placeholders without an item ID deliberately have no Wowhead URL. If
another character-specific addon already owns `/tt`, TwinkTracker reports the
collision and `/twt` remains the unambiguous short command.
The chosen class, page, guide, window position and window size are saved per character.

Exploration progress is detected automatically from visible map overlays and
updates from the Classic Era map API. It is not a manual checklist, and even a
displayed 100% cannot prove that every hidden exploration-XP trigger has fired.

## Development

Run all local checks:

```bash
bash tests/run.sh
```

No external Lua library is used. Releases are packaged for CurseForge project
`1644210` by the repository release workflow.

## Windows deployment

Copy these two files to Windows and double-click the `.cmd` file:

- `tools/windows/Deploy-WoW-Addons.cmd`
- `tools/windows/Deploy-WoW-Addons.ps1`

The shared tool uses the existing `ssh minipc` connection, validates Simple
Scrolling Loot, Better Loot Rolls, Simple Arsenal Swap and TwinkTracker in one
remote run, downloads one combined runtime bundle and mirrors all four addon
folders into Classic Era. This avoids repeated SSH/SCP connection setup.
SavedVariables live elsewhere and are not touched. Adjust `WowAddOnsPath` in
PowerShell only if your WoW installation is in another location.

## Verification status

Static checks are included. Live Era testing and realm-specific data validation
remain separate from successful packaging and publication.
