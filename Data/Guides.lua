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
                    line("1-40","Craft Linen Bandage.",{1251}),
                    line("40-80","Train and craft Heavy Linen Bandage. Train Journeyman at skill 50.",{2581}),
                    line("80-115","Train and craft Wool Bandage.",{3530}),
                    line("115-125","Train Heavy Wool Bandage and craft it until the Expert book can be read.",{3531}),
                }),
                step("MATERIAL RESERVE",{
                    line("LINEN","160-180 Linen Cloth",{2589}),
                    line("WOOL","200-240 Wool Cloth",{2592}),
                    line("SILK","140-160 Silk Cloth",{4306}),
                    line("MAGEWEAVE","At least 20 Mageweave Cloth",{4338}),
                    line("ALLOWANCE","Yellow and green recipes may require extra cloth; these are planning ranges, not guarantees."),
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
                    line("125-150","Read Under Wraps, then continue crafting Heavy Wool Bandage.",{16084,3531}),
                    line("150-180","Train and craft Silk Bandage.",{6450}),
                    line("180-210","Read the Heavy Silk manual, then craft Heavy Silk Bandage.",{16112,6451}),
                    line("210-225","Read the Mageweave manual, then craft Mageweave Bandage.",{16113,8544}),
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
                step("TRAIN TO 150",{
                    line("LOCATION","Level Fishing in a safe capital-city area."),
                    line("POLE","Buy a limited-stock Strong Fishing Pole from a fishing-supplies vendor when available.",{6365}),
                    line("TARGET","Reach Fishing 150 before traveling to Stranglethorn Vale."),
                }),
                step("PREPARE FOR SUNDAY",{
                    line("LURE","Stock Aquadynamic Fish Attractors and apply one to the pole.",{6533}),
                    line("SKILL","Fishing 150 plus the +100 lure is sufficient for the Stranglethorn coast.",{6365,6533}),
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
                item(6365,"Strong Fishing Pole","Limited-stock fishing-supplies item; +5 Fishing."),
                item(6533,"Aquadynamic Fish Attractor","Requires Fishing 100; +100 Fishing for 5 minutes."),
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
                step("SOURCE MATERIALS",{
                    line("SELF-SUPPLY","Pair Engineering with Mining while leveling if you want a cheaper material route."),
                    line("FAST ROUTE","Buy prepared bars and parts from the Auction House or send them from a main character."),
                }),
                step("RAISE TO 150",{
                    line("TARGET","Reach Engineering 150 and keep the profession learned."),
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
