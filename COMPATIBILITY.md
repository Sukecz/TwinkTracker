# Compatibility and verification

The pilot targets World of Warcraft Classic Era and Classic Hardcore with
interface `11509`. It intentionally does not load in TBC, Wrath, Retail, Season
of Discovery, or Anniversary clients.

Automated checks prove Lua 5.1 syntax, static-data integrity, persisted-state
normalization, XP risk calculations, TOC metadata and deployment-script
presence. They do not prove client UI layout or current item availability.

Before a release, verify in a current Era client:

1. `/tt` opens, moves and closes the main window.
2. Checklist entries persist through `/reload`.
3. XP values match Blizzard's experience bar at levels below and at 19.
4. Each of the nine class profiles renders and can show item tooltips.
5. XP Lockdown is visibly described as a local warning mode, not an XP stop.
6. Gear, enchant and consumable availability is checked against the intended
   Era realm/faction and current client data.
