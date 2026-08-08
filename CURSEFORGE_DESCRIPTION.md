# TwinkTracker

TwinkTracker is a lightweight planning addon for level 19 twinks in World of
Warcraft Classic Era. It brings XP information, preparation references and
curated class gear recommendations into one compact in-game window. Progress
and settings are stored separately for each character.

## Features

- Curated Tier S, A and B gear recommendations for all nine Classic Era classes
- A remembered Gear / Enchants / Consumables switch for every class
- Slot-aware enchant recommendations with exact effects and restrictions
- Three focused HEAD and LEGS Arcanum/Libram choices per class
- Consumables grouped by bandages, food, potions, elixirs, scrolls,
  Engineering, weapon supplies and class resources, all with native item icons
- At least five legal potion and five legal scroll options for every class
- Alliance, Horde and role-specific item alternatives
- Live highlighting of matching equipped items
- Normal item tooltips and Shift-click insertion into an open chat message
- Copy-ready Wowhead Classic links for every real item
- Essential Classic Era XP-safety rules, including the absence of XP locking
- Separate Horde and Alliance exploration routes to reveal by level 18,
  including world-PvP destinations and persistent manual completion
- Draggable, resizable window and movable minimap button
- Per-character progress, window position and settings
- Community page for the Horde guild Twink or Treat and Alliance guild Twink
  Factory on the EU PvP Classic Era Firemaw Cluster
- No external libraries or dependencies

## Gear, enchant and consumable reference

The catalog is a practical level 19 reference rather than a single universal
BiS list. Tier placement may depend on faction, role, survivability, damage,
healing, availability or a specific random suffix. Current realm availability,
random-suffix rolls and selected vendor, event or quest details may still need
verification in the live Classic Era client.

Classic HEAD/LEGS Arcanums are included with explicit high-level Libram turn-in
and Firemaw application warnings. Unverified raid shoulder augments remain
excluded. Consumables requiring level 20 or higher are excluded, and uncertain
stacking, proc or realm-availability details are labeled for live verification.

## Commands

- `/twinktracker` - open or close TwinkTracker
- `/twt` - collision-safe short command
- `/tt` - short command when another addon does not already use it
- `/twink` - alternative command
- `/tt show` - open the window
- `/tt hide` - close the window
- `/tt reset` - reset the window position and size
- `/tt help` - display command help

If another addon already owns `/tt`, TwinkTracker reports the conflict and
`/twt` remains available.

## Community

Twink or Treat is a Horde guild on the EU PvP Classic Era Firemaw Cluster.

Discord: https://discord.gg/BdABEghf3M

Twink Factory is an Alliance guild on the same cluster. Whisper Sparre in game
for an invite.

## Compatibility and safety

- World of Warcraft Classic Era
- Classic Hardcore
- Lua 5.1
- No required dependencies

TwinkTracker is strictly informational. It never automates movement, combat,
targeting, equipment changes, quest turn-ins or battleground queues.
