# Changelog

All notable changes are documented here.

## 0.3.1 - 2026-08-09

### Changed

- Replaced the manual Exploration checklist with automatic per-zone map reveal
  progress shown as `x/x` and a rounded percentage.
- Added a Classic Era 1.15.9 visible-overlay denominator and event-driven
  refresh through `MAP_EXPLORATION_UPDATED`, while retaining the warning that
  100% map reveal does not guarantee zero remaining exploration XP.
- Added the existing blue `A` / red `H` faction symbols to Exploration,
  Community and faction-specific guide labels for faster scanning.
- Redesigned Exploration into Starting & Core, faction-specific World PvP, and
  Travel & Twink Event sections with compact color-coded progress bars.
- Audited level-19 world-PvP routes, moved Horde Redridge and Alliance
  Barrens/Stonetalon into their correct target groups, retained the Horde
  Swamp of Sorrows mountain shortcut and added Stranglethorn Vale for its twink
  arena and fishing events. Arathi Highlands remains excluded.
- Replaced colored Exploration category accents with plain neutral headings so
  they cannot be confused with completion colors, and changed the empty
  fallback from `--/x · --%` to `0/x · 0%`.

## 0.3.0 - 2026-08-09

### Changed

- Added a dedicated Guides page with illustrated First Aid, Fishing and
  Engineering walkthroughs, persistent guide selection,
  native item tooltips, chat links and copyable Wowhead Classic URLs.
- Expanded First Aid with exact Alliance/Horde trainers and book vendors,
  coordinates, travel cautions, every 1-225 skill breakpoint and all related
  books, cloth and bandages.
- Improved information hierarchy across Guides, Enchants and Consumables:
  guide steps now separate accent headings from readable body copy, while
  effects, roles, cautions and notes use distinct visual treatments.
- Reworked guide cards into labeled multi-line instructions with explicit skill
  ranges and compact interactive item icons embedded directly in the line that
  mentions each item.
- Improved Wowhead URL selection contrast with light text, an accent border and
  a translucent selection highlight in both Gear and Guides.
- Documented the current level-19 Mageweave Bandage limit instead of repeating
  the historical Heavy Runecloth Bandage recommendation from the 2019 guides.
- Simplified Exploration route rows to show only each zone's recommended level
  range, without route-type labels such as PvP or enemy territory.
- Reviewed Class Resources: retained only relevant Mage, Rogue and Warlock
  entries, and moved ammunition and Rage Potion to their appropriate categories.
- Replaced unavailable Heavy Mageweave/Runecloth bandages with the level-19-legal
  Mageweave Bandage and added Heavy Dynamite to Engineering.
- Added the rare, transferable Feathered Arrow and Exploding Shot as the top
  level-19 bow and gun ammunition options.
- Added all twelve level-19-legal foods that provide the equivalent +6 Stamina
  and +6 Spirit Well Fed bonus, alongside the separate mana-regeneration food.
- Audited every enchant slot for all nine classes, added the four role-specific
  Naxxramas shoulder augments and kept unusable Zul'Gurub Signets excluded.
- Corrected the stat-specific Voracity Arcanum item IDs, added the missing
  +150 Mana Rumination Arcanum and documented their high-level application path.
- Added Accurate Scope for compatible item-level 20+ ranged weapons, retained
  Standard Scope as the fallback and removed silent top-three list truncation.
- Restricted Naxxramas twink guidance to white, non-binding tradeable shoulders;
  green/blue BoE and direct BoP application remain live-client validation gates.

## 0.2.2 - 2026-08-08

### Fixed

- Removed a recursive item-data refresh loop introduced in 0.2.1 that could freeze the Classic client when opening the Consumables view.

## 0.2.1 - 2026-08-08

### Fixed

- Fixed Consumables rows passing an empty item ID to the icon, tooltip and chat-link APIs, which caused every consumable to display the question-mark texture.

## 0.2.0 - 2026-08-08

### Added

- Added a remembered `Gear / Enchants / Consumables` switch inside the Gear
  page without changing the existing S/A/B gear table.
- Added normalized, source-audited enchant profiles for all nine classes,
  rendered only under relevant equipment slots with role and restriction notes.
- Added class-specific consumable tables grouped by bandages, food and drink,
  potions, elixirs, scrolls, Engineering, weapon consumables and class resources.
- Added tooltips, Shift-click chat links and copy-ready Wowhead Classic links to
  the new item-based reference rows.
- Added native item icons to every Consumables row and a compact Twink or Treat
  guild logo to the Horde community card.
- Expanded every class to at least five potion and five scroll choices, with
  broader defensive, mobility, primary-stat, regeneration and resistance sets.
- Added three focused HEAD and LEGS Arcanum/Libram choices for every class and
  capped every enchant slot at its top three role-distinct options.
- Added regression checks for profile/catalog references, exact Wowhead URL
  shapes, level-19 limits and known level-20+ exclusions.
- Added a dedicated Exploration tab with separate Horde and Alliance routes to
  reveal by level 18, including recommended world-PvP and enemy-territory zones.
- Added a persistent per-character manual checklist to every Exploration route.
- Added Swamp of Sorrows to the Horde routes for its shortcut toward Redridge.
- Added the Alliance guild Twink Factory on the Firemaw Cluster with Sparre as
  the in-game invite contact.
