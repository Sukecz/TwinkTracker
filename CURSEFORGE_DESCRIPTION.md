# TwinkTracker

TwinkTracker is a lightweight planning addon for level 19 twinks in World of
Warcraft Classic Era. It brings XP information, preparation references and
curated class gear recommendations into one compact in-game window. Progress
and settings are stored separately for each character.

## Features

- Curated Tier S, A and B gear recommendations for all nine Classic Era classes
- Alliance, Horde and role-specific item alternatives
- Live highlighting of matching equipped items
- Normal item tooltips and Shift-click insertion into an open chat message
- Copy-ready Wowhead Classic links for every real item
- Compact Twink Basics reference
- Draggable, resizable window and movable minimap button
- Per-character progress, window position and settings
- Community page for the Horde guild Twink or Treat on the EU PvP Classic Era
  Firemaw Cluster
- No external libraries or dependencies

## Gear reference

The catalog is a practical level 19 reference rather than a single universal
BiS list. Tier placement may depend on faction, role, survivability, damage,
healing, availability or a specific random suffix. Current realm availability,
random-suffix rolls and selected vendor, event or quest details may still need
verification in the live Classic Era client.

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

## Compatibility and safety

- World of Warcraft Classic Era
- Classic Hardcore
- Lua 5.1
- No required dependencies

TwinkTracker is strictly informational. It never automates movement, combat,
targeting, equipment changes, quest turn-ins or battleground queues.
