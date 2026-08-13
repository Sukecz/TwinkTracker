local addonName, ns = ...

local item = ns.GuideHelpers.item
local line = ns.GuideHelpers.line
local step = ns.GuideHelpers.step

ns.Bracket39GuidesData = {
    version = "2026-08-13",
    order = { "FIRST_AID", "FISHING", "ENGINEERING" },
    sections = {
        FIRST_AID = {
            name = "First Aid",
            tagline = "Reach Artisan 300 at level 35 and self-craft the strongest Classic bandage.",
            steps = {
                step("REACH EXPERT 225",{
                    line("1-125","Use Linen and Wool Bandages, then read Expert First Aid - Under Wraps at skill 125.",{2589,2592,16084}),
                    line("125-180","Craft Heavy Wool and Silk Bandages; read the Heavy Silk manual at 180.",{3531,6450,16112}),
                    line("180-225","Craft Heavy Silk, read the Mageweave manual at 210 and finish with Mageweave Bandages.",{6451,16113,8544}),
                    line("BOOKS","Alliance buys the three BoE books from Deneb Walker in Stromgarde; Horde uses Balai Lok'Wein in Brackenwall."),
                }),
                step("UNLOCK ARTISAN AT LEVEL 35",{
                    line("REQUIREMENT","Reach character level 35 and First Aid 225 before the faction Triage quest."),
                    line("ALLIANCE","Doctor Gustaf VanHowzen at Theramore (67.6, 48.8)."),
                    line("HORDE","Doctor Gregory Victor at Hammerfall (73.4, 36.8)."),
                    line("TRIAGE","Save 15 patients before 6 die; prioritize Critically Injured, then Badly Injured, then Injured."),
                    line("XP SAFETY","The quest and travel award XP. Complete them with a planned buffer before the final level."),
                }),
                step("SKILL 225-300",{
                    line("225-240","Craft about 15 Mageweave Bandages.",{8544,4338}),
                    line("240-260","Train and craft about 20 Heavy Mageweave Bandages.",{8545,4338}),
                    line("260-290","Train and craft about 30 Runecloth Bandages.",{14529,14047}),
                    line("290-300","Train and craft about 10 Heavy Runecloth Bandages.",{14530,14047}),
                    line("BUFFER","Plan 80-100 Mageweave Cloth and 80-100 Runecloth for skill-up variance.",{4338,14047}),
                }),
                step("COMBAT USE",{
                    line("BEST","Heavy Runecloth Bandage heals 2000 over 8 seconds and is now self-craftable.",{14530}),
                    line("FALLBACK","Runecloth Bandage is the cheaper 1360-heal fallback.",{14529}),
                    line("ANTI-VENOM","Strong Anti-Venom is a situational poison cleanse made from Large Venom Sacs.",{6453,1288}),
                    line("CAUTION","Damage interrupts bandaging and applies Recently Bandaged for 60 seconds."),
                }),
            },
            items = {
                item(16084,"Expert First Aid - Under Wraps","BoE book used at First Aid 125."),
                item(16112,"Manual: Heavy Silk Bandage","BoE book used at First Aid 180."),
                item(16113,"Manual: Mageweave Bandage","BoE book used at First Aid 210."),
                item(2589,"Linen Cloth","Early First Aid material."),
                item(2592,"Wool Cloth","Early First Aid material."),
                item(3531,"Heavy Wool Bandage","Leveling craft for the Expert transition."),
                item(6450,"Silk Bandage","Expert leveling bandage."),
                item(6451,"Heavy Silk Bandage","Expert leveling and combat bandage."),
                item(4338,"Mageweave Cloth","Material through Artisan skill 260."),
                item(8544,"Mageweave Bandage","Expert bandage and 225-240 leveling craft."),
                item(8545,"Heavy Mageweave Bandage","Artisan 240-260 leveling craft."),
                item(14047,"Runecloth","Material for the final Artisan segment."),
                item(14529,"Runecloth Bandage","Artisan bandage trained at skill 260."),
                item(14530,"Heavy Runecloth Bandage","Strongest Classic bandage; trained at skill 290."),
                item(1288,"Large Venom Sac","Material for Strong Anti-Venom."),
                item(6453,"Strong Anti-Venom","Situational poison removal."),
            },
        },
        FISHING = {
            name = "Fishing",
            tagline = "Complete the dangerous Artisan quest at level 35 and reach the 300 cap before level 39.",
            steps = {
                step("SKILL 1-225",{
                    line("1-150","Fish safe capital water, train Journeyman and use lures to reduce failed catches.",{6256,6365,6529}),
                    line("EXPERT","At level 20 and Fishing 125, read Expert Fishing - The Bass and You.",{16083}),
                    line("125-225","Continue in safe water; harder zones do not improve the chance of a skill point."),
                    line("BUFFER","Expect several hundred successful catches and carry extra lures."),
                }),
                step("NAT PAGLE ARTISAN QUEST",{
                    line("REQUIREMENT","Reach level 35 and raw Fishing 225, then visit Nat Pagle southwest of Theramore at (58.6, 60.0)."),
                    line("FERALAS","Catch Feralas Ahi at the Verdantis River near (62, 51)."),
                    line("SWAMP","Catch Misty Reed Mahi Mahi on Misty Reed Strand near (90, 72)."),
                    line("DESOLACE","Catch Sar'theris Striker at Sar'theris Strand near (25, 77)."),
                    line("STRANGLETHORN","Catch Savage Coast Blue Sailfin near the Savage Coast at (33, 32)."),
                    line("RISK","The quest awards XP and crosses level-40+ territory; explore first and use an escort."),
                }),
                step("SKILL 225-300",{
                    line("ARTISAN","Turn in the four fish to receive Artisan Fishing and the 300 cap.",{16082}),
                    line("ROUTE","Fish any safe water you can successfully use; skill gains depend on successful catches, not zone difficulty."),
                    line("LURE","Use Aquadynamic Fish Attractors for dangerous high-skill water.",{6533}),
                    line("CAP","Stop at 300. Equipment and lures raise effective skill above the trained cap."),
                }),
                step("TWINK REWARDS",{
                    line("EVENT","Prepare the Stranglethorn Fishing Extravaganza coast and graveyard routes before 39."),
                    line("HAT","Exchange Keefer's Angelfish for Lucky Fishing Hat.",{19805,19972}),
                    line("BOOTS","Exchange Brownell's Blue Striped Racer for Nat Pagle's Extreme Anglin' Boots.",{19803,19969}),
                    line("LINE","Dezian Queenfish awards High Test Eternium Fishing Line for a permanent pole upgrade.",{19806,19971}),
                }),
            },
            items = {
                item(6256,"Fishing Pole","Basic pole required to cast Fishing."), item(6365,"Strong Fishing Pole","Limited-stock +5 Fishing pole."),
                item(6529,"Shiny Bauble","Vendor +25 Fishing lure."), item(6533,"Aquadynamic Fish Attractor","Engineering +100 Fishing lure."),
                item(16083,"Expert Fishing - The Bass and You","Level-20 Expert book for the 225 cap."), item(16082,"Artisan Fishing - The Way of the Lure","Level-35 quest reward for the 300 cap."),
                item(19805,"Keefer's Angelfish","Rare tournament fish."), item(19972,"Lucky Fishing Hat","Universal stamina twink helm."),
                item(19803,"Brownell's Blue Striped Racer","Rare tournament fish."), item(19969,"Nat Pagle's Extreme Anglin' Boots","Universal stamina twink boots."),
                item(19806,"Dezian Queenfish","Rare tournament fish."), item(19971,"High Test Eternium Fishing Line","Permanent fishing-pole upgrade."),
            },
        },
        ENGINEERING = {
            name = "Engineering",
            tagline = "Level 39 unlocks Artisan 300 and both Engineering specializations.",
            steps = {
                step("REACH EXPERT 225",{
                    line("1-150","Follow the early route through blasting powder, bolts, bombs, tubes and scopes."),
                    line("150-200","Craft Bronze Frameworks, Explosive Sheep, Solid Blasting Powder and Mithril Tubes.",{4382,4384,10505,10559}),
                    line("200-225","Craft Unstable Triggers and Mithril Casings; retain both for later bombs.",{10560,10561}),
                    line("TOOLS","Keep an Arclight Spanner and Gyromatic Micro-Adjustor.",{6219,10498}),
                }),
                step("ARTISAN AND SPECIALIZATION",{
                    line("ARTISAN","At level 35 and Engineering 200, train Artisan from Buzzek Bracketswing in Gadgetzan."),
                    line("SPECIALIZE","At level 30 and Engineering 200, choose Goblin or Gnomish Engineering through its quest chain."),
                    line("PERMANENT","The specialization choice controls BoP crafts; research the target build before completing it."),
                    line("XP SAFETY","Gadgetzan and specialization quests carry travel and quest XP; finish them before the final level."),
                }),
                step("SKILL 225-300",{
                    line("225-238","Craft about 20-25 Mithril Casings; keep them.",{10561,3860}),
                    line("238-250","Craft about 20 Hi-Explosive Bombs from saved casings and triggers.",{10562,10561,10560,10505}),
                    line("250-260","Craft about 30 Dense Blasting Powder from 60 Dense Stone.",{15992,12365}),
                    line("260-285","Craft about 35 Thorium Widgets from roughly 105 Thorium Bars and 35 Runecloth.",{15994,12359,14047}),
                    line("285-300","Craft 15 Thorium Shells if the world-drop schematic is available; otherwise use Thorium Tubes.",{15997,16000}),
                    line("BUFFER","Yellow recipes can require extra Mithril, Thorium, cloth and stone."),
                }),
                step("LEVEL-39 PAYOFF",{
                    line("CONTROL","Thorium Grenade, Dark Iron Bomb and Arcane Bomb provide distinct stun or silence profiles.",{15993,16005,16040}),
                    line("ESCAPE","Masterwork Target Dummy is the strongest generic PvE distraction.",{16023}),
                    line("GNOMISH","Battle Chicken and Death Ray are powerful BoP specialization tools with risk and long cooldowns.",{10725,10645}),
                    line("GOBLIN","Rocket Helmet and Bomb Dispenser add charge or guardian utility and can malfunction.",{10588,10587}),
                    line("HARDCORE","Explosives, guardians and malfunctioning devices can create lethal pulls or self-damage; validate each tool before relying on it."),
                }),
            },
            items = {
                item(4382,"Bronze Framework","Expert Engineering component."), item(4384,"Explosive Sheep","Expert leveling craft."),
                item(10505,"Solid Blasting Powder","Saved Expert component."), item(10559,"Mithril Tube","Expert leveling component."),
                item(10560,"Unstable Trigger","Bomb component."), item(10561,"Mithril Casing","Bomb component."), item(6219,"Arclight Spanner","Engineering tool."), item(10498,"Gyromatic Micro-Adjustor","Engineering tool."),
                item(3860,"Mithril Bar","Main 200-250 material."), item(10562,"Hi-Explosive Bomb","238-250 leveling craft."),
                item(15992,"Dense Blasting Powder","250-260 leveling component."), item(12365,"Dense Stone","Dense Blasting Powder material."),
                item(15994,"Thorium Widget","260-285 leveling craft."), item(12359,"Thorium Bar","Main 260-300 material."), item(14047,"Runecloth","Thorium Widget material."),
                item(15997,"Thorium Shells","285-300 leveling craft."), item(16000,"Thorium Tube","Fallback 285-300 craft."),
                item(15993,"Thorium Grenade","Engineering 260 stun explosive."), item(16005,"Dark Iron Bomb","Engineering 285 stun explosive."), item(16040,"Arcane Bomb","Engineering 300 mana drain and silence."),
                item(16023,"Masterwork Target Dummy","Engineering 275 PvE escape tool."), item(10725,"Gnomish Battle Chicken","Gnomish Engineering trinket."), item(10645,"Gnomish Death Ray","Gnomish Engineering trinket."),
                item(10588,"Goblin Rocket Helmet","Goblin Engineering charge helmet."), item(10587,"Goblin Bomb Dispenser","Goblin Engineering trinket."),
            },
        },
    },
}
