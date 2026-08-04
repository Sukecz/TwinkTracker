# Compatibility and verification

The pilot targets World of Warcraft Classic Era and Classic Hardcore with
interface `11509`. It intentionally does not load in TBC, Wrath, Retail, Season
of Discovery, or Anniversary clients.

Automated checks prove Lua 5.1 syntax, static-data integrity, persisted-state
normalization, XP risk calculations, TOC metadata and deployment-script
presence. They do not prove client UI layout or current item availability.

Before a release, verify in a current Era client:

1. `/tt` opens, moves, resizes and closes the main window.
2. Window position, size, selected page and class persist through `/reload`.
3. Gear and Twink Basics switch cleanly at minimum and maximum window sizes.
4. Each of the nine class profiles renders and can show item tooltips.
5. Every applicable class shows separate 1H and 2H S/A/B weapon rows.
6. Equipping and removing listed gear updates the green `EQUIPPED` state, and
   random-suffix variants do not highlight a different alternative with the
   same base item ID.
7. Blue Alliance and red Horde badges remain readable at minimum window size.
8. Gear, enchant and consumable availability is checked against the intended
   Era realm/faction and current client data.
