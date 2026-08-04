# TwinkTracker

TwinkTracker is a local planning companion for **WoW Classic Era / Hardcore
level-19 twinks**. This is a pilot build: it gives one compact window for a
preparation checklist, live XP awareness and an initial class-by-class BiS,
enchant and consumable reference.

It is deliberately informational. It does not equip items, accept or turn in
quests, stop XP gain, target players, queue battlegrounds, or perform any other
game action.

## Pilot features

- **Checklist** — persistent per-character preparation steps; XP-dangerous work
  is explicitly called out.
- **XP** — reads the live value from `UnitXP()` and `UnitXPMax()`, calculates
  remaining XP and uses configurable product thresholds (60/80/92%).
- **XP Lockdown** — a local caution mode for level 19. It is not an in-game XP
  lock and cannot prevent XP gain.
- **Gear & Loadout** — a permanent nine-class icon selector, visual item cards
  with live WoW icons/tooltips, TIER S/A/B alternatives, enchants and
  consumables for every Classic Era class.

The reference is intentionally a starting dataset derived from the supplied
research. Exact availability, required levels, faction routes and current Era
validity still require live-client confirmation before a public release.

## Usage

- `/twinktracker`, `/tt` or `/twink` — open or close TwinkTracker
- `/tt show` — open it
- `/tt hide` — close it
- `/tt reset` — reset only the saved window position
- `/tt help` — show command help

Click an item name with an available item ID to open its normal WoW tooltip.
Checklist progress, the chosen class and XP Lockdown are saved per character.

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
