# Compatibility and verification

TwinkTracker targets World of Warcraft Classic Era and Classic Hardcore with
interface `11509`. It intentionally does not load in TBC, Wrath, Retail, Season
of Discovery, or Anniversary clients.

Automated checks prove Lua 5.1 syntax, static-data integrity, persisted-state
normalization, XP risk calculations, TOC metadata and deployment-script
presence. They do not prove client UI layout or current item availability.

Before a release, verify in a current Era client:

1. `/tt` opens, moves, resizes and closes the main window.
2. Window position, size, selected page, class and Gear sub-section persist
   through `/reload`.
3. Gear, Twink Basics, Exploration and Community switch cleanly at minimum and
   maximum window sizes.
4. Each of the nine class profiles renders in Gear, Enchants and Consumables.
   Item entries show item tooltips; spell-based enchants show spell tooltips.
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
    Firemaw Cluster and its Discord address can be selected and copied. Confirm
    that Twink Factory appears as Alliance with Sparre as its invite contact and
    no Discord row.
14. Left-clicking every item with an ID selects its matching Wowhead Classic URL
    for Ctrl+C copying; Shift-click continues to insert the normal item link in
    an open chat input.
15. In a tier containing two choices, equipping either the upper or lower item
    independently adds its green border, name and background highlight.
16. Exploration displays Horde and Alliance columns with Starting & Core,
    World PvP Targets and Travel & Twink Events sections. Horde places Redridge
    under World PvP and Swamp of Sorrows under Travel; Alliance places the
    Barrens and Stonetalon under World PvP. Both place Stranglethorn Vale under
    Travel & Twink Events, and saved page selection survives `/reload`.
17. Exploration rows are read-only and show `revealed/total` plus a percentage.
    Reveal part of a zone, confirm `MAP_EXPLORATION_UPDATED` refreshes its row,
    and confirm the same values return after `/reload`. Progress bars and labels
    move from red through gold and blue to green at 100%; the UI still warns
    that 100% does not guarantee zero remaining exploration XP.
18. Twink Basics is read-only, contains no numbered steps or WSG advice and
    clearly warns that XP cannot be locked in Classic Era.
19. Gear remains the existing S/A/B table. Enchants replace it with only the
    relevant slots, while Consumables render grouped categories without overlap
    or clipped details at minimum and maximum window sizes.
20. Left-clicking an enchant or consumable selects its exact Wowhead Classic
    item/spell URL. Shift-clicking an item-based row inserts its item link into
    an open chat box without triggering any game action.
    Confirm every Consumables row also loads the matching native item icon after
    item data is cached.
21. On a live level-19 character, verify Heavy Runecloth Bandage at First Aid
    225, potion and explosive cooldown sharing, food/elixir/scroll replacement,
    Shaman weapon-imbue replacement and listed proc enchant behavior.
22. Confirm excluded level-20+ entries never appear: Free Action Potion, Minor
    Mana Oil, Razor Arrow and Solid Shot. HEAD/LEGS Arcanums must retain their
    high-level application warning; Naxx shoulder augments use the documented
    level-60 white, non-binding item route, while ZG Signets remain absent.
23. Each class shows at least five Potion and five Scroll rows. Confirm long
    categories remain scrollable and item icons, names and detail text do not
    overlap at minimum window width.
24. The Horde Community card shows the compact Twink or Treat logo from the
    bundled TGA asset without obscuring the guild name or realm line.
25. Every class displays three or four focused HEAD and LEGS Arcanum choices,
    and no enchant slot displays more than four focused recommendations.
