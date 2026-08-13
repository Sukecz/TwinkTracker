local addonName, ns = ...

local item = ns.GuideHelpers.item
local line = ns.GuideHelpers.line
local step = ns.GuideHelpers.step

local function deepCopy(value)
    if type(value) ~= "table" then return value end
    local result = {}
    for key, entry in pairs(value) do result[deepCopy(key)] = deepCopy(entry) end
    return result
end

local firstAid = deepCopy(ns.GuidesData.sections.FIRST_AID)
for _, guideStep in ipairs(firstAid.steps) do
    for _, guideLine in ipairs(guideStep.lines) do
        guideLine.text = string.gsub(guideLine.text, "level%-19", "level-29")
        guideLine.text = string.gsub(guideLine.text, "level 19", "level 29")
    end
end
for _, guideItem in ipairs(firstAid.items) do
    guideItem.note = string.gsub(guideItem.note, "level%-19", "level-29")
    guideItem.note = string.gsub(guideItem.note, "level 19", "level 29")
end
for _, guideStep in ipairs(firstAid.steps) do
    if guideStep.title == "COMBAT USE" then
        table.insert(guideStep.lines, 4, line("THIRD CHOICE","Heavy Mageweave Bandage heals 1104 over 8 seconds and requires First Aid 175 to use; skill 240 to craft is above the level-29 cap.",{8545}))
    end
