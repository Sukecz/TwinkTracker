# Changelog

All notable changes are documented here.

## 0.4.5 - 2026-08-20

### Changed

- Marked white Classic Era shoulder recommendations with a visible `+ NAXX`
  enchant label so they are not mistaken for strong unenchanted items.
- Added an expansion-aware binding and acquisition label to every real item in
  every S/A/B gear tier, covering BoE, BoP, non-binding, quest, dungeon,
  world-drop, crafted, vendor, Honor/Reputation, event and fishing sources.
- Added audited exact random-property itemStrings for every random-stat gear
  recommendation. Tooltips now show the chosen suffix stats and Shift-click
  passes the exact named variant to chat or Auction House search.
- Removed impossible random-suffix combinations and corrected class-invalid
  Mage, Paladin, Priest, Hunter, Shaman, Warlock and Warrior recommendations;
  retained Era-only choices where the class restriction exists only in TBC.

## 0.4.4 - 2026-08-14

### Changed

- Made every bracket profession guide self-contained from skill 1 to the
  highest rank available at that character level, without cross-bracket route
  references.
- Expanded the level-29 and level-39 First Aid, Fishing and Engineering guides
  into explicit skill intervals with concrete crafts, quantities and caps.
- Added complete bracket-specific TBC Jewelcrafting routes for skill 1-150,
  1-225 and 1-300.

## 0.4.3 - 2026-08-14

### Changed

- Reduced the logo inside the minimap icon and removed its extra texture crop
  so the gold `T` remains legible inside Blizzard's circular minimap border.
- Audited the level-29 Rogue profile: documented the mutually exclusive Horde
  quest rewards Skullbreaker and Nail Spitter, and added verified Flame
  Deflector, Minor Recombobulator and Faintly Glowing Skull utility choices.
- Corrected level-29 Rogue consumable details for Thistle Tea, Strong
  Anti-Venom, Flash Bomb, Mind-numbing Poison and charged utility cooldowns.

## 0.4.2 - 2026-08-13

### Changed

- Added explicit shopping lists to every First Aid, Fishing, Engineering and
  TBC Jewelcrafting guide across the level-19, level-29 and level-39 profiles.
- Split the First Aid cloth totals into clear 1-125 and 125-225 segments.
- Corrected the level-19 Engineering 1-150 route to require 80x Bronze Bar,
  15x Wool Cloth and about 15x saved Whirring Bronze Gizmo.
- Standardized every profession-guide item quantity as `Nx Item Name`.

## 0.4.1 - 2026-08-13

### Added

- Added a dedicated TBC Anniversary event profile with the four-week Warsong
  Gulch, Arathi Basin, Alterac Valley and Eye of the Storm bonus rotation.
- Added New Year, Love is in the Air, Noblegarden, Children's Week, Harvest
  Festival and Brewfest to the seasonal tracker alongside the four existing
  holidays.

### Changed

- Extended the shared Windows deployment helper to validate and synchronize
  all four local addons into both Classic Era and Burning Crusade Classic.
- Corrected Darkmoon Faire to open on the first Monday and added the TBC
  Elwynn, Mulgore and Terokkar location rotation.
- Made the Event Timers heading client-aware and kept uncertain future holiday
  dates explicitly described as planning estimates.

## 0.4.0 - 2026-08-13

### Added

- Added automatic Burning Crusade Classic support through a separate TBC TOC,
  without an in-addon flavor switch.
- Added TBC-specific S/A/B audits for all nine classes at levels 19, 29 and 39,
  including Blood Elf Paladin and Draenei Shaman faction routes, TBC itemization
  changes and TBC Wowhead links.
- Added TBC enchant eligibility cautions and high-end leg, chest, bracer, boot
  and weapon options, plus Jewelcrafting statues and a Jewelcrafting guide.
- Added independent TBC class-tier estimates for all three brackets and a
  source/audit document.
- Added a non-interactive footer showing the detected client and addon version,
  for example `CLASSIC ERA 0.4.0` or `BURNING CRUSADE CLASSIC 0.4.0`.
- Completed the level-39 bracket with independent S/A/B gear profiles for all
  nine Classic classes, explicit role and faction alternatives, second ring and
  trinket slots, and Classic Era Wowhead links for every real item.
- Added level-39 consumables, Artisan profession guides to skill 300,
  Engineering specialization tools, exploration routes, class tiers, Twink
  Basics and an empty bracket-aware PvP event profile.

### Changed

- Wrapped Class Tier cards after three columns and hid empty tier rows so the
  level-39 overview stays inside the addon window at every supported size.
- Re-audited all Classic Era level-39 gear against current class proficiencies,
  item tooltips and multiple twink guides; removed invalid weapons, armor and
  class-restricted rewards, corrected item effects and expanded role-specific
  alternatives.
