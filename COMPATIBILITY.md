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
8. Same-tier choices stack vertically in an expanded slot row, use two equally
   sized icons and equal name styling, and each keeps its own faction badge,
   equipped state and native tooltip across the supported window sizes.
9. With a chat edit box open, Shift-clicking either same-tier choice inserts
   that choice's item link without performing any equipment action.
10. `/tt` opens the addon when unclaimed; if a character-specific addon owns
    that alias, the collision notice appears and `/twt` remains available.
11. Gear, enchant and consumable availability is checked against the intended
    Era realm/faction and current client data.
12. The minimap button opens and closes the window, its tooltip remains readable,
    and dragging it around the minimap persists its position through `/reload`.
13. The Community page shows Twink or Treat as a Horde guild on the EU PvP
    Firemaw Cluster and its Discord address can be selected and copied.
14. Left-clicking every item with an ID selects its matching Wowhead Classic URL
    for Ctrl+C copying; Shift-click continues to insert the normal item link in
    an open chat input.
