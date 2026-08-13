# Compatibility and live verification

TwinkTracker supports two automatically selected Classic clients from one
shared addon folder:

- **Classic Era and Classic Hardcore** through `TwinkTracker.toc`, interface
  `11509` and the Era data profile.
- **Burning Crusade Classic** through `TwinkTracker_TBC.toc`, interface `20506`
  and the TBC data profile.

There is no in-addon expansion switch. The game must load only the matching TOC,
and the non-interactive footer must identify the active client and addon
version. Wrath, Retail and other unsupported clients must not load either
profile accidentally.

Automated checks cover Lua 5.1 syntax, both TOCs, client selection, static-data
integrity, all level-19/29/39 profiles, persisted-state normalization and the
TBC audit manifest. They do not prove live UI geometry, item availability,
realm-specific routes, event timing or unusual enchant application behavior.

## Shared live checklist

Complete these checks in both an Era/Hardcore client and a TBC client:

1. Confirm the addon loads without Lua errors and the footer shows the correct
   client name and current addon version.
2. Open the window with `/twinktracker` or `/twt`; move and resize it, drag the
   minimap button, then verify position, size, selected page, class and bracket
   survive `/reload`.
3. Switch through brackets **19, 29 and 39**. For every bracket, open all nine
   classes and confirm Gear, Enchants, Consumables, Class Tiers, Twink Basics,
   Guides and Exploration render without overlap at minimum and maximum window
   sizes.
4. Confirm Tier S/A/B rows retain equal styling for equal choices, faction
   badges are readable, both ring and trinket slots are explicit, and separate
   1H/2H/off-hand/ranged rows appear only where class proficiency allows them.
5. Equip and remove listed items. Green equipped highlighting must update
   immediately, including independent same-tier choices and exact
   random-suffix matching.
6. Hover gear, enchant, consumable and guide items for native tooltips.
   Shift-click item entries into chat or Auction House search and confirm no
   equipment or other protected action is performed.
7. Left-click real entries and verify the copy field uses the active
   expansion's Wowhead item or spell URL: `/classic/` in Era/Hardcore and
   `/tbc/` in TBC.
8. Verify Exploration updates visible-map progress after
   `MAP_EXPLORATION_UPDATED`, persists after `/reload`, and continues to warn
   that 100% visible-map reveal does not prove that no exploration XP remains.
9. Check Twink Basics and profession guides for the selected bracket. They must
   remain read-only, state the absence of XP locking and distinguish use,
   crafting, profession-skill and character-level requirements.
10. Confirm long Gear, Consumables and Guide content remains scrollable and
    item icons, names, restrictions and faction markers do not overlap.

## Era and Hardcore checks

1. Confirm the **PvP Events** navigation button and page are present.
2. Verify its confirmed community rows, submission contacts and WSG
   bonus-weekend estimate render for the selected bracket without claiming
   automatic queueing or guaranteed current scheduling.
3. Confirm Event Timers, Community listings and all copied links identify
   Classic Era where applicable.
4. Spot-check Era-only gear, PvP vendors, enchants and profession limits in the
   current client and intended realm/faction before release.

## Burning Crusade Classic checks

1. Confirm the **PvP Events button and page are absent**. Era Firemaw
   announcements and the Era-specific PvP page must not be reachable through
   saved page state, slash commands or bracket changes.
2. Confirm brackets 19, 29 and 39 load TBC gear deltas, TBC class-tier data and
   TBC Wowhead links for all nine classes.
3. Verify Blood Elf Paladin and Draenei Shaman faction routes appear where
   relevant and that their opposite-faction restrictions remain correct.
4. Confirm Jewelcrafting appears in Guides and TBC-only statues appear only
   where their profession and bracket requirements permit them.
5. Spot-check TBC item-stat changes, required levels, PvP rewards and target
   item-level enchant gates in the live client. Pay particular attention to
   BoP versus BoE leg armor, spellthread, chest, bracer, boot and weapon
   application rules before treating an expensive setup as obtainable.
6. Confirm saved selection of the removed PvP page falls back to a valid page
   when entering TBC and remains stable through `/reload`.

## Release boundary

A passing static suite or successful package proves neither client-specific
runtime behavior nor live data availability. Record Era/Hardcore and TBC live
verification separately, and do not infer Windows deployment, publication or
CurseForge indexing from local test success.
