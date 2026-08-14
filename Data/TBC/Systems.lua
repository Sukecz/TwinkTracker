local addonName, ns = ...

local TBC = ns.TBCData
local TBC_SOURCE = "https://www.wowhead.com/tbc/guide/professions/enchanting-overview"
local TWINK_SOURCE = "https://www.wowhead.com/tbc/guide/tbc-classic-level-19-twink-druid-bis-guide-14166"
local TWINK_FORUM_SOURCE = "https://www.wowhead.com/tbc/forums/topic/few-question-reguarding-29-twink-echants-36829"
local ITEM_LEVEL_CAUTION = "TARGET ITEM LEVEL 35+; this is not a level-35 character requirement. A high-level enchanter can apply it through the trade window, including to soulbound gear, but the selected target itself must be eligible. Inherited Era enchants remain valid for lower-item-level gear."
local LEG_APPLICATION_CAUTION = "The finished enhancement Requires Level 60 to use. A level-60+ character must hold the non-soulbound/tradeable legs in their own inventory, apply the enhancement, then transfer the legs. This is not a trade-window service for already soulbound twink legs and has no item-level-35 target requirement."

local function recommendation(key, priority, roles, note)
    return { key = key, priority = priority, roles = roles, note = note }
end

local function addSpell(catalog, key, name, effect, spellID, restrictions)
    catalog[key] = {
        name = name,
        effect = effect,
        spellID = spellID,
        restrictions = restrictions,
        wowhead = "https://www.wowhead.com/tbc/spell=" .. spellID,
        minTargetItemLevel = 35,
        requirementType = "TARGET_ITEM_LEVEL",
    }
end

local function addItem(catalog, key, name, effect, itemID, restrictions)
    catalog[key] = {
        name = name,
        effect = effect,
        itemID = itemID,
        restrictions = restrictions,
        wowhead = "https://www.wowhead.com/tbc/item=" .. itemID,
        applierMinimumLevel = 60,
        requiresTradeableTarget = true,
        requirementType = "APPLIER_CHARACTER_LEVEL",
    }
end

