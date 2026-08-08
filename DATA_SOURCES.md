# Gear data sources and audit rules

TwinkTracker targets level 19 on WoW Classic Era / Hardcore. A guide is a
candidate source, not proof that every listed item is currently obtainable or
usable. Every recommendation must also be checked against its individual
Wowhead Classic item page and, where noted, the live Era client.

## Class guides

| Class | Wowhead Classic | Warcraft Tavern |
| --- | --- | --- |
| Druid | [Level 19 Druid](https://www.wowhead.com/classic/guide/druid-classic-level-19-twink) | [Level 19 Druid](https://www.warcrafttavern.com/wow-classic/guides/19-druid-twink/) |
| Hunter | [Level 19 Hunter](https://www.wowhead.com/classic/guide/hunter-classic-level-19-twink) | [Level 19 Hunter](https://www.warcrafttavern.com/wow-classic/guides/19-twink-hunter/) |
| Mage | [Level 19 Mage](https://www.wowhead.com/classic/guide/mage-classic-level-19-twink) | [Level 19 Mage](https://www.warcrafttavern.com/guides/19-twink-mage/) |
| Paladin | [Level 19 Paladin](https://www.wowhead.com/classic/guide/paladin-classic-level-19-twink) | [Level 19 Paladin](https://www.warcrafttavern.com/wow-classic/guides/19-twink-paladin/) |
| Priest | [Level 19 Priest](https://www.wowhead.com/classic/guide/priest-classic-level-19-twink) | [Level 19 Priest](https://www.warcrafttavern.com/wow-classic/guides/19-twink-priest/) |
| Rogue | [Level 19 Rogue](https://www.wowhead.com/classic/guide/rogue-classic-level-19-twink) | [Level 19 Rogue](https://www.warcrafttavern.com/wow-classic/guides/19-twink-rogue/) |
| Shaman | [Level 19 Shaman](https://www.wowhead.com/classic/guide/shaman-classic-level-19-twink) | [Level 19 Shaman](https://www.warcrafttavern.com/wow-classic/guides/19-twink-shaman/) |
| Warlock | [Level 19 Warlock](https://www.wowhead.com/classic/guide/warlock-classic-level-19-twink) | [Level 19 Warlock](https://www.warcrafttavern.com/wow-classic/guides/19-twink-warlock/) |
| Warrior | [Level 19 Warrior](https://www.wowhead.com/classic/guide/warrior-classic-level-19-twink) | [Level 19 Warrior](https://www.warcrafttavern.com/wow-classic/guides/19-twink-warrior/) |

Supporting references:

- [Classic level-19 roles and strategy](https://www.warcrafttavern.com/wow-classic/guides/lvl-19-twinking-for-dummies/)
- [Classic Twinking optimization overview](https://www.warcrafttavern.com/wow-classic/guides/twinking/) — planning context for gear, professions and preparation; specific old-era restrictions still require live validation.
- [Jamesb's 19 Vanilla Gearing Guide](https://xpoff.com/threads/jamesbs-19-vanilla-gearing-guide.83959/) — historical secondary source; access may be blocked and every claim requires independent verification.
- [Blackfathom Deeps quests](https://www.wowhead.com/classic/guide/classic-wow-blackfathom-deeps-dungeon-quests)
- [Shadowfang Keep quests](https://www.wowhead.com/classic/guide/classic-wow-shadowfang-keep-dungeon-quests)

## Twink Basics rules

Twink Basics is intentionally limited to stable safety rules rather than build
or battleground strategy. Classic Era has no XP-off switch, and level-19
characters must avoid mob, quest, dungeon and exploration XP after completing
their preparation. The wording was cross-checked against:

- [Wowhead level-19 preparation warning](https://www.wowhead.com/classic/guide/rogue-classic-level-19-twink)
- [XP disabling was introduced only in patch 3.2](https://warcraft.wiki.gg/wiki/Slahtz)
- [Classic forum: XP cannot be disabled](https://us.forums.blizzard.com/en/wow/t/can-you-turn-off-experience-gain-in-classic/261246)
- [Classic forum: quest, kill and exploration risks](https://us.forums.blizzard.com/en/wow/t/is-there-a-way-to-turn-off-xp/522908)

## Required checks

Before adding or changing an item:

1. Confirm the exact English name and positive item ID on
   `https://www.wowhead.com/classic/item=<ID>`.
2. Confirm the item requires level 19 or lower. A random suffix does not change
   the base item's required level.
3. Confirm that the class can equip the armor and weapon type at level 19 in
   Vanilla/Era, including level-gated weapon talents.
4. Distinguish an item's faction restriction from a faction-specific acquisition
   route. Do not mark a neutral BoE item as faction-locked merely because one
   guide lists it for that faction.
5. Put true Alliance/Horde equivalents in the same tier. Paladin is
   Alliance-only and Shaman is Horde-only in Vanilla Era.
6. Keep role alternatives explicit: survival, healer/caster, physical damage,
   and proc setups are not a single universal ranking.
7. Define Ring 2 and Trinket 2 deliberately; never derive them by rotating the
   first slot's tiers.
8. Treat random suffix names and maximum rolls as live/AH validation points.
9. Keep uncertain current vendor, quest, event, or drop availability marked for
   live Firemaw Era validation rather than claiming it is confirmed.

## Enchants and consumables

Enchant and consumable candidates were audited independently for all nine
classes, then normalized into one shared catalog. Class profiles only add
priority and role context. Every real entry must retain its individual Wowhead
Classic item or spell URL.

Primary supporting references:

- [Classic Enchanting 1-300](https://www.wowhead.com/classic/guide/enchanting-leveling-1-300-wow-classic)
- [Classic Arcanums and Librams](https://www.wowhead.com/classic/guide/arcanums-gear-enchants-classic-wow)
- [Classic First Aid 1-300](https://www.wowhead.com/classic/guide/first-aid-leveling-1-300-wow-classic)
- The individual Wowhead Classic item/spell page linked by every catalog entry
- The class guides indexed above, used as candidate lists rather than proof

Rules for future changes:

1. Confirm the exact Classic Era tooltip, item/spell ID, effect and requirement.
2. Never add a consumable requiring level 20 or higher. Current explicit
   exclusions include Free Action Potion (5634), Minor Mana Oil (20745), Razor
   Arrow (3030) and Solid Shot (3033).
3. Distinguish a permanent enchant from a temporary weapon coating. Shaman
   weapon imbues replace oils/stones; a Druid's weapon damage does not improve
   Bear Form attacks; level-19 Rogue poisons and Warrior Dual Wield are absent.
4. HEAD/LEGS Arcanums from Libram turn-ins may be listed because they are core
   Classic enchant paths, but must state that a high-level character performs
   the turn-in/application and that clean Firemaw application remains a live
   gate. Unverified raid shoulder augments remain excluded.
5. Treat stacking, replacement, shared cooldowns, proc rates and low-rank spell
   coefficients as live-client validation points. The addon describes these
   cautions instead of inventing a mathematical universal best choice.
6. Level-19 characters can reach First Aid 225 in Classic Era; Heavy Runecloth
   Bandage requires that skill and is listed with its interrupt and Recently
   Bandaged limitations.
7. Enchant recommendations are deliberately capped at three per slot. Select
   the strongest role-distinct choices rather than listing every formula. Each
   class exposes at least five legal potion and five legal scroll choices.
8. Warrior weapon enchants are role-dependent. The historical class guides
   support Lifestealing as an all-round pressure/sustain option, Fiery Weapon as
   a frequent and cheaper damage proc, Crusader as a high-variance Strength proc
   and direct weapon damage or Agility as deterministic alternatives. Keep proc
   rankings explicitly subject to live combat-log testing.

## Exploration routes

The Exploration tab follows the Classic level-19 guidance to reveal every zone
the character may visit before the final level lock. Recommended low-level
routes and level ranges were cross-checked against:

- [Wowhead Alliance leveling zones](https://www.wowhead.com/classic/guide/alliance-leveling-classic-wow)
- [Wowhead level-19 Rogue preparation](https://www.wowhead.com/classic/guide/rogue-classic-level-19-twink)
- [Warcraft Tavern Classic exploration ranges](https://www.warcrafttavern.com/wow-classic/guides/exploration/)
- [Classic zone levels and territory](https://warcraft.wiki.gg/wiki/Zones_by_level_%28Classic%29)

Classic Era exposes the character's revealed map overlays but not a reliable
complete set of possible overlays. Dividing them by the rectangular map-art
area produces misleading percentages for irregular maps, while counting the
returned overlays has no useful completion denominator. Exploration therefore
uses a persistent manual per-character checklist. The user marks a route done
after checking the normal map and any invisible exploration-XP subzones.
