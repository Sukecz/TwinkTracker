local addonName, ns = ...

local WOWHEAD_CLASSIC_ITEM_URL = "https://www.wowhead.com/classic/item="

local function item(id, name, note)
    return { id=id, name=name, note=note, wowhead=WOWHEAD_CLASSIC_ITEM_URL..id }
end

local function line(label, text, itemIDs)
    return { label=label, text=text, itemIDs=itemIDs or {} }
end

local function step(title, lines)
    return { title=title, lines=lines }
end

ns.GuidesData = {
    version = "2026-08-09",
    order = { "FIRST_AID", "FISHING", "ENGINEERING" },
    sections = {
        FIRST_AID = {
            name = "First Aid",
            tagline = "Universal combat recovery without spending a primary profession slot.",
            steps = {
                step("TRAINERS",{
                    line("|cff5ca9ffA|r  ALLIANCE","Stormwind: Shaina Fuller (42.8, 26.6)  •  Ironforge: Nissa Firestone (54.8, 58.6)  •  Darnassus: Dannelor (51.6, 12.6)"),
                    line("|cffff505cH|r  HORDE","Orgrimmar: Arnok (34.0, 84.4)  •  Undercity: Mary Edras (73.6, 55.6)  •  Thunder Bluff: Pand Stonebinder (29.6, 21.4)"),
                }),
                step("LEVEL 1-125",{
                    line("1-40","Craft about 40 Linen Bandages (40 Linen Cloth).",{1251,2589}),
                    line("40-80","Craft about 40 Heavy Linen Bandages (80 Linen Cloth); train Journeyman at skill 50.",{2581,2589}),
                    line("80-115","Craft about 35 Wool Bandages (35 Wool Cloth).",{3530,2592}),
                    line("115-125","Craft about 10 Heavy Wool Bandages (20 Wool Cloth), then read the Expert book.",{3531,2592}),
                }),
                step("SHOPPING LIST TO 225",{
                    line("LINEN","160-180 Linen Cloth",{2589}),
                    line("WOOL","200-240 Wool Cloth",{2592}),
                    line("SILK","140-160 Silk Cloth",{4306}),
                    line("MAGEWEAVE","20 Mageweave Cloth",{4338}),
                    line("BOOKS","Buy all three BoE books before starting the 125-225 segment.",{16084,16112,16113}),
                    line("ALLOWANCE","The cloth totals are conservative Wowhead planning ranges because yellow and green recipes do not guarantee a skill point."),
                }),
                step("BOOKS AT SKILL 125",{
                    line("EXPERT","Read Expert First Aid - Under Wraps at 125 to raise the skill cap to 225.",{16084}),
                    line("SKILL 180","Read Manual: Heavy Silk Bandage.",{16112}),
                    line("SKILL 210","Read Manual: Mageweave Bandage.",{16113}),
                    line("ALTERNATIVE","All three books are BoE: mail them from a main or buy them from the Auction House.",{16084,16112,16113}),
                }),
                step("|cff5ca9ffA|r  ALLIANCE BOOK VENDOR",{
                    line("WHO","Deneb Walker"),
                    line("WHERE","Stromgarde Keep, Arathi Highlands — beside the chapel and well at (27.2, 58.8)."),
                    line("SAFE ROUTE","Use an escort, or enter through the northwest wall breach near (23.2, 55.8) to avoid hostile elites."),
                }),
                step("|cffff505cH|r  HORDE BOOK VENDOR",{
                    line("WHO","Balai Lok'Wein"),
                    line("WHERE","Brackenwall Village, Dustwallow Marsh — between the north-side caravans at (36.4, 30.4)."),
                    line("TRAVEL","Use an escort for the first low-level trip and collect the Brackenwall flight path before leaving."),
                }),
                step("LEVEL 125-225",{
                    line("125-150","Read Under Wraps, then craft about 25 Heavy Wool Bandages (50 Wool Cloth).",{16084,3531,2592}),
                    line("150-180","Train Silk Bandage and craft about 30 (30 Silk Cloth).",{6450,4306}),
                    line("180-210","Read the Heavy Silk manual and craft about 30 Heavy Silk Bandages (60 Silk Cloth).",{16112,6451,4306}),
                    line("210-225","Read the Mageweave manual and craft about 15 Mageweave Bandages (15 Mageweave Cloth).",{16113,8544,4338}),
                    line("CAP","Stop at 225; Artisan First Aid requires level 35, but level 19 can legally reach this cap."),
                }),
                step("COMBAT USE",{
                    line("BEST","Mageweave Bandage is the strongest bandage retained by the current level-19 audit.",{8544}),
                    line("FALLBACK","Heavy Silk Bandage is the cheaper option.",{6451}),
                    line("ANTI-VENOM","The rare world-drop manual is usually sourced from the AH; one Large Venom Sac creates three Strong Anti-Venom.",{6454,1288,6453}),
                    line("CAUTION","Damage interrupts bandaging and applies Recently Bandaged for 60 seconds."),
                    line("LIVE TEST","Historical guides recommend Heavy Runecloth at 225; it remains excluded pending a clean live Era level-19 use test."),
                }),
            },
            items = {
                item(16084,"Expert First Aid - Under Wraps","Read at First Aid 125 to raise the cap to 225."),
                item(16112,"Manual: Heavy Silk Bandage","Read at First Aid 180."),
                item(16113,"Manual: Mageweave Bandage","Read at First Aid 210."),
                item(2589,"Linen Cloth","Material for Linen and Heavy Linen Bandages."),
                item(2592,"Wool Cloth","Material for Wool and Heavy Wool Bandages."),
                item(4306,"Silk Cloth","Material for Silk and Heavy Silk Bandages."),
                item(4338,"Mageweave Cloth","Material for Mageweave Bandages."),
                item(1251,"Linen Bandage","Craft from First Aid 1."),
                item(2581,"Heavy Linen Bandage","Train at First Aid 40."),
                item(3530,"Wool Bandage","Train at First Aid 80."),
                item(3531,"Heavy Wool Bandage","Train at First Aid 115."),
                item(6450,"Silk Bandage","Train at First Aid 150 after learning Expert."),
                item(6451,"Heavy Silk Bandage","Learn from its manual at First Aid 180; use requires 125."),
                item(8544,"Mageweave Bandage","Learn from its manual at First Aid 210; use requires 150."),
                item(6454,"Manual: Strong Anti-Venom","Rare world drop; read at First Aid 130."),
                item(1288,"Large Venom Sac","One sac creates three Strong Anti-Venom."),
                item(6453,"Strong Anti-Venom","Situational poison removal made from Large Venom Sacs."),
            },
        },
        FISHING = {
            name = "Fishing",
            tagline = "The long-term route to the universal stamina hat and boots.",
            steps = {
                step("BUY AND TRAIN",{
                    line("POLE","Buy a Fishing Pole; upgrade to the limited-stock Strong Fishing Pole when available.",{6256,6365}),
                    line("LURES","Buy a stack of Shiny Baubles for fewer failed catches while leveling.",{6529}),
                    line("TRAIN","Learn Apprentice Fishing now and Journeyman between skill 50 and 75."),
                    line("LEVEL 19 CAP","Stop at 150: Expert Fishing and its 225 cap require character level 20."),
                }),
                step("SKILL 1-75",{
                    line("WHERE","Use safe starting-zone water; avoid Tirisfal if possible because its Sickly Looking Fish have little value."),
                    line("CATCH","Plan roughly 75 successful catches; failed catches never grant skill."),
                    line("INLAND","Raw Brilliant Smallfish is the useful inland catch.",{6291}),
                    line("COAST","Raw Slitherskin Mackerel is the equivalent coastal catch.",{6303}),
                }),
                step("SKILL 75-100",{
                    line("WHERE","Move to safe water inside a major faction city and train Journeyman if not already done."),
                    line("CATCH","Catch until skill 100; plan roughly 25-50 successful catches for this segment."),
                    line("LOOT","Expect Brilliant Smallfish, Longjaw Mud Snapper and Bristle Whisker Catfish.",{6291,6289,6308}),
                }),
                step("SKILL 100-125",{
                    line("WHERE","Stay in the same safe capital-city water; harder zones do not speed up skill gains."),
                    line("CATCH","Plan roughly 50-75 successful catches as gains slow to about 2-3 catches per point."),
                    line("LURE","Keep a lure active to reduce failed catches; only successful catches can raise skill.",{6529}),
                }),
                step("SKILL 125-150",{
                    line("WHERE","Continue in safe city water rather than risking exploration XP or hostile travel."),
                    line("CATCH","Plan roughly 75-100 successful catches as gains slow to about 3-4 catches per point."),
                    line("TARGET","Finish at the level-19 cap of 150 before traveling to Stranglethorn Vale."),
                }),
                step("PREPARE FOR SUNDAY",{
                    line("LURE","Stock Aquadynamic Fish Attractors and apply one to the pole.",{6533}),
                    line("SKILL","Fishing 150 plus the +100 lure and Strong Fishing Pole gives 255 effective skill for the Stranglethorn coast.",{6365,6533}),
                    line("SAFETY","Finish exploration first and bring escorts or a protected shoreline route."),
                }),
                step("FISH THE EVENT",{
                    line("TARGET","Fish only Pools of Tastyfish while the Sunday event pools are active."),
                    line("HAT FISH","Keefer's Angelfish is the rare turn-in for Lucky Fishing Hat.",{19805,19972}),
                    line("BOOTS FISH","Brownell's Blue Striped Racer is the rare turn-in for Nat Pagle's boots.",{19803,19969}),
                }),
                step("TURN IN RARE FISH",{
                    line("NPC","Take either rare fish to Fishbot 5000 in Booty Bay."),
                    line("HAT","Keefer's Angelfish rewards Lucky Fishing Hat.",{19805,19972}),
                    line("BOOTS","Brownell's Blue Striped Racer rewards Nat Pagle's Extreme Anglin' Boots.",{19803,19969}),
                }),
            },
            items = {
                item(6256,"Fishing Pole","Basic vendor pole required to cast Fishing."),
                item(6365,"Strong Fishing Pole","Limited-stock fishing-supplies item; +5 Fishing."),
                item(6529,"Shiny Bauble","Vendor lure; +25 Fishing for 10 minutes."),
                item(6533,"Aquadynamic Fish Attractor","Requires Fishing 100; +100 Fishing for 5 minutes."),
                item(6291,"Raw Brilliant Smallfish","Common inland starting-zone and capital-city catch."),
                item(6303,"Raw Slitherskin Mackerel","Common coastal starting-zone catch."),
                item(6289,"Raw Longjaw Mud Snapper","Common capital-city catch while leveling 75-150."),
                item(6308,"Raw Bristle Whisker Catfish","Useful capital-city catch while leveling 75-150."),
                item(19805,"Keefer's Angelfish","Rare tournament fish exchanged at Fishbot 5000."),
                item(19972,"Lucky Fishing Hat","Universal +15 Stamina twink helm reward."),
                item(19803,"Brownell's Blue Striped Racer","Rare tournament fish exchanged at Fishbot 5000."),
                item(19969,"Nat Pagle's Extreme Anglin' Boots","Universal +12 Stamina twink boots reward."),
            },
        },
        ENGINEERING = {
            name = "Engineering",
            tagline = "The only primary profession with a broad direct level-19 combat toolkit.",
            steps = {
                step("SHOPPING LIST TO 150",{
                    line("COPPER","60 Rough Stone, 66 Copper Bar and 50 Linen Cloth.",{2835,2840,2589}),
                    line("COARSE","60 Coarse Stone and 5 Silver Bar.",{2836,2842}),
                    line("BRONZE","60 Bronze Bar, 25 Weak Flux and 10 Moss Agate.",{2841,2880,1206}),
                    line("FINISH","30 Heavy Stone and 5 Wool Cloth.",{2838,2592}),
                    line("BUFFER","These are level-19 minimums derived from the Wowhead route; buy 10-20% extra for yellow/green skill variance."),
                }),
                step("SKILL 1-75",{
                    line("1-30","Craft about 60 Rough Blasting Powder from 60 Rough Stone; keep all powder.",{4357,2835}),
                    line("30-50","Craft about 30 Handfuls of Copper Bolts from 30 Copper Bar; keep all bolts.",{4359,2840}),
                    line("50-51","Craft one Arclight Spanner from 6 Copper Bar and keep it in your bags.",{6219,2840}),
                    line("51-75","Craft about 30 Rough Copper Bombs using 30 Copper Bar, the saved bolts and powder, and 30 Linen Cloth.",{4360,2840,2589}),
                    line("TRAIN","Learn Journeyman Engineering between skill 50 and 75; it requires character level 10."),
                }),
                step("SKILL 75-105",{
                    line("75-90","Craft about 60 Coarse Blasting Powder from 60 Coarse Stone; keep it.",{4364,2836}),
                    line("90-100","Craft about 20 Coarse Dynamite using 60 saved powder and 20 Linen Cloth.",{4365,4364,2589}),
                    line("100-105","Craft 5 Silver Contacts from 5 Silver Bar.",{4404,2842}),
                }),
                step("SKILL 105-135",{
                    line("105-125","Craft about 25 Bronze Tubes from 50 Bronze Bar and 25 Weak Flux; keep at least 10.",{4371,2841,2880}),
                    line("125-135","Craft about 10 Standard Scopes from 10 saved Bronze Tubes and 10 Moss Agate.",{4406,4371,1206}),
                }),
                step("SKILL 135-150",{
                    line("135-145","Craft about 30 Heavy Blasting Powder from 30 Heavy Stone.",{4377,2838}),
                    line("145-150","Craft about 5 Whirring Bronze Gizmos from 10 Bronze Bar and 5 Wool Cloth.",{4375,2841,2592}),
                    line("CAP","Stop at 150: Expert Engineering and any further skill gains require character level 20."),
                }),
                step("LEVEL-19 PAYOFF",{
                    line("TARGET","Reach Engineering 150 and keep the profession learned; crafted utility requires the profession to use."),
                    line("HELM","Green Tinted Goggles require Engineering 150 and are the dependable helm before Fishing Tournament rewards.",{4385}),
                }),
                step("CORE EXPLOSIVES",{
                    line("CONTROL","Big Bronze Bomb provides ranged damage and a short stun.",{4380}),
                    line("DAMAGE","Heavy Dynamite provides stronger area damage without a stun.",{4378}),
                    line("COOLDOWN","Both use the shared explosives cooldown; choose one for the situation rather than trying to chain them."),
                }),
                step("UTILITY TOOLS",{
                    line("RECOMBOBULATOR","Temporary trinket and friendly Polymorph answer.",{4381}),
                    line("SHEEP","Optional burst pressure.",{4384}),
                    line("TARGET DUMMY","Open-world or Hardcore escape tool; it does not taunt players.",{4366}),
                }),
            },
            items = {
                item(2835,"Rough Stone","Buy 60 for the 1-30 Engineering segment."),
                item(2840,"Copper Bar","Buy 66 for bolts, the spanner and Rough Copper Bombs."),
                item(2589,"Linen Cloth","Buy 50 for Rough Copper Bombs and Coarse Dynamite."),
                item(2836,"Coarse Stone","Buy 60 for Coarse Blasting Powder."),
                item(2842,"Silver Bar","Buy 5 for Silver Contacts."),
                item(2841,"Bronze Bar","Buy 60 for Bronze Tubes and the final Whirring Bronze Gizmos."),
                item(2880,"Weak Flux","Buy 25 from an Engineering Supplies vendor for Bronze Tubes."),
                item(1206,"Moss Agate","Buy 10 for Standard Scopes."),
                item(2838,"Heavy Stone","Buy 30 for Heavy Blasting Powder."),
                item(2592,"Wool Cloth","Buy at least 5 for the final Whirring Bronze Gizmos."),
                item(4357,"Rough Blasting Powder","Craft about 60 at skill 1-30 and save it."),
                item(4359,"Handful of Copper Bolts","Craft about 30 at skill 30-50 and save them."),
                item(6219,"Arclight Spanner","Craft one at skill 50 and keep it as an Engineering tool."),
                item(4360,"Rough Copper Bomb","Craft about 30 at skill 51-75."),
                item(4364,"Coarse Blasting Powder","Craft about 60 at skill 75-90 and save it."),
                item(4365,"Coarse Dynamite","Craft about 20 at skill 90-100."),
                item(4404,"Silver Contact","Craft 5 at skill 100-105."),
                item(4371,"Bronze Tube","Craft about 25 at skill 105-125."),
                item(4406,"Standard Scope","Craft about 10 at skill 125-135."),
                item(4377,"Heavy Blasting Powder","Craft about 30 at skill 135-145."),
                item(4375,"Whirring Bronze Gizmo","Craft about 5 at skill 145-150."),
                item(4385,"Green Tinted Goggles","Engineering 150; interim stamina helm."),
                item(4380,"Big Bronze Bomb","Engineering 140; ranged damage and short stun."),
                item(4378,"Heavy Dynamite","Engineering 125; strong area damage without a stun."),
                item(4381,"Minor Recombobulator","Engineering 140; trinket with 10 charges."),
                item(4384,"Explosive Sheep","Engineering 150; optional burst tool."),
                item(4366,"Target Dummy","Engineering 85; PvE distraction and escape tool."),
            },
        },
    },
}
