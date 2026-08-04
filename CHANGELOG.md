# Changelog

All notable changes are documented here.

## Unreleased

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