- Corrected the level-39 consumable catalog and recommendations, including
  Warlock-only Greater Healthstones, mana and food choices, poison effects,
  Mana Jade, Exploding Shot and Major Recombobulator; clarified Classic Era
  elixir stacking terminology.
- Reworked the README and CurseForge description around automatic Era/Hardcore
  and TBC support, the completed 19/29/39 profiles, current features and honest
  live-validation limits; clarified that PvP Events remains Era-only.
- Enabled level 39 in the persistent bracket selector.
- Reused the audited endgame permanent-enchant profiles because level 39 does
  not unlock a higher permanent enchant tier; target-item-level scope fallbacks
  and role-specific weapon or shield choices remain explicit.

## 0.3.11 - 2026-08-11

### Changed

- Made the level-19 bracket explicit on every confirmed PvP event row and added
  a clear instruction to queue for WSG during the listed server-time window.
- Added an automatic WSG bonus-weekend panel that follows the Classic Era
  three-week rotation and counts down to its start or end in server time.
- Added a separate Event Timers page that repeats the WSG bonus countdown and
  adds an automatic weekly Stranglethorn Fishing Extravaganza countdown.
- Expanded Event Timers with expected three-hour Gurubashi chest spawns,
  monthly Darkmoon Faire location and the next tracked seasonal holiday.
- Positioned the Events navigation on the right side of the logo beside PvP.
- Removed the Curated Community Overview and Curated Community Estimate labels
  from the Class Tiers heading.
- Restored Feathered Arrow as the top level-19 bow ammunition after separating
  its level-30 acquisition quest from the item's unrestricted transferable use.
- Replaced the unavailable Gurubashi chest texture path with the Classic item
  icon for Arena Master so the event card always has a visible icon.

## 0.3.10 - 2026-08-11

### Added

- Added a bracket-aware PvP Events page with room for three confirmed sessions,
  an empty-state announcement and copyable submission contacts for Lovepotion
  and the supplied Discord profile.
- Added Firemaw EU level-19 Horde-vs-Alliance Warsong Gulch sessions for
  15 and 16 August 2026, both from 16:00 to 21:00 server time, with native
  Blizzard Horde and Alliance PvP icons.
- Scoped Lovepotion mail to Firemaw EU Horde and moved the all-realm Discord
  submission contact into a separate right-side column.
- Moved the PvP navigation button to the right side of the logo and centered
  the `VS` label explicitly between the native Horde and Alliance icons.
- Removed the submission contact name from confirmed event rows; it now appears
  only in the dedicated contact section.
- Added a `BE READY FOR BATTLE!` callout and a server-time countdown that shows
  days/hours before each event, a live hours-remaining state and `ENDED` after it.
- Marked both WSG sessions for the full Firemaw cluster and all connected realms.

## 0.3.9 - 2026-08-11

### Added

- Added a compact bracket-specific Class Tiers page with a descending S-to-C
  tree and Offense, Survival and Utility scores out of 10 for all nine classes.
  Roles stay on the cards, rationales move to tooltips, and the level-29 view is
  explicitly labeled as a curated community estimate.
- Completed the level-29 bracket with independent S/A/B gear profiles for all
  nine classes, explicit second ring and trinket slots, and bracket-specific
  Enchants, Consumables, Twink Basics, profession Guides and Exploration routes.
- Added level-29 permanent enhancements including item-level-gated Deadly and
  Sniper Scopes, Steel Weapon Chain, Iron Counterweight and Thorium Shield Spike.
- Added the level-29 consumable tiers: Heavy Mageweave Bandage, stronger food,
  potions, elixirs and rank-II scrolls, Engineering 175-225 utility, legal
  level-25 ammunition, temporary oils/stones and class reagents.
- Enabled level 29 in the persistent bracket selector while keeping level 39
  unavailable.

### Corrected

- Separated Tier B and C styling with muted purple for B and silver-grey for C.
- Aligned the left navigation tabs to the same 20px content edge as the Select
  Class panel and the tables below it.
- Right-aligned the Gear, Enchants and Consumables controls as one group so
  long class-role descriptions retain clear space beside the first button.
- Shifted the right-side Exploration and Community tabs away from the Settings
  control, leaving a clear gap between navigation and window controls.
- Standardized every item and spell tooltip to open beside the mouse cursor,
  regardless of whether the hovered target is a small icon or a full row.
- Kept the Guides tagline inside the space beside the Wowhead field so longer
  profession descriptions no longer render underneath the link box.
- Stabilized lower-right resizing by preserving the window's on-screen geometry
  when sizing begins, and aligned the saved minimum width with the 880px UI
  limit.
- Enlarged and brightened the main window close button with a clearer hover
  target.
- Added Runecloth Bandage as the weaker First Aid 200 alternative directly
  below Heavy Runecloth Bandage for every class.