local function setSlot(data, token, slot, recommendations)
    assert(#recommendations > 0 and #recommendations <= 4, token .. " " .. slot .. " has an invalid TBC enchant list")
    local profile = assert(data.classes[token])
    profile.slots[slot] = recommendations
    local present = false
    for _, existing in ipairs(profile.slotOrder) do
        if existing == slot then present = true break end
    end
    if not present then profile.slotOrder[#profile.slotOrder + 1] = slot end
end

local physical = { DRUID=true, HUNTER=true, PALADIN=true, ROGUE=true, SHAMAN=true, WARRIOR=true }
local healer = { DRUID=true, PALADIN=true, PRIEST=true, SHAMAN=true }
local shieldUser = { PALADIN=true, SHAMAN=true, WARRIOR=true }

local function recommendationExists(list, itemID)
    for _, entry in ipairs(list or {}) do
        if entry.itemID == itemID then return true end
    end
    return false
end

local function addConsumable(data, itemID, name, effect, profession, restrictions)
    data.catalog[itemID] = {
        itemID = itemID,
        name = name,
        effect = effect,
        profession = profession,
        restrictions = restrictions,
        wowhead = "https://www.wowhead.com/tbc/item=" .. itemID,
    }
end

local function guideItem(id, name, note)
    return { id = id, name = name, note = note, wowhead = "https://www.wowhead.com/tbc/item=" .. id }
end

local function guideLine(label, text, itemIDs)
    return { label = label, text = text, itemIDs = itemIDs or {} }
end

local function guideStep(title, lines)
    return { title = title, lines = lines }
end

local function addJewelcraftingGuide(bracket, level)
    local guide = bracket.guides
    local cap = level == 19 and 150 or (level == 29 and 225 or 300)
    local shoppingLines = {
        guideLine("COPPER", "120x Copper Bar and 20x Tigerseye or Malachite."),
        guideLine("BRONZE", "100x Bronze Bar, 20x Small Lustrous Pearl and 20x Shadowgem."),
        guideLine("STONE", "200x Heavy Stone and 20x Moss Agate."),
        guideLine("BUFFER", "These are route totals; buy extra materials if yellow recipes do not grant enough skill points."),
    }
    if cap >= 225 then
        table.insert(shoppingLines, 4, guideLine("MITHRIL", "90x Mithril Bar, 80x Solid Stone and 15x Truesilver Bar."))
        table.insert(shoppingLines, 5, guideLine("EXPERT GEMS", "10x Citrine, 20x Elemental Water, 45x Aquamarine and 60x Flask of Mojo."))
    end
    if cap >= 300 then
        table.insert(shoppingLines, #shoppingLines, guideLine("THORIUM", "50x Thorium Bar, 10x Star Ruby and 20x Large Opal."))
        table.insert(shoppingLines, #shoppingLines, guideLine("FINAL GEMS", "5x Azerothian Diamond, 5x Blue Sapphire, 5x Essence of Undeath and 20x Huge Emerald."))
    end
    local levelingSteps = {
        guideStep("SKILL 1-75", {
            guideLine("1-30", "Craft 40x Delicate Copper Wire from 80x Copper Bar; save at least 20x wire."),
            guideLine("30-50", "Craft 20x Tigerseye Band or Malachite Pendant from 20x gems and 20x saved wire."),
            guideLine("50-75", "Start the 40x Bronze Setting batch from 80x Bronze Bar; continue crafting settings to skill 80 and save them."),
        }),
        guideStep("SKILL 75-110", {
            guideLine("75-80", "Finish the 40x Bronze Setting batch and keep every setting."),
            guideLine("80-100", "Craft 20x Simple Pearl Ring from 20x Small Lustrous Pearl, 20x Bronze Setting and 40x Copper Bar."),
            guideLine("100-110", "Craft 10x Ring of Twilight Shadows from 20x Shadowgem and 20x Bronze Bar."),
        }),
        guideStep("SKILL 110-150", {
            guideLine("110-130", "Craft about 25x Heavy Stone Statue from 200x Heavy Stone."),
            guideLine("130-150", "Craft about 20x Pendant of the Agate Shield from 20x Moss Agate and 20x saved Bronze Setting."),
            guideLine("DESIGN", "Buy Design: Pendant of the Agate Shield from Neal Allen in Wetlands or Jandia in Thousand Needles before this segment."),
            guideLine("CAP", cap == 150 and "Stop at 150: Expert Jewelcrafting requires character level 20." or "At character level 20, train Expert Jewelcrafting and continue to 225."),
        }),
    }
    if cap >= 225 then
        levelingSteps[#levelingSteps + 1] = guideStep("SKILL 150-185", {
            guideLine("150-180", "Craft about 35x Mithril Filigree from 70x Mithril Bar; save at least 30x filigree."),
            guideLine("180-185", "Craft about 8x Solid Stone Statue from 80x Solid Stone."),
            guideLine("BUFFER", "Both recipes become yellow; keep extra Mithril and Solid Stone for missed skill points."),
        })
        levelingSteps[#levelingSteps + 1] = guideStep("SKILL 185-225", {
            guideLine("185-200", "Craft 15x Engraved Truesilver Ring from 15x Truesilver Bar and 30x saved Mithril Filigree."),
            guideLine("200-210", "Craft 10x Citrine Ring of Rapid Healing from 10x Citrine, 20x Elemental Water and 20x Mithril Bar."),
            guideLine("210-225", "Craft 15x Aquamarine Signet from 45x Aquamarine and 60x Flask of Mojo."),
            guideLine("CAP", cap == 225 and "Stop at 225: Artisan Jewelcrafting requires character level 35." or "At character level 35, train Artisan Jewelcrafting and continue to 300."),
        })
    end
    if cap >= 300 then
        levelingSteps[#levelingSteps + 1] = guideStep("SKILL 225-260", {
            guideLine("225-250", "Craft 50x Thorium Setting from 50x Thorium Bar; keep every setting for the final crafts."),
            guideLine("250-260", "Craft 10x Ruby Pendant of Fire from 10x Star Ruby and 10x saved Thorium Setting."),
            guideLine("BUFFER", "Continue the yellow recipe if needed; keep extra Thorium Bar and Star Ruby."),
        })
        levelingSteps[#levelingSteps + 1] = guideStep("SKILL 260-300", {
            guideLine("260-280", "Craft 20x Simple Opal Ring from 20x Large Opal and 20x saved Thorium Setting."),
            guideLine("280-285", "Craft 5x Diamond Focus Ring from 5x Azerothian Diamond and 5x saved Thorium Setting."),
            guideLine("285-290", "Craft 5x Sapphire Pendant of Winter Night from 5x Blue Sapphire, 5x Essence of Undeath and 5x saved Thorium Setting."),
            guideLine("290-300", "Craft 10x Emerald Lion Ring from 20x Huge Emerald and 10x saved Thorium Setting."),
            guideLine("CAP", "Stop at 300; this is the maximum Jewelcrafting skill available to a level-39 character."),
        })
    end
    local guideSteps = {
        guideStep("SHOPPING LIST TO " .. cap, shoppingLines),
        guideStep("TRAINERS AND RANKS", {
            guideLine("TRAINERS", "Learn Jewelcrafting in Silvermoon City or the Exodar; keep Mining only if it fits the final profession plan."),
            guideLine("RANKS", "Train Journeyman between skill 50 and 75, Expert at level 20, and Artisan at level 35."),
            guideLine("CAP", "This bracket's complete route runs from skill 1 to " .. cap .. "."),
        }),
    }
    for _, levelingStep in ipairs(levelingSteps) do guideSteps[#guideSteps + 1] = levelingStep end
    local statueLines = {
        guideLine("HEAVY", "Heavy Stone Statue is trained at Jewelcrafting 110 and is the level-19 combat-heal option.", { 25881 }),
        guideLine("CRAFT", "Stone Statues bind on pickup, so the twink must craft its own supply before using one."),
    }
    if cap >= 225 then
        statueLines[#statueLines + 1] = guideLine("SOLID", "Solid Stone Statue is trained at Jewelcrafting 175 and is the Expert-rank combat-heal option.", { 25882 })
        statueLines[#statueLines + 1] = guideLine("DENSE", "Dense Stone Statue is trained at Jewelcrafting 225 and is the strongest available Azeroth statue in TBC.", { 25883 })
    end
    guideSteps[#guideSteps + 1] = guideStep("STONE STATUES", statueLines)
    guideSteps[#guideSteps + 1] = guideStep("COMBAT CAUTIONS", {
        guideLine("OWNER", "Statues bind on pickup; the twink must personally hold the required Jewelcrafting skill when crafting them."),
        guideLine("COUNTERPLAY", "A placed statue can be attacked and may stop healing when it engages a target."),
        guideLine("COOLDOWN", "Statues share cooldowns with several conjured and Engineering tools. Verify the exact current-client cooldown group before choosing both professions."),
    })
    guide.version = "2026-08-14-tbc"
    guide.sections.JEWELCRAFTING = {
        name = "Jewelcrafting",
        tagline = "TBC-only jewelry and self-crafted Bind-on-Pickup healing statues.",
        steps = guideSteps,
        items = {
            guideItem(25881, "Heavy Stone Statue", "Jewelcrafting 110 healing statue; TBC-only and Bind on Pickup."),
            guideItem(25882, "Solid Stone Statue", "Jewelcrafting 175 healing statue; TBC-only and Bind on Pickup."),
            guideItem(25883, "Dense Stone Statue", "Jewelcrafting 225 healing statue; TBC-only and Bind on Pickup."),
        },
    }
    guide.order[#guide.order + 1] = "JEWELCRAFTING"
end

for _, level in ipairs(ns.Brackets.order) do
    local bracket = TBC:GetBracket(level)
    addJewelcraftingGuide(bracket, level)
    local data = bracket.enchants
    data.version = "2026-08-13-tbc-enchant-audit"
    data.sources = { TBC_SOURCE, TWINK_SOURCE, TWINK_FORUM_SOURCE }

    for _, entry in pairs(data.catalog) do
        if entry.restrictions then
            entry.restrictions = string.gsub(entry.restrictions, "verify on Firemaw", "verify in the current TBC client")
            entry.restrictions = string.gsub(entry.restrictions, "unverified on Firemaw", "requires current TBC-client validation")
        end
    end

    addSpell(data.catalog, "tbcBoarsSpeed", "Enchant Boots - Boar's Speed", "9 Stamina and minor movement speed", 34008, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcCatsSwiftness", "Enchant Boots - Cat's Swiftness", "6 Agility and minor movement speed", 34007, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcExceptionalStats", "Enchant Chest - Exceptional Stats", "6 to all stats", 27960, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcExceptionalHealth", "Enchant Chest - Exceptional Health", "150 Health", 27957, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcBracerFortitude", "Enchant Bracer - Fortitude", "12 Stamina", 27914, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcBracerBrawn", "Enchant Bracer - Brawn", "12 Strength", 27899, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcBracerIntellect", "Enchant Bracer - Major Intellect", "12 Intellect", 34001, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcBracerHealing", "Enchant Bracer - Superior Healing", "30 Healing and 10 spell damage", 27911, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcBracerSpellpower", "Enchant Bracer - Spellpower", "15 spell damage and healing", 27917, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcGlovesStrength", "Enchant Gloves - Major Strength", "15 Strength", 33995, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcGlovesAssault", "Enchant Gloves - Assault", "26 Attack Power", 33996, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcGlovesSpellpower", "Enchant Gloves - Major Spellpower", "20 spell damage and healing", 33997, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcGlovesHealing", "Enchant Gloves - Major Healing", "35 Healing and 12 spell damage", 33999, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcCloakAgility", "Enchant Cloak - Greater Agility", "12 Agility", 34004, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcCloakArmor", "Enchant Cloak - Major Armor", "120 Armor", 27961, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcBootsFortitude", "Enchant Boots - Fortitude", "12 Stamina", 27950, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcBootsVitality", "Enchant Boots - Vitality", "4 health and mana every 5 sec", 27948, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcBootsSurefooted", "Enchant Boots - Surefooted", "10 hit rating and 5% snare/root resistance", 27954, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcMongoose", "Enchant Weapon - Mongoose", "Proc: 120 Agility and increased attack speed", 27984, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcPotency", "Enchant Weapon - Potency", "20 Strength", 27972, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcSavagery", "Enchant 2H Weapon - Savagery", "70 Attack Power", 27971, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcMajorAgility2H", "Enchant 2H Weapon - Major Agility", "35 Agility", 27977, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcMajorSpellpower", "Enchant Weapon - Major Spellpower", "40 spell damage and healing", 27975, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcMajorHealing", "Enchant Weapon - Major Healing", "81 Healing and 27 spell damage", 34010, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcMajorIntellect", "Enchant Weapon - Major Intellect", "30 Intellect", 27968, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcShieldStamina", "Enchant Shield - Major Stamina", "18 Stamina", 34009, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcShieldIntellect", "Enchant Shield - Intellect", "12 Intellect", 27945, ITEM_LEVEL_CAUTION)
    addSpell(data.catalog, "tbcShieldBlock", "Enchant Shield - Shield Block", "15 block rating", 27946, ITEM_LEVEL_CAUTION)
    addItem(data.catalog, "tbcNethercleft", "Nethercleft Leg Armor", "40 Stamina and 12 Agility", 29536, LEG_APPLICATION_CAUTION)
    addItem(data.catalog, "tbcNethercobra", "Nethercobra Leg Armor", "50 Attack Power and 12 critical strike rating", 29535, LEG_APPLICATION_CAUTION)
    addItem(data.catalog, "tbcGoldenSpellthread", "Golden Spellthread", "66 Healing, 22 spell damage and 20 Stamina", 24276, LEG_APPLICATION_CAUTION)
    addItem(data.catalog, "tbcRunicSpellthread", "Runic Spellthread", "35 spell damage and healing and 20 Stamina", 24274, LEG_APPLICATION_CAUTION)

    for _, token in ipairs(bracket.bis.classOrder) do
        local profile = data.classes[token]
        local existingFeet = profile.slots.FEET or {}
        local feetChoices = {
            recommendation("tbcBoarsSpeed", "PRIMARY", "survival / mobility", "Only Fishing Boots or another verified item-level-35+ target"),
        }
        if physical[token] then
            feetChoices[#feetChoices + 1] = recommendation("tbcCatsSwiftness", "PRIMARY", "physical / mobility", "Only a verified item-level-35+ target")
        else
            feetChoices[#feetChoices + 1] = recommendation("tbcBootsFortitude", "PRIMARY", "survival", "Only a verified item-level-35+ target")
        end
        feetChoices[#feetChoices + 1] = recommendation("bootsSpeed", "PRIMARY", "lower-item-level mobility boots", "Inherited Era enchant; no item-level-35 floor")
        feetChoices[#feetChoices + 1] = existingFeet[2] or existingFeet[1]
        setSlot(data, token, "FEET", feetChoices)

        local legChoices
        if healer[token] and physical[token] then
            legChoices = {
                recommendation("tbcGoldenSpellthread", "PRIMARY", "healing / spell hybrid"),
                recommendation("tbcNethercleft", "PRIMARY", "survival / physical hybrid"),
                recommendation("tbcNethercobra", "PRIMARY", "physical pressure"),
                recommendation("arcanumConstitution", "ALTERNATIVE", "already-soulbound or pre-enchant-ineligible legs"),
            }
        elseif healer[token] then
            legChoices = {
                recommendation("tbcGoldenSpellthread", "PRIMARY", "healing / survival"),
                recommendation("tbcNethercleft", "PRIMARY", "survival / hybrid"),
                recommendation("arcanumConstitution", "ALTERNATIVE", "targets not eligible for TBC leg armor"),
            }
        elseif physical[token] then
            legChoices = {
                recommendation("tbcNethercleft", "PRIMARY", "PvP survival"),
                recommendation("tbcNethercobra", "PRIMARY", "physical pressure"),
                recommendation("arcanumConstitution", "ALTERNATIVE", "targets not eligible for TBC leg armor"),
            }
        else
            legChoices = {
                recommendation("tbcRunicSpellthread", "PRIMARY", "spell pressure / survival"),
                recommendation("tbcGoldenSpellthread", "PRIMARY", "healing / survival"),
                recommendation("arcanumConstitution", "ALTERNATIVE", "targets not eligible for TBC spellthread"),
            }
        end
        setSlot(data, token, "LEGS", legChoices)

        -- Inferno Robe is an explicit level-19 high-item-level base in both
        -- caster gear audits. Other level-19 chest profiles keep the inherited
        -- enchants until an eligible target is documented for that class.
        if level == 19 and (token == "MAGE" or token == "WARLOCK") then
            setSlot(data, token, "CHEST", {
                recommendation("tbcExceptionalStats", "PRIMARY", "Inferno Robe balanced set", "Target item level 35+ only"),
                recommendation("tbcExceptionalHealth", "PRIMARY", "Inferno Robe survival set", "Target item level 35+ only"),
                recommendation("chestStats", "ALTERNATIVE", "lower-item-level chest"),
                recommendation("chestHealth", "ALTERNATIVE", "lower-item-level survival chest"),
            })
        end

        if level >= 29 then
            setSlot(data, token, "CHEST", {
                recommendation("tbcExceptionalStats", "PRIMARY", "eligible high-item-level chest"),
                recommendation("tbcExceptionalHealth", "PRIMARY", "eligible survival chest"),
                recommendation("chestStats", "ALTERNATIVE", "lower-item-level chest"),
                recommendation("chestHealth", "ALTERNATIVE", "lower-item-level survival chest"),
            })
            local currentBracers = profile.slots.WRISTS or {}
            local bracerChoices
            if healer[token] then
                if token == "PALADIN" or token == "SHAMAN" then
                    bracerChoices = {
                        recommendation("tbcBracerHealing", "PRIMARY", "eligible healing bracers"),
                        recommendation("tbcBracerSpellpower", "PRIMARY", "eligible caster bracers"),
                        recommendation("tbcBracerBrawn", "PRIMARY", "eligible melee bracers"),
                        recommendation("bracerStamina", "ALTERNATIVE", "lower-item-level survival bracers"),
                    }
                else
                    bracerChoices = {
                        recommendation("tbcBracerHealing", "PRIMARY", "eligible healing bracers"),
                        recommendation("tbcBracerFortitude", "PRIMARY", "eligible survival bracers"),
                        recommendation("tbcBracerSpellpower", "PRIMARY", "eligible caster bracers"),
                        currentBracers[1] or recommendation("bracerHealing", "ALTERNATIVE", "lower-item-level bracers"),
                    }
                end
            elseif token == "MAGE" or token == "WARLOCK" then
                bracerChoices = {
                    recommendation("tbcBracerSpellpower", "PRIMARY", "eligible caster bracers"),
                    recommendation("tbcBracerIntellect", "PRIMARY", "eligible mana bracers"),
                    recommendation("tbcBracerFortitude", "PRIMARY", "eligible survival bracers"),
                    currentBracers[1] or recommendation("bracerStamina", "ALTERNATIVE", "lower-item-level bracers"),
                }
            elseif token == "HUNTER" then
                bracerChoices = {
                    recommendation("tbcBracerFortitude", "PRIMARY", "eligible survival bracers"),
                    recommendation("tbcBracerIntellect", "PRIMARY", "eligible mana bracers"),
                    currentBracers[1] or recommendation("bracerStamina", "ALTERNATIVE", "lower-item-level bracers"),
                    currentBracers[2] or recommendation("bracerIntellect", "ALTERNATIVE", "lower-item-level bracers"),
                }
            else
                bracerChoices = {
                    recommendation("tbcBracerBrawn", "PRIMARY", "eligible Strength bracers"),
                    recommendation("tbcBracerFortitude", "PRIMARY", "eligible survival bracers"),
                    currentBracers[1] or recommendation("bracerStrength", "ALTERNATIVE", "lower-item-level bracers"),
                    currentBracers[2] or recommendation("bracerStamina", "ALTERNATIVE", "lower-item-level bracers"),
                }
            end
            setSlot(data, token, "WRISTS", bracerChoices)

            local currentHands = profile.slots.HANDS or {}
            local handChoices
            if healer[token] then
                handChoices = {
                    recommendation("tbcGlovesHealing", "PRIMARY", "eligible healing gloves"),
                    recommendation("tbcGlovesSpellpower", "PRIMARY", "eligible caster / hybrid gloves"),
                    physical[token] and recommendation("glovesAgility", "PRIMARY", "physical; inherited Era enchant without item-level floor") or (currentHands[1] or recommendation("glovesHealing", "ALTERNATIVE", "lower-item-level gloves")),
                    recommendation("glovesHealing", "ALTERNATIVE", "lower-item-level healing gloves"),
                }
            elseif token == "MAGE" or token == "WARLOCK" then
                handChoices = {
                    recommendation("tbcGlovesSpellpower", "PRIMARY", "eligible all-school caster gloves"),
                    currentHands[1] or recommendation("glovesShadow", "ALTERNATIVE", "lower-item-level school set"),
                    currentHands[2] or recommendation("glovesFire", "ALTERNATIVE", "lower-item-level school set"),
                }
            elseif token == "HUNTER" then
                handChoices = {
                    recommendation("glovesAgility", "PRIMARY", "Agility; inherited Era enchant without item-level floor"),
                    recommendation("tbcGlovesAssault", "ALTERNATIVE", "eligible raw attack-power gloves"),
                    currentHands[2] or recommendation("glovesAgilityBudget", "ALTERNATIVE", "lower-item-level budget gloves"),
                }
            else
                handChoices = {
                    recommendation("glovesAgility", "PRIMARY", "Agility; inherited Era enchant without item-level floor"),
                    recommendation("tbcGlovesStrength", "PRIMARY", "eligible Strength gloves"),
                    recommendation("tbcGlovesAssault", "ALTERNATIVE", "eligible raw attack-power gloves"),
                    currentHands[2] or recommendation("glovesStrength", "ALTERNATIVE", "lower-item-level gloves"),
                }
            end
            setSlot(data, token, "HANDS", handChoices)

            local currentBack = profile.slots.BACK or {}
            if physical[token] then
                setSlot(data, token, "BACK", {
                    recommendation("tbcCloakAgility", "PRIMARY", "eligible physical cloak"),
                    recommendation("tbcCloakArmor", "ALTERNATIVE", "eligible physical-survival cloak"),
                    currentBack[1] or recommendation("cloakDodge", "ALTERNATIVE", "lower-item-level cloak"),
                    currentBack[2] or recommendation("cloakResistance", "ALTERNATIVE", "anti-caster cloak"),
                })
            else
                setSlot(data, token, "BACK", {
                    recommendation("tbcCloakArmor", "PRIMARY", "eligible physical-survival cloak"),
                    currentBack[1] or recommendation("cloakDodge", "PRIMARY", "avoidance without item-level floor"),
                    currentBack[2] or recommendation("cloakResistance", "ALTERNATIVE", "anti-caster cloak"),
                })
            end

            if profile.slots.OFF_HAND and shieldUser[token] then
                setSlot(data, token, "OFF_HAND", {
                    recommendation("tbcShieldStamina", "PRIMARY", "eligible survival shield"),
                    recommendation("tbcShieldIntellect", "PRIMARY", "eligible caster / healer shield"),
                    recommendation("tbcShieldBlock", "ALTERNATIVE", "eligible block set"),
                    recommendation("shieldStamina", "ALTERNATIVE", "lower-item-level shield"),
                })
            end
        end
    end

    if level >= 29 then
        for _, token in ipairs(bracket.bis.classOrder) do
            local profile = data.classes[token]
            if profile.slots.ONE_HAND then
                if healer[token] and physical[token] then
                    setSlot(data, token, "ONE_HAND", {
                        recommendation("tbcMajorHealing", "PRIMARY", "eligible healing weapon"),
                        recommendation("tbcMajorSpellpower", "PRIMARY", "eligible caster / hybrid weapon"),
                        recommendation(token == "PALADIN" and "tbcPotency" or "tbcMongoose", "PRIMARY", "eligible physical weapon"),
                        recommendation("weaponHealing", "ALTERNATIVE", "lower-item-level healing weapon"),
                    })
                elseif healer[token] then
                    setSlot(data, token, "ONE_HAND", {
                        recommendation("tbcMajorHealing", "PRIMARY", "eligible healing weapon"),
                        recommendation("tbcMajorSpellpower", "PRIMARY", "eligible caster / hybrid weapon"),
                        recommendation("tbcMajorIntellect", "PRIMARY", "eligible mana weapon"),
                        recommendation("weaponHealing", "ALTERNATIVE", "lower-item-level healing weapon"),
                    })
                elseif token == "MAGE" or token == "WARLOCK" then
                    setSlot(data, token, "ONE_HAND", {
                        recommendation("tbcMajorSpellpower", "PRIMARY", "eligible caster weapon"),
                        recommendation("tbcMajorIntellect", "PRIMARY", "eligible mana weapon"),
                        recommendation("weaponSpell", "ALTERNATIVE", "lower-item-level caster weapon"),
                        recommendation("weaponIntellect", "ALTERNATIVE", "lower-item-level mana weapon"),
                    })
                else
                    setSlot(data, token, "ONE_HAND", {
                        recommendation("tbcMongoose", "PRIMARY", "eligible Agility / proc weapon"),
                        recommendation("tbcPotency", "PRIMARY", "eligible Strength weapon"),
                        recommendation("weaponAgility", "ALTERNATIVE", "lower-item-level weapon"),
                        recommendation("crusader", "ALTERNATIVE", "lower-item-level weapon"),
                    })
                end
            end
            if profile.slots.TWO_HAND then
                if healer[token] and physical[token] then
                    setSlot(data, token, "TWO_HAND", {
                        recommendation("tbcMajorHealing", "PRIMARY", "eligible healing weapon"),
                        recommendation("tbcMajorSpellpower", "PRIMARY", "eligible caster / hybrid weapon"),
                        recommendation("tbcMajorAgility2H", "PRIMARY", "eligible physical weapon"),
                        recommendation("weaponHealing", "ALTERNATIVE", "lower-item-level healing weapon"),
                    })
                elseif healer[token] then
                    setSlot(data, token, "TWO_HAND", {
                        recommendation("tbcMajorHealing", "PRIMARY", "eligible healing weapon"),
                        recommendation("tbcMajorSpellpower", "PRIMARY", "eligible caster / hybrid weapon"),
                        recommendation("tbcMajorIntellect", "PRIMARY", "eligible mana weapon"),
                        recommendation("weaponHealing", "ALTERNATIVE", "lower-item-level healing weapon"),
                    })
                elseif token == "MAGE" or token == "WARLOCK" then
                    setSlot(data, token, "TWO_HAND", {
                        recommendation("tbcMajorSpellpower", "PRIMARY", "eligible caster weapon"),
                        recommendation("tbcMajorIntellect", "PRIMARY", "eligible mana weapon"),
                        recommendation("weaponSpell", "ALTERNATIVE", "lower-item-level caster weapon"),
                        recommendation("weaponIntellect", "ALTERNATIVE", "lower-item-level mana weapon"),
                    })
                else
                    setSlot(data, token, "TWO_HAND", {
                        recommendation("tbcMajorAgility2H", "PRIMARY", "eligible Agility weapon"),
                        recommendation("tbcSavagery", "PRIMARY", "eligible attack-power weapon"),
                        recommendation("twoHandAgility", "ALTERNATIVE", "lower-item-level weapon"),
                        recommendation("crusader", "ALTERNATIVE", "lower-item-level weapon"),
                    })
                end
            end
        end
    end

    local consumables = bracket.consumables
    consumables.version = "2026-08-13-tbc"
    local statueID, statueName, statueEffect, statueProfession
    if level == 19 then
        statueID, statueName, statueEffect, statueProfession = 25881, "Heavy Stone Statue", "Places a statue that heals its Jewelcrafter for a short time", "Jewelcrafting 110; Bind on Pickup"
    elseif level == 29 then
        statueID, statueName, statueEffect, statueProfession = 25883, "Dense Stone Statue", "Places a statue that heals its Jewelcrafter for a short time", "Jewelcrafting 225; Bind on Pickup"
    else
        statueID, statueName, statueEffect, statueProfession = 25883, "Dense Stone Statue", "Places a statue that heals its Jewelcrafter for a short time", "Jewelcrafting 225; Bind on Pickup"
    end
    addConsumable(consumables, statueID, statueName, statueEffect, statueProfession, "TBC-only Jewelcrafting utility. Shares cooldowns with several conjured and Engineering tools; the statue can be attacked. Verify the exact live cooldown group.")
    if not consumables.categoryNames.JEWELCRAFTING then
        consumables.categoryNames.JEWELCRAFTING = "Jewelcrafting"
        table.insert(consumables.categoryOrder, #consumables.categoryOrder, "JEWELCRAFTING")
    end
    for _, token in ipairs(bracket.bis.classOrder) do
        local profile = consumables.classes[token]
        profile.categories.JEWELCRAFTING = profile.categories.JEWELCRAFTING or {}
        if not recommendationExists(profile.categories.JEWELCRAFTING, statueID) then
            profile.categories.JEWELCRAFTING[#profile.categories.JEWELCRAFTING + 1] = {
                itemID = statueID,
                priority = "CORE",
                roles = "TBC self-heal / distraction",
                note = "Requires the character to be the Jewelcrafter that made it",
            }
        end
        local present = false
        for _, category in ipairs(profile.categoryOrder) do
            if category == "JEWELCRAFTING" then present = true break end
        end
        if not present then table.insert(profile.categoryOrder, #profile.categoryOrder, "JEWELCRAFTING") end
    end

    if level == 19 then
        local warlockClass = consumables.classes.WARLOCK.categories.CLASS
        for _, entry in ipairs(warlockClass or {}) do
            if entry.itemID == 5232 then
                entry.roles = "TBC resurrection utility"
                entry.note = "Warlock-only Soulstone behavior; verify the current PvP restrictions"
            end
        end
        local soulstone = consumables.catalog[5232]
        if soulstone then soulstone.restrictions = "Warlock only; current TBC battleground and combat behavior needs live validation" end
    end
end
