# Burning Crusade Classic data audit

The TBC client uses the same level 19, 29 and 39 bracket UI, but loads a
separate data layer from `TwinkTracker_TBC.toc`. The game selects the matching
TOC automatically; there is no expansion switch in the addon.

Every TBC class audit covers every inherited gear slot and every S/A/B tier.
Unchanged tiers are recorded as `KEEP`; a promoted or replaced slot records all
three tiers as `CHANGE`. The automated TBC test rejects a missing class, slot,
tier, source list, TBC Wowhead link, faction counterpart or invalid choice
count.

## Primary references

- [Wowhead TBC level-19 Druid guide](https://www.wowhead.com/tbc/guide/tbc-classic-level-19-twink-druid-bis-guide-14166)
- [Wowhead TBC item catalog](https://www.wowhead.com/tbc/items)
- [Wowhead TBC Enchanting overview](https://www.wowhead.com/tbc/guide/professions/enchanting-overview)
- [Wowhead TBC level-29 enchant forum](https://www.wowhead.com/tbc/forums/topic/few-question-reguarding-29-twink-echants-36829)
- [Boar's Speed spell tooltip](https://www.wowhead.com/tbc/spell=34008/enchant-boots-boars-speed)
- [Exceptional Stats spell tooltip](https://www.wowhead.com/tbc/spell=27960/enchant-chest-exceptional-stats)
- [Major Spellpower spell tooltip](https://www.wowhead.com/tbc/spell=27975/enchant-weapon-major-spellpower)
- [Major Healing spell tooltip](https://www.wowhead.com/tbc/spell=34010/enchant-weapon-major-healing)
- [Nethercleft Leg Armor tooltip and period comments](https://www.wowhead.com/tbc/item=29536/nethercleft-leg-armor)
- [Golden Spellthread tooltip and period comments](https://www.wowhead.com/tbc/item=24276/golden-spellthread)
- [Wowhead TBC First Aid route](https://www.wowhead.com/tbc/guide/first-aid-leveling-1-375)
- [Wowhead TBC Engineering route](https://www.wowhead.com/tbc/guide/professions/engineering-leveling-1-375)
- [Wowhead TBC Jewelcrafting 1-300 route](https://www.wowhead.com/tbc/guide/jewelcrafting-leveling-1-300-burning-crusade-classic)
- [Wowhead TBC Jewelcrafting recipes](https://www.wowhead.com/tbc/guide/jewelcrafting-recipes-locations-1-300-burning-crusade-classic)
- [Blizzard TBC hotfixes: corrected monthly Darkmoon schedule](https://us.forums.blizzard.com/en/wow/t/the-burning-crusade-hotfixes-updated-june-22/2227871/169)
- [Wowhead TBC Darkmoon Faire locations and opening rule](https://www.wowhead.com/tbc/guide/darkmoon-faire-event-trinkets-buffs-burning-crusade-classic)
- [Blizzard 2026 Children's Week dates and Classic availability](https://worldofwarcraft.blizzard.com/en-gb/news/24276749)
- [Blizzard Brewfest dates](https://worldofwarcraft.blizzard.com/en-us/news/7237858/brewfest)
- [Wowhead 2026 TBC Midsummer dates](https://www.wowhead.com/tbc/news/the-midsummer-fire-festival-burns-until-july-5th-the-burning-crusade-anniversary-381943)
- [Wowhead TBC holiday guides and current Anniversary news](https://www.wowhead.com/tbc/news)
- Individual TBC item and spell pages linked by every real entry.

Historical XPOff, Wowhead forum, Reddit and video gear sets are secondary
candidate sources. Their claims are never accepted solely from a list: exact
English item name, ID, required level, armor or weapon proficiency, faction
route, binding, random suffix and target-item enchant eligibility are checked
separately.

## TBC-specific rules

1. Paladin supports Alliance and Horde Blood Elf routes. Shaman supports Horde
   and Alliance Draenei routes. Neutral items must not inherit an Era class
   faction lock.
2. Battleground rewards are TBC data, not Hardcore data. Their current vendor
   phase remains a live-client validation point.
3. The permanent TBC enchanting recipes included by this layer require a target
   item level of 35 or higher. That is a property of the item being enchanted,
   not a requirement for the twink to be level 35. A sufficiently skilled
   enchanter can use the trade window on soulbound gear, but a required-level-29
   item is not automatically eligible: verify its actual item level. Inherited
   Era enchants have no blanket item-level-35 floor and remain the correct
   fallback on ineligible gear. At level 19, the TBC chest upgrades are exposed
   only for Mage and Warlock because their audited gear profiles explicitly
   retain Inferno Robe as an eligible high-item-level base.
4. Leg armor and spellthread are deliberately modelled separately. The finished
   enhancement requires its user to be level 60, but does not carry the TBC
   enchanting item-level-35 target restriction. The level-60+ applicator must
   hold tradeable/non-soulbound legs in their own inventory, apply the item and
   then transfer the enchanted legs. It cannot be applied through the trade
   window to pants already soulbound to the twink.
5. Ring enchants are omitted: they require an enchanter to enchant their own
   rings and are not a transferable low-bracket service. Outland head and
   shoulder inscriptions/glyphs are likewise not presented as low-bracket
   replacements; inherited Libram/Scourge entries retain conservative live
   application cautions.
6. Jewelcrafting statues bind on pickup and belong to the twink's own
   profession plan. Shared cooldowns, attackability and live healing behavior
   are stated as cautions.
7. Quest, dungeon, reputation, pet-training and exploration routes retain XP
   warnings because TBC Classic does not provide an XP-off switch.
8. TBC class tiers are separate community estimates. Equal tiers are never
   ordered internally, and talent availability is checked against the bracket
   level.
9. Every TBC Jewelcrafting bracket guide contains its own skill 1-to-cap route.
   The craft ranges and material counts follow the current Wowhead TBC 1-300
   path; yellow recipes retain an explicit material buffer.
10. TBC event timing is not inherited from Classic Era. The battleground card
   follows the current four-event Anniversary rotation, Darkmoon includes its
   Terokkar stop, and all ten period holidays are tracked. Blizzard can apply
   exceptional or emergency calendar changes, so future dates remain planning
   estimates until confirmed in the live client or an official announcement.