- Clarified throughout Consumables and the First Aid guide that vendor books
  only unlock the level-19 skill cap: neither Runecloth variant can be crafted
  by the level-19 character, so finished bandages must come from elsewhere.
- Re-audited Druid, Hunter, Mage, Paladin, Priest, Shaman and Warlock gear
  against multiple Classic guides and each changed item's Wowhead Classic page.
- Expanded role and faction coverage with focused Druid boots and rings, Hunter
  wrist and ring variants, Protector's Sword for Paladin, four Priest quest
  alternatives and Miner's Cape for Warlock.
- Removed or replaced impossible random-suffix combinations across Mage, Priest,
  Shaman and Warlock, and corrected Gravestone Scepter to a neutral quest wand.
- Removed Feathered Arrow and Exploding Shot from level 19 after confirming their
  hidden level-30 requirement, and corrected Light Feather to state that Slow
  Fall consumes it.
- Removed level-30+ items, non-equippable consumables and impossible suffixes
  found by the final independent level-29 gear validation.

## 0.3.8 - 2026-08-11

### Fixed

- Use a dedicated high-contrast TGA icon in the in-game AddOns list.

## 0.3.7 - 2026-08-10

### Changed

- Moved all nine class selectors into one compact horizontal row and gave the
  gear, enchant and consumable tables the full available window width.
- Centered the class selector row dynamically at every supported window width.
- Reduced the minimum window width from 980px to 880px while preserving readable
  class selectors and tier columns.
- Compacted the three left navigation tabs so Guides no longer overlaps the
  centered logo at the minimum window width.

### Fixed

- Restored WoW's standard modified item-click handling so Shift-clicking addon
  items can populate Auction House search as well as insert links into chat.

### Corrected

- Promoted Heavy Runecloth Bandage to the top level-19 bandage after confirming
  that using it requires First Aid 225, while crafting it requires First Aid
  290 and therefore a higher-level character.
- Updated the First Aid guide to distinguish the best usable bandage from the
  best bandage a level-19 character can craft personally.
- Added Discombobulator Ray and Goblin Rocket Boots as externally crafted items
  that a level-19 character can use, including shared-cooldown, equipment,
  malfunction and Hardcore cautions.
- Added a World Utility consumables group with Magic Dust and the rare,
  one-charge Glowing Cat Figurine guardian.
- Kept Large Rope Net excluded because it was removed from the obtainable loot
  tables used by Classic Era.
- Re-audited Rogue gear: promoted Trailblazer Boots alongside Feet of the Lynx
  and Nat Pagle's boots as role-specific S-tier choices, promoted the faction
  WSG bows, and made Naxx-compatible white shoulders the premium shoulder set.
- Expanded equal-tier gear rows to display up to three full-size choices when
  a class has three genuine role variants.

## 0.3.6 - 2026-08-09

### Fixed

- Replaced the wide Settings header label with a small square Blizzard options
  icon beside the close button so it no longer overlaps the Community tab.

## 0.3.5 - 2026-08-09

### Added

- Added a compact Settings button and per-character option to show or hide the
  minimap icon immediately.

## 0.3.4 - 2026-08-09

### Added

- Added missing-area names to incomplete Exploration tooltips, including the
  exact remaining map area when a zone is one reveal short of completion.

## 0.3.3 - 2026-08-09

### Added

- Added complete level-19 profession progression to Guides: explicit material
  reserves and craft counts for First Aid 1-225 and Engineering 1-150, plus
  Fishing locations and estimated successful catches for each 1-150 segment.
- Added every material and intermediate Engineering item used by the new route
  as an illustrated, tooltip-enabled guide entry with its Wowhead Classic URL.

### Changed

- Documented the real level-19 profession caps: First Aid can reach 225, while
  Expert Fishing and Expert Engineering require level 20 and therefore stop at
  150 in this addon.
- Increased all addon-rendered font sizes by one pixel for better readability
  while preserving the existing visual hierarchy and layout scale.
- Replaced the blue Guides headings, labels and body copy with a warm gold and
  neutral-grey palette so guide styling is visually distinct from Alliance.

## 0.3.2 - 2026-08-09

### Added

- Added compact `19 / 29 / 39` bracket selectors below the header logo and
  prepared per-character bracket persistence. Level 19 remains active, while
  the future level 29 and 39 profiles are greyed out with a `Coming soon`
  tooltip and cannot yet replace the level-19 data.

### Changed

- Added original bracket artwork with a full-color level-19 emblem and
  desaturated level-29 and level-39 previews, positioned compactly below the
  logo without touching the content panel.
- Reduced Windows deployment overhead by testing and packaging all four addons
  through one remote SSH run and downloading one combined runtime archive.
- Rewrote the CurseForge description to match the current Gear, Enchants,
  Consumables, Guides, Community and automatic Exploration functionality while
  clearly identifying level 29 and 39 as future profiles.

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
