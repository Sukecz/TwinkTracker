local addonName, ns = ...

local WOWHEAD_CLASSIC_QUEST_URL = "https://www.wowhead.com/classic/quest="
local WOWHEAD_TBC_QUEST_URL = "https://www.wowhead.com/tbc/quest="

-- Reward mappings and minimum levels were audited against the matching
-- Wowhead Classic/TBC pages. Starter, zone and prerequisite-chain data was
-- cross-checked against Questie commit 1c5193d8b81c602b1ee473c8761e992812a223cc.

local function start(id, name, minLevel, startsAt, location)
    return { id = id, name = name, minLevel = minLevel, startsAt = startsAt, location = location }
end

local function quest(id, name, minLevel, startsAt, location, faction, chainStarts, note)
    return {
        id = id,
        name = name,
        minLevel = minLevel,
        startsAt = startsAt,
        location = location,
        faction = faction,
        chainStarts = chainStarts,
        note = note,
    }
end

local era = {
    [1131] = { quest(101,"The Totem of Infliction",18,"Madame Eva","Duskwood","ALLIANCE",nil) },
    [2000] = { quest(231,"A Daughter's Love",28,"Watcher Ladimore","Duskwood","ALLIANCE",{start(225,"The Weathered Grave",28,"A Weathered Grave (object)","Duskwood")}) },
    [2032] = { quest(1164,"To Steal From Thieves",27,"Genavie Callow","Undercity","HORDE",nil) },
    [2041] = { quest(166,"The Defias Brotherhood",14,"Gryan Stoutmantle","Westfall","ALLIANCE",{start(65,"The Defias Brotherhood",14,"Gryan Stoutmantle","Westfall")}) },
    [2043] = { quest(98,"The Legend of Stalvan",22,"Commander Althea Ebonlocke","Duskwood","ALLIANCE",{start(66,"The Legend of Stalvan",22,"Madame Eva","Duskwood")}) },
    [2044] = { quest(98,"The Legend of Stalvan",22,"Commander Althea Ebonlocke","Duskwood","ALLIANCE",{start(66,"The Legend of Stalvan",22,"Madame Eva","Duskwood")}) },
    [2820] = { quest(778,"This Is Going to Be Hard",35,"Lotwil Veriatus","Badlands",nil,{start(710,"Study of the Elements: Rock",35,"Lotwil Veriatus","Badlands"),start(713,"Coolant Heads Prevail",35,"Lotwil Veriatus","Badlands")}) },
    [2933] = { quest(396,"An Audience with the King",16,"Baros Alexston","Stormwind City","ALLIANCE",{start(373,"The Unsent Letter",16,"An Unsent Letter (item)","Stormwind City")}) },
    [2943] = { quest(293,"Cleansing the Eye",22,"Glorin Steelbrow","Wetlands","ALLIANCE",{start(288,"The Third Fleet",22,"First Mate Fitzsimmons","Wetlands")}) },
    [2944] = { quest(292,"The Eye of Paleth",22,"Intrepid's Locked Strongbox (object)","Wetlands","ALLIANCE",{start(288,"The Third Fleet",22,"First Mate Fitzsimmons","Wetlands")},"Quest-provided item: keep the quest incomplete or abandon it after receiving the item.") },
    [2953] = { quest(55,"Morbent Fel",20,"Sven Yorgen","Duskwood","ALLIANCE",{start(95,"Sven's Revenge",20,"Sven Yorgen","Duskwood")}) },
    [3324] = { quest(1098,"Deathstalkers in Shadowfang",18,"High Executor Hadrec","Silverpine Forest","HORDE",nil) },
    [3742] = { quest(567,"Dangerous!",19,"Dangerous! (object)","Hillsbrad Foothills","HORDE",nil) },
    [3759] = { quest(505,"Syndicate Assassins",26,"Magistrate Henry Maleb","Hillsbrad Foothills","ALLIANCE",nil) },
    [3761] = { quest(550,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills","HORDE",{start(527,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills")}) },
    [3765] = { quest(508,"Taretha's Gift",29,"Elysa","Alterac Mountains","HORDE",{start(498,"The Rescue",17,"Krusk","Hillsbrad Foothills")}) },
    [3822] = { quest(550,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills","HORDE",{start(527,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills")}) },
    [4107] = { quest(188,"Tiger Mastery",28,"Ajeck Rouack","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [4108] = { quest(193,"Panther Mastery",28,"Sir S. J. Erlgadin","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [4119] = { quest(197,"Raptor Mastery",28,"Hemet Nesingwary","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [4131] = { quest(621,"Zanzil's Secret",35,"Crank Fizzlebub","Stranglethorn Vale",nil,nil) },
    [4197] = { quest(1101,"The Crone of the Kraul",29,"Falfindel Waywarder","Feralas","ALLIANCE",{start(1100,"Lonebrow's Journal",29,"Henrig Lonebrow's Journal (item)","Thousand Needles")}), quest(1102,"A Vengeful Fate",29,"Auld Stonespire","Thunder Bluff","HORDE",nil) },
    [4534] = { quest(1013,"The Book of Ur",16,"Keeper Bel'dugur","Undercity","HORDE",nil) },
    [4549] = { quest(667,"Death From Below",35,"Shakes O'Breen","Arathi Highlands",nil,{start(665,"Sunken Treasure",35,"Professor Phizzlethorpe","Arathi Highlands")}) },
    [4653] = { quest(733,"Scrounging",35,"Sigrun Ironhew","Badlands","ALLIANCE",{start(718,"Mirages",35,"Sigrun Ironhew","Badlands")}) },
    [4745] = { quest(685,"Wanted! Otto and Falconcrest",30,"Wanted Board (object)","Arathi Highlands","ALLIANCE",nil) },
    [4984] = { quest(737,"Forbidden Knowledge",30,"Gerrig Bonegrip / Keeper Bel'dugur","Ironforge / Undercity",nil,{start(709,"Solution to Doom",30,"Theldurin the Lost","Badlands")}) },
    [5815] = { quest(1046,"Raene's Cleansing",18,"Krolg","Ashenvale","ALLIANCE",{start(991,"Raene's Cleansing",18,"Raene Wolfrunner","Ashenvale")}) },
    [6087] = { quest(166,"The Defias Brotherhood",14,"Gryan Stoutmantle","Westfall","ALLIANCE",{start(65,"The Defias Brotherhood",14,"Gryan Stoutmantle","Westfall")}) },
    [6189] = { quest(256,"WANTED: Chok'sul",17,"WANTED (object)","Loch Modan","ALLIANCE",nil) },
    [6223] = { quest(253,"Bride of the Embalmer",20,"Lord Ello Ebonlocke","Duskwood","ALLIANCE",{start(165,"The Hermit",17,"Elaine Carevin","Duskwood")}) },
    [6282] = { quest(550,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills","HORDE",{start(527,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills")}) },
    [6335] = { quest(1013,"The Book of Ur",16,"Keeper Bel'dugur","Undercity","HORDE",nil) },
    [6414] = { quest(1014,"Arugal Must Die",18,"Dalar Dawnweaver","Silverpine Forest","HORDE",nil) },
    [6504] = { quest(914,"Leaders of the Fang",10,"Nara Wildmane","Thunder Bluff","HORDE",{start(870,"The Forgotten Pools",10,"Tonga Runetotem","The Barrens")}) },
    [6505] = { quest(914,"Leaders of the Fang",10,"Nara Wildmane","Thunder Bluff","HORDE",{start(870,"The Forgotten Pools",10,"Tonga Runetotem","The Barrens")}) },
    [6667] = { quest(1096,"Gerenzo Wrenchwhistle",16,"Ziz Fizziks","Stonetalon Mountains",nil,{start(1093,"Super Reaper 6000",16,"Ziz Fizziks","Stonetalon Mountains")}) },
    [6668] = { quest(1096,"Gerenzo Wrenchwhistle",16,"Ziz Fizziks","Stonetalon Mountains",nil,{start(1093,"Super Reaper 6000",16,"Ziz Fizziks","Stonetalon Mountains")}) },
    [6725] = { quest(1101,"The Crone of the Kraul",29,"Falfindel Waywarder","Feralas","ALLIANCE",{start(1100,"Lonebrow's Journal",29,"Henrig Lonebrow's Journal (item)","Thousand Needles")}), quest(1102,"A Vengeful Fate",29,"Auld Stonespire","Thunder Bluff","HORDE",nil) },
    [6727] = { quest(1189,"Safety First",29,"Shreev","Tanaris",nil,{start(1176,"Load Lightening",29,"Pozzik","Thousand Needles")}) },
    [6729] = { quest(1137,"News for Fizzle",28,"Martek the Exiled","Badlands",nil,{start(1106,"Martek the Exiled",26,"Fizzle Brassbolts","Thousand Needles")}) },
    [6738] = { quest(1184,"Parts of the Swarm",28,"Korran","The Barrens","HORDE",{start(1148,"Parts of the Swarm",28,"Cracked Silithid Carapace (item)","Thousand Needles")}) },
    [6742] = { quest(1101,"The Crone of the Kraul",29,"Falfindel Waywarder","Feralas","ALLIANCE",{start(1100,"Lonebrow's Journal",29,"Henrig Lonebrow's Journal (item)","Thousand Needles")}), quest(1102,"A Vengeful Fate",29,"Auld Stonespire","Thunder Bluff","HORDE",nil) },
    [6746] = { quest(1488,"The Corrupter",26,"Takata Steelblade","Desolace","HORDE",{start(1480,"The Corrupter",25,"Flayed Demon Skin (item)","Desolace")}) },
    [6802] = { quest(1048,"Into The Scarlet Monastery",33,"Varimathras","Undercity","HORDE",nil) },
    [6803] = { quest(1048,"Into The Scarlet Monastery",33,"Varimathras","Undercity","HORDE",nil) },
    [6804] = { quest(1394,"Final Passage",26,"Parqual Fintallas","Undercity","HORDE",{start(1149,"Test of Faith",25,"Dorn Plainstalker","Thousand Needles")}) },
    [6806] = { quest(1394,"Final Passage",26,"Parqual Fintallas","Undercity","HORDE",{start(1149,"Test of Faith",25,"Dorn Plainstalker","Thousand Needles")}) },
    [6830] = { quest(1053,"In the Name of the Light",34,"Raleigh the Devout","Hillsbrad Foothills","ALLIANCE",{start(261,"Down the Scarlet Path",34,"Brother Anton","Desolace")}) },
    [6898] = { quest(1740,"The Orb of Soran'ruk",20,"Doan Karhan","The Barrens",nil,nil) },
    [6971] = { quest(1706,"Grimand's Armor",20,"Grimand Elmore","Stormwind City","ALLIANCE",{start(1698,"Yorus Barleybrew",20,"Wu Shen","Stormwind City")}) },
    [6972] = { quest(1782,"Furen's Armor",20,"Furen Longbeard","Stormwind City","ALLIANCE",{start(1698,"Yorus Barleybrew",20,"Wu Shen","Stormwind City")}) },
    [6974] = { quest(1709,"Klockmort's Creation",20,"Klockmort Spannerspan","Ironforge","ALLIANCE",{start(1698,"Yorus Barleybrew",20,"Wu Shen","Stormwind City")}) },
    [6975] = { quest(1792,"Whirlwind Weapon",30,"Bath'rah the Windwatcher","Alterac Mountains",nil,{start(1718,"The Islander",30,"Any Warrior trainer","Capital cities")}) },
    [7001] = { quest(1200,"Blackfathom Villainy",18,"Argent Guard Thaelrid","Blackfathom Deeps","ALLIANCE",{start(1198,"In Search of Thaelrid",18,"Dawnwatcher Shaedlass","Darnassus")}), quest(6561,"Blackfathom Villainy",18,"Argent Guard Thaelrid","Blackfathom Deeps","HORDE",nil) },
    [7002] = { quest(1200,"Blackfathom Villainy",18,"Argent Guard Thaelrid","Blackfathom Deeps","ALLIANCE",{start(1198,"In Search of Thaelrid",18,"Dawnwatcher Shaedlass","Darnassus")}), quest(6561,"Blackfathom Villainy",18,"Argent Guard Thaelrid","Blackfathom Deeps","HORDE",nil) },
    [7003] = { quest(1275,"Researching the Corruption",18,"Gershala Nightwhisper","Darkshore","ALLIANCE",{start(3765,"The Corruption Abroad",18,"Argos Nightwhisper","Stormwind City")}) },
    [7129] = { quest(1843,"Brutal Gauntlets",20,"Ula'elek","Durotar","HORDE",{start(1823,"Speak with Ruga",20,"Sorek","Orgrimmar")}) },
    [7130] = { quest(1845,"Brutal Helm",20,"Orm Stonehoof","Thunder Bluff","HORDE",{start(1823,"Speak with Ruga",20,"Sorek","Orgrimmar")}) },
    [7133] = { quest(1848,"Brutal Hauberk",20,"Thun'grim Firegaze","The Barrens","HORDE",{start(1823,"Speak with Ruga",20,"Sorek","Orgrimmar")}) },
    [7747] = { quest(1049,"Compendium of the Fallen",28,"Sage Truthseeker","Thunder Bluff","HORDE",nil) },
    [7749] = { quest(1049,"Compendium of the Fallen",28,"Sage Truthseeker","Thunder Bluff","HORDE",nil) },
    [7888] = { quest(2341,"Necklace Recovery, Take 3",37,"Dran Droffers","Orgrimmar","HORDE",{start(2283,"Necklace Recovery",37,"Dran Droffers","Orgrimmar")}) },
    [9538] = { quest(2948,"Gnome Improvement",28,"Talvash del Kissel","Ironforge","ALLIANCE",{start(2945,"Grime-Encrusted Ring",28,"Grime-Encrusted Ring (item)","Gnomeregan")}) },
    [9588] = { quest(2950,"Nogg's Ring Redo",28,"Nogg","Orgrimmar","HORDE",{start(2945,"Grime-Encrusted Ring",28,"Grime-Encrusted Ring (item)","Gnomeregan")}) },
    [9623] = { quest(2841,"Rig Wars",25,"Nogg","Orgrimmar","HORDE",nil), quest(2929,"The Grand Betrayal",25,"High Tinker Mekkatorque","Ironforge","ALLIANCE",nil) },
    [9624] = { quest(2841,"Rig Wars",25,"Nogg","Orgrimmar","HORDE",nil), quest(2929,"The Grand Betrayal",25,"High Tinker Mekkatorque","Ironforge","ALLIANCE",nil) },
    [9625] = { quest(2841,"Rig Wars",25,"Nogg","Orgrimmar","HORDE",nil), quest(2929,"The Grand Betrayal",25,"High Tinker Mekkatorque","Ironforge","ALLIANCE",nil) },
    [9634] = { quest(864,"Return to Apothecary Zinge",38,"Chief Engineer Bilgewhizzle","Tanaris","HORDE",{start(232,"Errand for Apothecary Zinge",38,"Apothecary Zinge","Undercity")}) },
    [10043] = { quest(981,"The Tower of Althalaxx",13,"Balthule Shadowstrike","Darkshore","ALLIANCE",{start(965,"The Tower of Althalaxx",13,"Sentinel Elissa Starbreeze","Darkshore")}) },
    [10653] = { quest(3514,"Horde Presence",15,"Kadrak","The Barrens","HORDE",{start(3513,"The Runed Scroll",15,"Runed Scroll (item)","The Barrens")}) },
    [10654] = { quest(3514,"Horde Presence",15,"Kadrak","The Barrens","HORDE",{start(3513,"The Runed Scroll",15,"Runed Scroll (item)","The Barrens")}) },
    [10657] = { quest(3369,"In Nightmares",10,"Falla Sagewind","The Barrens","HORDE",{start(6981,"The Glowing Shard",15,"Glowing Shard (item)","Wailing Caverns")}), quest(3370,"In Nightmares",10,"Falla Sagewind","The Barrens","ALLIANCE",{start(6981,"The Glowing Shard",15,"Glowing Shard (item)","Wailing Caverns")}) },
    [10703] = { quest(1173,"Challenge Overlord Mok'Morokk",38,"Overlord Mok'Morokk","Dustwallow Marsh","HORDE",{start(1169,"Identifying the Brood",38,"Draz'Zilb","Dustwallow Marsh")}) },
    [10704] = { quest(1173,"Challenge Overlord Mok'Morokk",38,"Overlord Mok'Morokk","Dustwallow Marsh","HORDE",{start(1169,"Identifying the Brood",38,"Draz'Zilb","Dustwallow Marsh")}) },
    [10710] = { quest(3525,"Extinguishing the Idol",32,"Belnistrasz","Razorfen Downs",nil,{start(3523,"Scourge of the Downs",32,"Belnistrasz","Razorfen Downs")}) },
    [10823] = { quest(3341,"Bring the End",37,"Andrew Brownell","Undercity","HORDE",nil), quest(3636,"Bring the Light",39,"Archbishop Benedictus","Stormwind City","ALLIANCE",nil) },
    [11469] = { quest(614,"The Captain's Chest",35,"Captain Hecklebury Smotts","Stranglethorn Vale","ALLIANCE",nil), quest(8551,"The Captain's Chest",35,"Captain Hecklebury Smotts","Stranglethorn Vale",nil,nil) },
    [11858] = { quest(2976,"A Grim Discovery",37,"Krueg Skullsplitter","Feralas","HORDE",{start(2973,"A New Cloak's Sheen",38,"Krueg Skullsplitter","Feralas")}) },
    [15106] = { quest(4964,"The Completed Orb of Dar'Orahil",35,"Menara Voidrender","The Barrens",nil,{start(1799,"Fragments of the Orb of Orahil",35,"Menara Voidrender","The Barrens")}) },
    [15108] = { quest(4964,"The Completed Orb of Dar'Orahil",35,"Menara Voidrender","The Barrens",nil,{start(1799,"Fragments of the Orb of Orahil",35,"Menara Voidrender","The Barrens")}) },
    [15109] = { quest(1740,"The Orb of Soran'ruk",20,"Doan Karhan","The Barrens",nil,nil) },
    [15866] = { quest(6124,"Curing the Sick",14,"Alanndarian Nightsong","Darkshore","ALLIANCE",{start(6121,"Lessons Anew",14,"Mathrengyl Bearwalker","Darnassus")}), quest(6129,"Curing the Sick",14,"Tonga Runetotem","The Barrens","HORDE",{start(6126,"Lessons Anew",14,"Turak Runetotem","Thunder Bluff")}) },
    [16794] = { quest(5581,"Portals of the Legion",32,"Taiga Wisemane","Desolace","HORDE",{start(5381,"Hand of Iruxos",32,"Taiga Wisemane","Desolace")}) },
    [16887] = { quest(6922,"Baron Aquanis",21,"Strange Water Globe (item)","Ashenvale","HORDE",nil) },
    [16975] = { quest(6571,"Warsong Supplies",22,"Locke Okarr","Ashenvale","HORDE",nil) },
    [16977] = { quest(6571,"Warsong Supplies",22,"Locke Okarr","Ashenvale","HORDE",nil) },
    [16987] = { quest(6283,"Bloodfury Bloodline",18,"Maggran Earthbinder","Stonetalon Mountains","HORDE",{start(6282,"Harpies Threaten",18,"Maggran Earthbinder","Stonetalon Mountains")}) },
    [17039] = { quest(6521,"An Unholy Alliance",28,"Varimathras","Undercity","HORDE",{start(6522,"An Unholy Alliance",28,"Small Scroll (item)","Razorfen Downs")}) },
    [17042] = { quest(6521,"An Unholy Alliance",28,"Varimathras","Undercity","HORDE",{start(6522,"An Unholy Alliance",28,"Small Scroll (item)","Razorfen Downs")}) },
    [17508] = { quest(1049,"Compendium of the Fallen",28,"Sage Truthseeker","Thunder Bluff","HORDE",nil) },
    [17686] = { quest(208,"Big Game Hunter",28,"Hemet Nesingwary","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [17687] = { quest(208,"Big Game Hunter",28,"Hemet Nesingwary","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [17772] = { quest(7068,"Shadowshard Fragments",39,"Uthel'nay","Orgrimmar","HORDE",nil), quest(7070,"Shadowshard Fragments",39,"Archmage Tervosh","Dustwallow Marsh","ALLIANCE",nil) },
    [17774] = { quest(7067,"The Pariah's Instructions",39,"Centaur Pariah","Desolace",nil,nil) },
    [18585] = { quest(7541,"Service to the Horde",30,"Zor Lonetree","Orgrimmar","HORDE",{start(1238,"The Lost Report",30,"Loose Dirt (object)","Dustwallow Marsh")}) },
}

local tbc = {
    [1131] = { quest(101,"The Totem of Infliction",18,"Madame Eva","Duskwood","ALLIANCE",nil) },
    [2000] = { quest(231,"A Daughter's Love",25,"Watcher Ladimore","Duskwood","ALLIANCE",{start(225,"The Weathered Grave",25,"A Weathered Grave (object)","Duskwood")}) },
    [2032] = { quest(1164,"To Steal From Thieves",27,"Genavie Callow","Undercity","HORDE",nil) },
    [2041] = { quest(166,"The Defias Brotherhood",14,"Gryan Stoutmantle","Westfall","ALLIANCE",{start(65,"The Defias Brotherhood",14,"Gryan Stoutmantle","Westfall")}) },
    [2043] = { quest(98,"The Legend of Stalvan",22,"Commander Althea Ebonlocke","Duskwood","ALLIANCE",{start(66,"The Legend of Stalvan",22,"Madame Eva","Duskwood")}) },
    [2044] = { quest(98,"The Legend of Stalvan",22,"Commander Althea Ebonlocke","Duskwood","ALLIANCE",{start(66,"The Legend of Stalvan",22,"Madame Eva","Duskwood")}) },
    [2231] = { quest(566,"WANTED: Baron Vardus",17,"WANTED (object)","Hillsbrad Foothills","HORDE",nil) },
    [2820] = { quest(778,"This Is Going to Be Hard",35,"Lotwil Veriatus","Badlands",nil,{start(710,"Study of the Elements: Rock",35,"Lotwil Veriatus","Badlands"),start(713,"Coolant Heads Prevail",35,"Lotwil Veriatus","Badlands")}) },
    [2933] = { quest(396,"An Audience with the King",16,"Baros Alexston","Stormwind City","ALLIANCE",{start(373,"The Unsent Letter",16,"An Unsent Letter (item)","Stormwind City")}) },
    [2943] = { quest(293,"Cleansing the Eye",22,"Glorin Steelbrow","Wetlands","ALLIANCE",{start(288,"The Third Fleet",22,"First Mate Fitzsimmons","Wetlands")}) },
    [2944] = { quest(292,"The Eye of Paleth",22,"Intrepid's Locked Strongbox (object)","Wetlands","ALLIANCE",{start(288,"The Third Fleet",22,"First Mate Fitzsimmons","Wetlands")},"Quest-provided item: keep the quest incomplete or abandon it after receiving the item.") },
    [2953] = { quest(55,"Morbent Fel",20,"Sven Yorgen","Duskwood","ALLIANCE",{start(95,"Sven's Revenge",20,"Sven Yorgen","Duskwood")}) },
    [3324] = { quest(1098,"Deathstalkers in Shadowfang",18,"High Executor Hadrec","Silverpine Forest","HORDE",nil) },
    [3742] = { quest(567,"Dangerous!",17,"Dangerous! (object)","Hillsbrad Foothills","HORDE",nil) },
    [3759] = { quest(505,"Syndicate Assassins",26,"Magistrate Henry Maleb","Hillsbrad Foothills","ALLIANCE",nil) },
    [3761] = { quest(550,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills","HORDE",{start(527,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills")}) },
    [3765] = { quest(508,"Taretha's Gift",29,"Elysa","Alterac Mountains","HORDE",{start(498,"The Rescue",17,"Krusk","Hillsbrad Foothills")}) },
    [3822] = { quest(550,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills","HORDE",{start(527,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills")}) },
    [4107] = { quest(188,"Tiger Mastery",28,"Ajeck Rouack","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [4108] = { quest(193,"Panther Mastery",28,"Sir S. J. Erlgadin","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [4119] = { quest(197,"Raptor Mastery",28,"Hemet Nesingwary Jr.","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [4131] = { quest(621,"Zanzil's Secret",35,"Crank Fizzlebub","Stranglethorn Vale",nil,nil) },
    [4197] = { quest(1101,"The Crone of the Kraul",23,"Falfindel Waywarder","Feralas","ALLIANCE",{start(1100,"Lonebrow's Journal",23,"Henrig Lonebrow's Journal (item)","Thousand Needles")}), quest(1102,"A Vengeful Fate",23,"Auld Stonespire","Thunder Bluff","HORDE",nil) },
    [4508] = { quest(646,"Trol'kalar",32,"Trollbane's Tomb (object)","Arathi Highlands","HORDE",{start(638,"Trollbane",32,"Nimboya","Stranglethorn Vale")}) },
    [4534] = { quest(1013,"The Book of Ur",16,"Keeper Bel'dugur","Undercity","HORDE",nil) },
    [4549] = { quest(667,"Death From Below",35,"Shakes O'Breen","Arathi Highlands",nil,{start(665,"Sunken Treasure",35,"Professor Phizzlethorpe","Arathi Highlands")}) },
    [4653] = { quest(733,"Scrounging",35,"Sigrun Ironhew","Badlands","ALLIANCE",{start(718,"Mirages",35,"Sigrun Ironhew","Badlands")}) },
    [4743] = { quest(656,"Summoning the Princess",30,"Theldurin the Lost","Badlands",nil,{start(642,"The Princess Trapped",30,"Shards of Myzrael (object)","Arathi Highlands")}) },
    [4745] = { quest(685,"Wanted! Otto and Falconcrest",29,"Wanted Board (object)","Arathi Highlands","ALLIANCE",nil) },
    [4984] = { quest(737,"Forbidden Knowledge",30,"Gerrig Bonegrip / Keeper Bel'dugur","Ironforge / Undercity",nil,{start(709,"Solution to Doom",30,"Theldurin the Lost","Badlands")}) },
    [5322] = { quest(893,"Weapons of Choice",17,"Tatternack Steelforge","The Barrens","HORDE",nil) },
    [5815] = { quest(1046,"Raene's Cleansing",18,"Krolg","Ashenvale","ALLIANCE",{start(991,"Raene's Cleansing",18,"Raene Wolfrunner","Ashenvale")}) },
    [6087] = { quest(166,"The Defias Brotherhood",14,"Gryan Stoutmantle","Westfall","ALLIANCE",{start(65,"The Defias Brotherhood",14,"Gryan Stoutmantle","Westfall")}) },
    [6189] = { quest(256,"WANTED: Chok'sul",9,"WANTED (object)","Loch Modan","ALLIANCE",nil) },
    [6223] = { quest(253,"Bride of the Embalmer",20,"Lord Ello Ebonlocke","Duskwood","ALLIANCE",{start(165,"The Hermit",17,"Elaine Carevin","Duskwood")}) },
    [6282] = { quest(550,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills","HORDE",{start(527,"Battle of Hillsbrad",19,"High Executor Darthalia","Hillsbrad Foothills")}) },
    [6335] = { quest(1013,"The Book of Ur",16,"Keeper Bel'dugur","Undercity","HORDE",nil) },
    [6414] = { quest(1014,"Arugal Must Die",18,"Dalar Dawnweaver","Silverpine Forest","HORDE",nil) },
    [6504] = { quest(914,"Leaders of the Fang",10,"Nara Wildmane","Thunder Bluff","HORDE",{start(870,"The Forgotten Pools",10,"Tonga Runetotem","The Barrens")}) },
    [6505] = { quest(914,"Leaders of the Fang",10,"Nara Wildmane","Thunder Bluff","HORDE",{start(870,"The Forgotten Pools",10,"Tonga Runetotem","The Barrens")}) },
    [6667] = { quest(1096,"Gerenzo Wrenchwhistle",16,"Ziz Fizziks","Stonetalon Mountains","HORDE",{start(1093,"Super Reaper 6000",16,"Ziz Fizziks","Stonetalon Mountains")}) },
    [6668] = { quest(1096,"Gerenzo Wrenchwhistle",16,"Ziz Fizziks","Stonetalon Mountains","HORDE",{start(1093,"Super Reaper 6000",16,"Ziz Fizziks","Stonetalon Mountains")}) },
    [6725] = { quest(1101,"The Crone of the Kraul",23,"Falfindel Waywarder","Feralas","ALLIANCE",{start(1100,"Lonebrow's Journal",23,"Henrig Lonebrow's Journal (item)","Thousand Needles")}), quest(1102,"A Vengeful Fate",23,"Auld Stonespire","Thunder Bluff","HORDE",nil) },
    [6727] = { quest(1189,"Safety First",29,"Shreev","Tanaris",nil,{start(1176,"Load Lightening",29,"Pozzik","Thousand Needles")}) },
    [6729] = { quest(1137,"News for Fizzle",28,"Martek the Exiled","Badlands",nil,{start(1106,"Martek the Exiled",26,"Fizzle Brassbolts","Thousand Needles")}) },
    [6738] = { quest(1184,"Parts of the Swarm",28,"Korran","The Barrens","HORDE",{start(1148,"Parts of the Swarm",28,"Cracked Silithid Carapace (item)","Thousand Needles")}) },
    [6742] = { quest(1101,"The Crone of the Kraul",23,"Falfindel Waywarder","Feralas","ALLIANCE",{start(1100,"Lonebrow's Journal",23,"Henrig Lonebrow's Journal (item)","Thousand Needles")}), quest(1102,"A Vengeful Fate",23,"Auld Stonespire","Thunder Bluff","HORDE",nil) },
    [6746] = { quest(1488,"The Corrupter",25,"Takata Steelblade","Desolace","HORDE",{start(1480,"The Corrupter",25,"Flayed Demon Skin (item)","Desolace")}) },
    [6802] = { quest(1048,"Into The Scarlet Monastery",30,"Varimathras","Undercity","HORDE",nil) },
    [6803] = { quest(1048,"Into The Scarlet Monastery",30,"Varimathras","Undercity","HORDE",nil) },
    [6804] = { quest(1394,"Final Passage",25,"Parqual Fintallas","Undercity","HORDE",{start(1149,"Test of Faith",25,"Dorn Plainstalker","Thousand Needles")}) },
    [6806] = { quest(1394,"Final Passage",25,"Parqual Fintallas","Undercity","HORDE",{start(1149,"Test of Faith",25,"Dorn Plainstalker","Thousand Needles")}) },
    [6830] = { quest(1053,"In the Name of the Light",34,"Raleigh the Devout","Hillsbrad Foothills","ALLIANCE",{start(261,"Down the Scarlet Path",34,"Brother Anton","Desolace")}) },
    [6898] = { quest(1740,"The Orb of Soran'ruk",20,"Doan Karhan","The Barrens",nil,nil) },
    [6971] = { quest(1706,"Grimand's Armor",20,"Grimand Elmore","Stormwind City","ALLIANCE",{start(1698,"Yorus Barleybrew",20,"Wu Shen","Stormwind City")}) },
    [6972] = { quest(1782,"Furen's Armor",20,"Furen Longbeard","Stormwind City","ALLIANCE",{start(1698,"Yorus Barleybrew",20,"Wu Shen","Stormwind City")}) },
    [6974] = { quest(1709,"Klockmort's Creation",20,"Klockmort Spannerspan","Ironforge","ALLIANCE",{start(1698,"Yorus Barleybrew",20,"Wu Shen","Stormwind City")}) },
    [6975] = { quest(1792,"Whirlwind Weapon",30,"Bath'rah the Windwatcher","Alterac Mountains",nil,{start(1718,"The Islander",30,"Any Warrior trainer","Capital cities")}) },
    [7001] = { quest(1200,"Blackfathom Villainy",18,"Argent Guard Thaelrid","Blackfathom Deeps","ALLIANCE",{start(1198,"In Search of Thaelrid",18,"Dawnwatcher Shaedlass","Darnassus")}), quest(6561,"Blackfathom Villainy",18,"Argent Guard Thaelrid","Blackfathom Deeps","HORDE",nil) },
    [7002] = { quest(1200,"Blackfathom Villainy",18,"Argent Guard Thaelrid","Blackfathom Deeps","ALLIANCE",{start(1198,"In Search of Thaelrid",18,"Dawnwatcher Shaedlass","Darnassus")}), quest(6561,"Blackfathom Villainy",18,"Argent Guard Thaelrid","Blackfathom Deeps","HORDE",nil) },
    [7003] = { quest(1275,"Researching the Corruption",18,"Gershala Nightwhisper","Darkshore","ALLIANCE",{start(3765,"The Corruption Abroad",18,"Argos Nightwhisper","Stormwind City")}) },
    [7129] = { quest(1843,"Brutal Gauntlets",20,"Ula'elek","Durotar","HORDE",{start(1823,"Speak with Ruga",20,"Sorek","Orgrimmar")}) },
    [7130] = { quest(1845,"Brutal Helm",20,"Orm Stonehoof","Thunder Bluff","HORDE",{start(1823,"Speak with Ruga",20,"Sorek","Orgrimmar")}) },
    [7133] = { quest(1848,"Brutal Hauberk",20,"Thun'grim Firegaze","The Barrens","HORDE",{start(1823,"Speak with Ruga",20,"Sorek","Orgrimmar")}) },
    [7747] = { quest(1049,"Compendium of the Fallen",28,"Sage Truthseeker","Thunder Bluff","HORDE",nil) },
    [7749] = { quest(1049,"Compendium of the Fallen",28,"Sage Truthseeker","Thunder Bluff","HORDE",nil) },
    [9538] = { quest(2948,"Gnome Improvement",28,"Talvash del Kissel","Ironforge","ALLIANCE",{start(2945,"Grime-Encrusted Ring",28,"Grime-Encrusted Ring (item)","Gnomeregan")}) },
    [9588] = { quest(2950,"Nogg's Ring Redo",28,"Nogg","Orgrimmar","HORDE",{start(2945,"Grime-Encrusted Ring",28,"Grime-Encrusted Ring (item)","Gnomeregan")}) },
    [9623] = { quest(2841,"Rig Wars",25,"Nogg","Orgrimmar","HORDE",nil), quest(2929,"The Grand Betrayal",25,"High Tinker Mekkatorque","Ironforge","ALLIANCE",nil) },
    [9624] = { quest(2841,"Rig Wars",25,"Nogg","Orgrimmar","HORDE",nil), quest(2929,"The Grand Betrayal",25,"High Tinker Mekkatorque","Ironforge","ALLIANCE",nil) },
    [9625] = { quest(2841,"Rig Wars",25,"Nogg","Orgrimmar","HORDE",nil), quest(2929,"The Grand Betrayal",25,"High Tinker Mekkatorque","Ironforge","ALLIANCE",nil) },
    [9634] = { quest(864,"Return to Apothecary Zinge",38,"Chief Engineer Bilgewhizzle","Tanaris","HORDE",{start(232,"Errand for Apothecary Zinge",38,"Apothecary Zinge","Undercity")}) },
    [10043] = { quest(981,"The Tower of Althalaxx",13,"Balthule Shadowstrike","Darkshore","ALLIANCE",{start(965,"The Tower of Althalaxx",13,"Sentinel Elissa Starbreeze","Darkshore")}) },
    [10653] = { quest(3514,"Horde Presence",15,"Kadrak","The Barrens","HORDE",{start(3513,"The Runed Scroll",15,"Runed Scroll (item)","The Barrens")}) },
    [10654] = { quest(3514,"Horde Presence",15,"Kadrak","The Barrens","HORDE",{start(3513,"The Runed Scroll",15,"Runed Scroll (item)","The Barrens")}) },
    [10657] = { quest(3369,"In Nightmares",10,"Falla Sagewind","The Barrens","HORDE",{start(6981,"The Glowing Shard",15,"Glowing Shard (item)","Wailing Caverns")}), quest(3370,"In Nightmares",10,"Falla Sagewind","The Barrens","ALLIANCE",{start(6981,"The Glowing Shard",15,"Glowing Shard (item)","Wailing Caverns")}) },
    [10703] = { quest(1173,"Challenge Overlord Mok'Morokk",38,"Overlord Mok'Morokk","Dustwallow Marsh","HORDE",{start(1169,"Identifying the Brood",37,"Draz'Zilb","Dustwallow Marsh")}) },
    [10704] = { quest(1173,"Challenge Overlord Mok'Morokk",38,"Overlord Mok'Morokk","Dustwallow Marsh","HORDE",{start(1169,"Identifying the Brood",37,"Draz'Zilb","Dustwallow Marsh")}) },
    [10710] = { quest(3525,"Extinguishing the Idol",32,"Belnistrasz","Razorfen Downs",nil,{start(3523,"Scourge of the Downs",32,"Belnistrasz","Razorfen Downs")}) },
    [10823] = { quest(3341,"Bring the End",37,"Andrew Brownell","Undercity","HORDE",nil), quest(3636,"Bring the Light",32,"Archbishop Benedictus","Stormwind City","ALLIANCE",nil) },
    [11469] = { quest(614,"The Captain's Chest",35,"Captain Hecklebury Smotts","Stranglethorn Vale","ALLIANCE",nil), quest(8551,"The Captain's Chest",35,"Captain Hecklebury Smotts","Stranglethorn Vale",nil,nil) },
    [11858] = { quest(2976,"A Grim Discovery",37,"Krueg Skullsplitter","Feralas","HORDE",{start(2973,"A New Cloak's Sheen",38,"Krueg Skullsplitter","Feralas")}) },
    [15106] = { quest(4964,"The Completed Orb of Dar'Orahil",35,"Menara Voidrender","The Barrens",nil,{start(1799,"Fragments of the Orb of Orahil",35,"Menara Voidrender","The Barrens")}) },
    [15108] = { quest(4964,"The Completed Orb of Dar'Orahil",35,"Menara Voidrender","The Barrens",nil,{start(1799,"Fragments of the Orb of Orahil",35,"Menara Voidrender","The Barrens")}) },
    [15109] = { quest(1740,"The Orb of Soran'ruk",20,"Doan Karhan","The Barrens",nil,nil) },
    [15866] = { quest(6124,"Curing the Sick",14,"Alanndarian Nightsong","Darkshore","ALLIANCE",{start(6121,"Lessons Anew",14,"Mathrengyl Bearwalker","Darnassus")}), quest(6129,"Curing the Sick",14,"Tonga Runetotem","The Barrens","HORDE",{start(5926,"Heeding the Call",10,"Gennia Runetotem","Mulgore")}) },
    [16794] = { quest(5581,"Portals of the Legion",32,"Taiga Wisemane","Desolace","HORDE",{start(5381,"Hand of Iruxos",32,"Taiga Wisemane","Desolace")}) },
    [16887] = { quest(6922,"Baron Aquanis",21,"Strange Water Globe (item)","Ashenvale","HORDE",nil) },
    [16975] = { quest(6571,"Warsong Supplies",22,"Locke Okarr","Ashenvale","HORDE",nil) },
    [16977] = { quest(6571,"Warsong Supplies",22,"Locke Okarr","Ashenvale","HORDE",nil) },
    [16987] = { quest(6283,"Bloodfury Bloodline",18,"Maggran Earthbinder","Stonetalon Mountains","HORDE",{start(6282,"Harpies Threaten",18,"Maggran Earthbinder","Stonetalon Mountains")}) },
    [17039] = { quest(6521,"An Unholy Alliance",28,"Varimathras","Undercity","HORDE",{start(6522,"An Unholy Alliance",28,"Small Scroll (item)","Razorfen Downs")}) },
    [17042] = { quest(6521,"An Unholy Alliance",28,"Varimathras","Undercity","HORDE",{start(6522,"An Unholy Alliance",28,"Small Scroll (item)","Razorfen Downs")}) },
    [17508] = { quest(1049,"Compendium of the Fallen",28,"Sage Truthseeker","Thunder Bluff","HORDE",nil) },
    [17686] = { quest(208,"Big Game Hunter",28,"Hemet Nesingwary Jr.","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [17687] = { quest(208,"Big Game Hunter",28,"Hemet Nesingwary Jr.","Stranglethorn Vale",nil,{start(583,"Welcome to the Jungle",28,"Barnil Stonepot","Stranglethorn Vale")}) },
    [17772] = { quest(7068,"Shadowshard Fragments",39,"Uthel'nay","Orgrimmar","HORDE",nil), quest(7070,"Shadowshard Fragments",39,"Archmage Tervosh","Dustwallow Marsh","ALLIANCE",nil) },
    [17774] = { quest(7067,"The Pariah's Instructions",39,"Centaur Pariah","Desolace",nil,nil) },
    [18585] = { quest(7541,"Service to the Horde",30,"Zor Lonetree","Orgrimmar","HORDE",{start(1238,"The Lost Report",30,"Loose Dirt (object)","Dustwallow Marsh")}) },
    [22984] = { quest(9167,"The Traitor's Destruction",15,"Magister Kaendris","Ghostlands","HORDE",{start(9161,"The Traitor's Shadow",15,"Ranger Vynna","Ghostlands")}) },
    [22995] = { quest(9167,"The Traitor's Destruction",15,"Magister Kaendris","Ghostlands","HORDE",{start(9161,"The Traitor's Shadow",15,"Ranger Vynna","Ghostlands")}) },
}

local GearQuests = {
    catalogs = { ERA = era, TBC = tbc },
    counts = { ERA = 96, TBC = 101 },
}

local function currentFaction()
    if not UnitFactionGroup then return nil end
    local faction = UnitFactionGroup("player")
    return faction and string.upper(faction) or nil
end

function GearQuests:GetAll(itemID, clientKey)
    local catalog = self.catalogs[clientKey or "ERA"] or self.catalogs.ERA
    return itemID and catalog[itemID] or nil
end

function GearQuests:Get(itemData, clientKey)
    local entries = itemData and self:GetAll(itemData.id, clientKey)
    if not entries then return nil end
    local faction = itemData.faction or currentFaction()
    if not faction then return entries end
    local factionEntries = {}
    local neutralEntries = {}
    for _, entry in ipairs(entries) do
        if entry.faction == faction then
            factionEntries[#factionEntries + 1] = entry
        elseif not entry.faction then
            neutralEntries[#neutralEntries + 1] = entry
        end
    end
    if #factionEntries > 0 then return factionEntries end
    if #neutralEntries > 0 then return neutralEntries end
    return entries
end

function GearQuests:GetMinimumLevel(itemData, clientKey)
    local entries = self:Get(itemData, clientKey)
    local minimum
    for _, entry in ipairs(entries or {}) do
        if not minimum or entry.minLevel < minimum then minimum = entry.minLevel end
    end
    return minimum
end

function GearQuests:GetWowheadURL(questID, clientKey)
    if not questID then return nil end
    local base = clientKey == "TBC" and WOWHEAD_TBC_QUEST_URL or WOWHEAD_CLASSIC_QUEST_URL
    return base .. questID
end

function GearQuests:AddToTooltip(tooltip, itemData, clientKey)
    local entries = self:Get(itemData, clientKey)
    if not entries then return false end
    tooltip:AddLine(" ")
    tooltip:AddLine("QUEST GEAR", 1.00, 0.72, 0.30)
    for index, entry in ipairs(entries) do
        if index > 1 then tooltip:AddLine(" ") end
        tooltip:AddLine(entry.name, 0.92, 0.95, 1.00)
        tooltip:AddLine("Minimum level: " .. entry.minLevel, 0.53, 0.73, 0.95)
        if entry.startsAt and entry.startsAt ~= "" then
            tooltip:AddLine("Starts at: " .. entry.startsAt, 0.72, 0.80, 0.91, true)
        end
        if entry.location and entry.location ~= "" then
            tooltip:AddLine("Location: " .. entry.location, 0.72, 0.80, 0.91, true)
        end
        if entry.chainStarts and #entry.chainStarts > 0 then
            tooltip:AddLine("Quest line starts:", 1.00, 0.82, 0.35)
            for _, chainStart in ipairs(entry.chainStarts) do
                tooltip:AddLine(chainStart.name .. " (level " .. chainStart.minLevel .. ")", 0.85, 0.88, 0.95, true)
                if chainStart.startsAt and chainStart.startsAt ~= "" then
                    local where = chainStart.location and chainStart.location ~= "" and (" - " .. chainStart.location) or ""
                    tooltip:AddLine(chainStart.startsAt .. where, 0.53, 0.60, 0.70, true)
                end
            end
        end
        if entry.note then tooltip:AddLine(entry.note, 1.00, 0.72, 0.30, true) end
    end
    return true
end

ns.GearQuests = GearQuests
