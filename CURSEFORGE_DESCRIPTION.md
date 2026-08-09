# TwinkTracker

TwinkTracker is a lightweight planning addon for level 19 characters in World
of Warcraft Classic Era and Classic Hardcore. It combines curated gear,
enchant and consumable references with essential XP-safety guidance and a
manual exploration checklist in one compact in-game window.

All settings and checklist progress are stored separately for each character.

## Features

- Curated Tier S, A and B gear recommendations for all nine Classic Era classes
- Alliance, Horde, role-specific and budget item alternatives
- Separate Gear, Enchants and Consumables views for every class
- Focused enchant recommendations for relevant equipment slots
- Role-aware HEAD and LEGS Arcanum/Libram choices for every class
- Naxxramas shoulder augments with their white, non-binding item warning
- Consumables grouped into bandages, food and drink, potions, elixirs, scrolls,
  Engineering items, weapon supplies and class resources
- At least five level-19-legal potion and scroll options for every class
- Native item icons and normal in-game item or spell tooltips
- Live green highlighting for matching equipped gear
- Shift-click insertion of item links into an open chat message
- Copy-ready Wowhead Classic links for every real item and enchant
- Essential Classic Era XP-safety rules, including the absence of XP locking
- Separate Horde and Alliance exploration routes to complete by level 18
- Persistent manual exploration checklist saved per character
- Contested and enemy-territory routes useful for travel and world PvP
- Resizable and movable window with remembered size, position and selected view
- Draggable minimap button with a custom TwinkTracker icon
- No external libraries or required dependencies

## Gear, enchants and consumables

The bundled reference is curated for level 19 rather than presented as one
universal mathematical BiS list. Recommendations can differ by faction, role,
survivability, damage type, healing needs, weapon setup, availability or random
suffix.

Enchant slots are deliberately limited to the strongest role-distinct choices.
Classic HEAD and LEGS Arcanums are included with clear high-level Libram
turn-in and live-application warnings. Naxxramas shoulder augments document the
level-60, white non-binding shoulder transfer route; Zul'Gurub Signets remain
excluded because they bind the target to their high-level owner. Consumables
requiring level 20 or higher are excluded.

Realm-specific availability, exact random-suffix rolls, buff stacking, proc
rates and selected vendor, quest, event or drop details may still require
confirmation in the live Classic Era client.

## Exploration and XP safety

Classic Era does not provide an XP-locking service. TwinkTracker therefore
emphasizes finishing important travel and exploration before level 19 and
avoiding mob, quest, dungeon and exploration XP after reaching the target
level.

The Exploration page uses a manual checklist because the Classic Era map API
does not expose a reliable denominator for a true zone-completion percentage.
TwinkTracker never claims that this checklist disables or prevents XP gain.

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

## Compatibility and safety

- World of Warcraft Classic Era
- Classic Hardcore
- Lua 5.1
- No required dependencies

TwinkTracker is strictly informational. It never automates movement, combat,
targeting, equipment changes, quest actions, experience gain or battleground
queues.
