# TwinkTracker

TwinkTracker is a local planning companion for **WoW Classic Era / Hardcore
level-19 twinks**. The current pilot focuses on Gear and a compact Twink Basics
reference; Checklist and XP Tracker are hidden until their next design pass.

It is deliberately informational. It does not equip items, accept or turn in
quests, stop XP gain, target players, queue battlegrounds, or perform any other
game action.

## Pilot features

- **Gear** — permanent selectors for all nine classes and every applicable
  equipment slot.
- **Tiers** — S, A and B recommendations per class and slot, with up to one
  additional role, faction or budget variant inside each tier.
- **Gear table** — the complete class build is visible as slot rows with compact
  40px icons and S/A/B columns. Equal same-tier choices use two identically sized
  icons and matching item-name styling; mouse over either icon for its tooltip.
- **Live equipment status** — matching equipped items receive a green highlight
  and update immediately after an equipment change. Random-suffix alternatives
  are matched by their full item name when one base item ID represents several tiers.
- **Faction badges** — a blue `A` or red `H` on the item icon identifies
  Alliance- and Horde-specific recommendations.
- **Weapon choices** — separate 1H and 2H rows, with S/A/B recommendations for
  every class that can use the corresponding weapon type.
- **Twink Basics** — a short, read-only guide to XP planning, gear order,
  professions and the final level-19 audit, without checklist controls.
- **Resizable layout** — drag the lower-right corner to resize the window; its
  size and the selected page are saved per character.
- **Custom branding** — the supplied TwinkTracker artwork is integrated into the
  window header through a Classic-safe power-of-two TGA runtime texture and is
  included by the shared deployment tool.

The reference is intentionally a starting dataset derived primarily from the
bundled Horde, Alliance, P3 and Warrior Extended workbook sheets. Exact
availability, required levels, faction routes and current Era validity still
require live-client confirmation before a public release.

## Usage

- `/twinktracker`, `/tt` or `/twink` — open or close TwinkTracker
- `/tt show` — open it
- `/tt hide` — close it
- `/tt reset` — reset the saved window position and size
- `/tt help` — show command help

Click an item name with an available item ID to open its normal WoW tooltip.
The chosen class, page, window position and window size are saved per character.

## Development

Run all local checks:

```bash
bash tests/run.sh
```

No external Lua library or CurseForge project is used. The project is local
only; no publishing is performed by the code or deployment script.

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

Static checks are included. Live Era testing, final data curation and any
GitHub/CurseForge release remain separate future steps; neither has been done
by this pilot scaffold.