- Reworked Twink Basics into verified, read-only XP-safety rules without WSG
  advice, numbered steps or checklist controls.

### Fixed

- Corrected several historical guide traps while building the new reference:
  Free Action Potion and Minor Mana Oil require level 20, Razor Arrow and Solid
  Shot require level 25, and 2H Major Intellect is +9 rather than +22.
- Corrected the Warrior weapon-enchant profile to include Lifestealing, Fiery
  Weapon, Crusader, deterministic weapon damage, Agility and Icy Chill instead
  of presenting only two of those competing setups.
- Fixed Consumables icons on uncached items by preferring the immediate Classic
  item-info API before cache-dependent icon lookups.
- Restored green equipped highlighting independently for both items displayed
  inside a same-tier two-item choice.
- Split the top navigation evenly around the logo so Community no longer
  overlaps the branding.
- Removed misleading automatic Exploration progress values; Classic Era does
  not expose the reliable total needed for a true completion percentage.
- Replaced the unsupported check-mark font glyph with a Classic-safe solid
  green completion square in Exploration.
- Feathered the header logo into transparency on every outer edge so it blends
  into the window instead of showing a hard rectangular crop.

## 0.1.0 - 2026-08-08

### Added

- Pilot UI with Checklist, XP and BiS pages for level-19 Classic Era twinks.
- Per-character checklist state, selected class and XP caution mode.
- Initial class-wide TIER S/A/B gear, enchant and consumable reference data.
- Windows deployment helper that validates before copying runtime files.
- Rebuilt the pilot UI as an English-only modern dashboard with class icons,
  structured item cards, game item icons and tier-colored columns.
- Replaced the single-addon deployment helper with the shared four-addon tool.
- Focused the pilot on Gear and temporarily hid Checklist and XP Tracker.
- Added slot-by-slot S/A/B recommendations for every class and applicable slot.
- Removed the Blizzard quick-slot overlay and cropped item icons cleanly.
- Removed header taglines, build labels and live-character status text.
- Replaced oversized item cards with a compact scrollable slot-by-tier table.
- Reduced item icons to 40px so Classic textures render close to native size.
- Integrated the supplied TwinkTracker logo into the window header and deploy.
- Fixed Classic texture loading by using the extensionless addon asset path.
- Added a 1024x512 TGA runtime texture and a visible text fallback for clients
  that fail to load the original PNG asset.
- Split weapon recommendations into separate 1H and 2H rows with S/A/B tiers
  for every class that supports the corresponding weapon category.
- Added a compact, read-only Twink Basics page with essential planning advice.
- Made the main window resizable with a responsive gear table and persisted size.
- Added live green highlighting for recommendations currently equipped by the
  player, including safe matching of duplicated random-suffix item IDs.
- Added Alliance and Horde badges to faction-specific gear recommendations.
- Extended S/A/B tiers with 31 compact same-tier alternatives curated from the
  bundled Horde, Alliance, P3 and Warrior Extended workbook sheets.
- Added Venomstrike as a Tier S Warrior ranged variant and filled several
  missing role, faction, caster off-hand, wand and class-insignia choices.
- Corrected Pulsating Hydra Heart and Antipodean Rod item identities, and moved
  caster off-hands out of the wand recommendations.
- Replaced the smaller alternative icon with a second full-size 40px icon and
  equal name styling so same-tier choices have no implied priority.
- Stacked same-tier choices vertically in dynamically taller slot rows instead
  of squeezing their icons and names beside each other.
- Removed auxiliary build-description labels from gear rows and added standard
  Shift-click insertion of item links into an open chat message.
- Added `/twt` as a collision-safe short command and report when another loaded
  addon already uses the character-dependent `/tt` alias.
- Added a draggable minimap button with a generated TwinkTracker icon, persisted
  its position per character and kept the implementation dependency-free.
- Added a Community page for guild links, starting with the Horde guild Twink or
  Treat on the EU PvP Classic Era Firemaw Cluster and its Discord invite.
- Added mandatory Wowhead Classic URLs to all item-ID gear data and a copy-ready
  link row shown by left-clicking an item.
- Kept Horde and Alliance class PvP insignias together in the same tier for all
  classes instead of ranking faction-equivalent trinkets differently.
- Completed the first class-wide gear audit for Warrior: aligned faction
  equivalents, corrected WSG rings and ranged weapons, promoted the faction
  quest bracers, added role-specific waist and leg choices, and expanded the
  validated shield and two-hand alternatives.
- Completed independent full-slot audits for all nine classes using class guides
  plus individual Wowhead Classic item records, with a maintained source index.
- Removed class-incompatible armor and weapons, including Mage/Priest leather
  belts, Druid daggers, invalid faction-only Paladin/Shaman rewards and
  level-19 Shaman two-hand axes or maces.
- Removed Hunter bows requiring levels 20 and 37 and rejected five additional
  proposed alternatives after their individual Classic pages showed required
  levels above 19.
- Replaced automatic Ring 2 and Trinket 2 tier rotation with explicit loadout
  recommendations and added regression checks for the critical audit findings.