end
firstAid.items[#firstAid.items + 1] = item(8545,"Heavy Mageweave Bandage","Requires First Aid 175 to use; a level-29 character cannot reach its skill-240 craft recipe.")

ns.Bracket29GuidesData = {
    version = "2026-08-13",
    order = { "FIRST_AID", "FISHING", "ENGINEERING" },
    sections = {
        FIRST_AID = firstAid,
        FISHING = {
            name = "Fishing",
            tagline = "Reach the level-29 cap, prepare event rewards and remove future discovery-XP travel.",
            steps = {
                step("SHOPPING LIST TO 225",{
                    line("POLE","Buy 1x Fishing Pole; replace it with 1x limited-stock Strong Fishing Pole when available.",{6256,6365}),
                    line("LEVELING LURES","Buy at least 20x Shiny Bauble and replenish them if catches get away.",{6529}),
                    line("EXPERT BOOK","Buy Expert Fishing - The Bass and You before skill 125; it is BoE.",{16083}),
                    line("EVENT LURES","Stock several Aquadynamic Fish Attractors separately for the fishing event.",{6533}),
                    line("VARIABLE","Fishing has no fixed material total because only successful catches can grant skill."),
                }),
                step("TRAIN AND REACH 125",{
                    line("POLE","Buy a Fishing Pole; use a Strong Fishing Pole and lures when the water is above your raw skill.",{6256,6365,6529}),
                    line("1-75","Fish safe starting-zone or capital water; train Journeyman between skill 50 and 75."),
                    line("75-125","Stay in safe capital-city water. Harder zones do not improve the chance of a skill point."),
                    line("RULE","Only successful catches can increase Fishing; buy extra lures to reduce failed catches."),
                }),
                step("LEARN EXPERT AT LEVEL 20+",{
                    line("BOOK","Read Expert Fishing - The Bass and You at Fishing 125 to raise the cap to 225.",{16083}),
                    line("VENDOR","Old Man Heming, Happy Bobber shop on the lower Booty Bay boardwalk at (27.4, 77.1)."),
                    line("ALTERNATIVE","The book is BoE: mail it from another character or buy it from the Auction House."),
                    line("XP SAFETY","Explore Booty Bay and the Stranglethorn approach before the final level if the character will buy it personally."),
                }),
                step("SKILL 125-175",{
                    line("WHERE","Continue in safe capital water; zone difficulty affects catches, not skill-up speed."),
                    line("CATCHES","Plan roughly 150-200 successful catches as gains slow through this segment."),
                    line("COOKING","Keep Raw Bristle Whisker Catfish if Cooking will also be raised.",{6308}),
                }),
                step("SKILL 175-225",{
                    line("WHERE","Use safe city water and keep an appropriate lure active."),
                    line("CATCHES","Plan roughly 250-350 successful catches; skill gains become progressively slower."),
                    line("CAP","Stop at 225. Artisan Fishing and the 300 cap require character level 35, so they are unavailable at level 29."),
                }),
                step("PREPARE THE FISHING EVENT",{
                    line("LURE","Stock Aquadynamic Fish Attractors; Fishing 225 plus the lure is sufficient for the Stranglethorn coast.",{6533}),
                    line("ROUTE","Reveal the coast, Booty Bay and safe graveyard routes before reaching 29."),
                    line("SAFETY","The event coast is contested. Use an escort on Era and treat it as exceptionally dangerous on Hardcore."),
                }),
                step("RARE-FISH REWARDS",{
                    line("HAT","Keefer's Angelfish is exchanged at Fishbot 5000 for Lucky Fishing Hat.",{19805,19972}),
                    line("BOOTS","Brownell's Blue Striped Racer is exchanged for Nat Pagle's Extreme Anglin' Boots.",{19803,19969}),
                    line("CHECK","Tournament schedule and current Era availability must still be confirmed live before travel."),
                }),
            },
            items = {
                item(6256,"Fishing Pole","Basic vendor pole required to cast Fishing."),
                item(6365,"Strong Fishing Pole","Limited-stock pole with +5 Fishing."),
                item(6529,"Shiny Bauble","Vendor lure; +25 Fishing for 10 minutes."),
                item(16083,"Expert Fishing - The Bass and You","Requires level 20 and Fishing 125; raises the cap to 225."),
                item(6308,"Raw Bristle Whisker Catfish","Useful catch while combining Fishing with Cooking."),
                item(6533,"Aquadynamic Fish Attractor","Requires Fishing 100; +100 Fishing for 5 minutes."),
                item(19805,"Keefer's Angelfish","Rare tournament fish exchanged at Fishbot 5000."),
                item(19972,"Lucky Fishing Hat","Universal +15 Stamina twink helm reward."),
                item(19803,"Brownell's Blue Striped Racer","Rare tournament fish exchanged at Fishbot 5000."),
                item(19969,"Nat Pagle's Extreme Anglin' Boots","Universal +12 Stamina twink boots reward."),
            },
        },
        ENGINEERING = {
            name = "Engineering",
            tagline = "Level-29 characters can reach 225, unlocking stronger generic explosives, goggles and utility.",
            steps = {
                step("SHOPPING LIST 1-150",{
                    line("COPPER","60x Rough Stone, 66x Copper Bar and 50x Linen Cloth.",{2835,2840,2589}),
                    line("COARSE","60x Coarse Stone and 5x Silver Bar.",{2836,2842}),
                    line("BRONZE","80x Bronze Bar, 25x Weak Flux and 10x Moss Agate.",{2841,2880,1206}),
                    line("FINISH","30x Heavy Stone and 15x Wool Cloth.",{2838,2592}),
                    line("BUFFER","Buy 10-20% extra for yellow and green skill-up variance."),
                }),
                step("REACH 150",{
                    line("ROUTE","Follow the bracket-19 1-150 route: powder, bolts, bombs, tubes, scopes and saved components."),
                    line("KEEP","Retain Heavy Blasting Powder, Whirring Bronze Gizmos and an Arclight Spanner for later crafts.",{4377,4375,6219}),
                    line("EXPERT","At character level 20 and Engineering 125, train Expert to raise the cap to 225."),
                    line("TRAINERS","Alliance: Springspindle Fizzlegear in Ironforge. Horde: Roxxik in Orgrimmar."),
                }),
                step("SHOPPING LIST 150-225",{
                    line("BRONZE","About 30x Bronze Bar, 15x Medium Leather and 45x Wool Cloth for frameworks and sheep.",{2841,2319,2592}),
                    line("STEEL","4x Steel Bar for one Gyromatic Micro-Adjustor.",{3859,10498}),
                    line("STONE","About 120x Solid Stone for Solid Blasting Powder.",{7912,10505}),
                    line("MITHRIL","About 75-90x Mithril Bar and 20x Mageweave Cloth for tubes, triggers and casings.",{3860,4338}),
                    line("BUFFER","These are planning amounts. Yellow recipes can require extra crafts."),
                }),
                step("SKILL 150-175",{
                    line("150-160","Craft about 15x Bronze Framework; keep them.",{4382,2841,2319,2592}),
                    line("160-175","Craft about 15x Explosive Sheep using the saved frameworks, gizmos and Heavy Blasting Powder.",{4384,4382,4375,4377,2592}),
                }),
                step("SKILL 175-200",{
                    line("175-176","Craft 1x Gyromatic Micro-Adjustor and keep it as an Engineering tool.",{10498,3859}),
                    line("176-195","Craft about 60x Solid Blasting Powder from 120x Solid Stone; keep the powder.",{10505,7912}),
                    line("195-200","Craft about 7x Mithril Tube from roughly 21x Mithril Bar.",{10559,3860}),
                }),
                step("SKILL 200-225",{
                    line("200-215","Craft about 20x Unstable Trigger using Mithril, Mageweave and saved Solid Blasting Powder.",{10560,3860,4338,10505}),
                    line("215-225","Craft Mithril Casings until 225; plan 10-15 crafts and extra Mithril for yellow skill variance.",{10561,3860}),
                    line("CAP","Stop at 225. Artisan Engineering requires level 35."),
                    line("SPECIALIZATION","Goblin and Gnomish Engineering initiation requires level 30. A level-29 character cannot craft BoP specialization gear."),
                }),
                step("LEVEL-29 PAYOFF",{
                    line("GOGGLES","Spellpower Goggles Xtreme require Engineering 215 and support caster pressure.",{10502}),
                    line("CLOAK","Parachute Cloak requires Engineering 225 and provides agility plus controlled fall utility.",{10518}),
                    line("CLOAKING","Gnomish Cloaking Device is a generic Engineering 200 utility item despite its name.",{4397}),
                    line("SPECIALTY BOE","A level-29 character cannot specialize, but can buy and use tradeable specialist gadgets whose exact use requirement is 225 or lower, including Net-o-Matic and Goblin Sapper Charge.",{10720,10646}),
                }),
                step("EXPLOSIVES AND ESCAPE",{
                    line("GRENADE","Iron Grenade provides ranged damage and a short stun at Engineering 175.",{4390}),
                    line("BOMB","Big Iron Bomb is the stronger Engineering 190 stun explosive.",{4394}),
                    line("DUMMY","Advanced Target Dummy is the level-29 emergency distraction upgrade.",{4392}),
                    line("COOLDOWN","Explosives share a cooldown; choose the correct control tool instead of planning a chain."),
                }),
                step("DO NOT PLAN ABOVE THE CAP",{
                    line("NO ARTISAN","Deepdive Helmet, Green Lens and every recipe above Engineering 225 are unavailable to the level-29 character."),
                    line("NO SPECIALTY","Goblin Mining Helmet, Gnomish Goggles and other BoP specialization crafts cannot be made before level 30."),
                    line("TRANSFER","Tradeable engineering items without an Engineering-use requirement may come from another crafter, but verify the exact item before relying on it."),
                }),
            },
            items = {
                item(2835,"Rough Stone","Buy 60x for Rough Blasting Powder."),
                item(2840,"Copper Bar","Buy 66x for bolts, the spanner and Rough Copper Bombs."),
                item(2589,"Linen Cloth","Buy 50x for Rough Copper Bombs and Coarse Dynamite."),
                item(2836,"Coarse Stone","Buy 60x for Coarse Blasting Powder."),
                item(2842,"Silver Bar","Buy 5x for Silver Contacts."),
                item(2880,"Weak Flux","Buy 25x from an Engineering Supplies vendor."),
                item(1206,"Moss Agate","Buy 10x for Standard Scopes."),
                item(2838,"Heavy Stone","Buy 30x for Heavy Blasting Powder."),
                item(4377,"Heavy Blasting Powder","Saved input from the 135-145 route."),
                item(4375,"Whirring Bronze Gizmo","Saved component for Explosive Sheep."),
                item(6219,"Arclight Spanner","Engineering tool retained from the early route."),
                item(2841,"Bronze Bar","Material for Bronze Frameworks."),
                item(2319,"Medium Leather","Material for Bronze Frameworks."),
                item(2592,"Wool Cloth","Material for frameworks and Explosive Sheep."),
                item(4382,"Bronze Framework","Crafted and consumed during the 150-175 route."),
                item(4384,"Explosive Sheep","Engineering 150 burst utility and leveling craft."),
                item(3859,"Steel Bar","Material for the Gyromatic Micro-Adjustor."),
                item(10498,"Gyromatic Micro-Adjustor","Engineering tool crafted at 175."),
                item(7912,"Solid Stone","Material for Solid Blasting Powder."),
                item(10505,"Solid Blasting Powder","Saved component for Expert Engineering crafts."),
                item(3860,"Mithril Bar","Main material for the 195-225 segment."),
                item(4338,"Mageweave Cloth","Material for Unstable Triggers."),
                item(10559,"Mithril Tube","Leveling craft for the 195-200 segment."),
                item(10560,"Unstable Trigger","Leveling craft and later Engineering component."),
                item(10561,"Mithril Casing","Leveling craft used to reach 225."),
                item(10502,"Spellpower Goggles Xtreme","Requires Engineering 215; generic caster goggles."),
                item(10518,"Parachute Cloak","Requires Engineering 225; agility and fall utility."),
                item(4397,"Gnomish Cloaking Device","Requires Engineering 200; not a specialization craft."),
                item(10720,"Gnomish Net-o-Matic Projector","BoE specialist craft; requires Engineering 210 to use and can backfire."),
                item(10646,"Goblin Sapper Charge","BoE specialist craft; requires Engineering 205 to use and causes self-damage."),
                item(4390,"Iron Grenade","Engineering 175 stun explosive."),
                item(4394,"Big Iron Bomb","Engineering 190 stun explosive."),
                item(4392,"Advanced Target Dummy","Engineering 185 emergency utility."),
            },
        },
    },
}
