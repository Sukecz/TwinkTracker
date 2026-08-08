# TwinkTracker

TwinkTracker is a planning companion for **WoW Classic Era / Hardcore
level-19 twinks**. The initial release focuses on Gear and a compact Twink Basics
reference; Checklist and XP Tracker are hidden until their next design pass.

It is deliberately informational. It does not equip items, accept or turn in
quests, stop XP gain, target players, queue battlegrounds, or perform any other
game action.

## Features

- **Gear** — permanent selectors for all nine classes and every applicable
  equipment slot.
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
  Alliance- and Horde-specific recommendations.
- **Weapon choices** — separate 1H and 2H rows, with S/A/B recommendations for
  every class that can use the corresponding weapon type.
- **Twink Basics** — a short, read-only guide to XP planning, gear order,
  professions and the final level-19 audit, without checklist controls.
- **Community** — a scalable guild directory beginning with the Horde guild
  Twink or Treat on the EU PvP Classic Era Firemaw Cluster, including a
  selectable Discord invite address.
- **Resizable layout** — drag the lower-right corner to resize the window; its
  size and the selected page are saved per character.
- **Custom branding** — the supplied TwinkTracker artwork is integrated into the
  window header through a Classic-safe power-of-two TGA runtime texture and is
  included by the shared deployment tool.
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
Reference placeholders without an item ID deliberately have no Wowhead URL. If
another character-specific addon already owns `/tt`, TwinkTracker reports the
collision and `/twt` remains the unambiguous short command.
The chosen class, page, window position and window size are saved per character.

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
Scrolling Loot, Better Loot Rolls, Simple Arsenal Swap and TwinkTracker, stages
their runtime files and mirrors all four addon folders into Classic Era.
SavedVariables live elsewhere and are not touched. Adjust `WowAddOnsPath` in
PowerShell only if your WoW installation is in another location.

## Verification status

Static checks are included. Live Era testing and realm-specific data validation
remain separate from successful packaging and publication.
