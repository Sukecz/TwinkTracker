local addonName, ns = ...

ns.Bracket39ExplorationCategories = {
    order = { "STARTING", "WORLD_PVP", "TRAVEL" },
    labels = {
        STARTING = "LEVELING & GEAR ROUTES",
        WORLD_PVP = "WORLD PVP TARGETS",
        TRAVEL = "DUNGEONS, ARTISAN & EVENTS",
    },
}

ns.Bracket39ExplorationData = {
    HORDE = {
        {group="STARTING",mapID=1424,name="Hillsbrad Foothills",levels="20-35",note="Finish the Tarren Mill, Alterac and Scarlet Monastery approaches before the final level."},
        {group="STARTING",mapID=1441,name="Thousand Needles",levels="25-35",note="Reveal Freewind Post and the Shimmering Flats quest and profession routes."},
        {group="STARTING",mapID=1417,name="Arathi Highlands",levels="30-40",note="Prepare Hammerfall, Stromgarde, Arathi Basin and the Horde Artisan First Aid route."},
        {group="STARTING",mapID=1443,name="Desolace",levels="30-40",note="Reveal Shadowprey, Maraudon approaches and the Artisan Fishing quest coast."},
        {group="STARTING",mapID=1445,name="Dustwallow Marsh",levels="35-45",note="Prepare Brackenwall, Theramore, Nat Pagle and central road routes."},
        {group="STARTING",mapID=1418,name="Badlands",levels="35-45",note="Reveal Kargath and every Uldaman approach used by level-39 gear runs."},

        {group="WORLD_PVP",mapID=1434,name="Stranglethorn Vale",levels="30-45",note="Core contested route for arena, fishing, quests and level-39 traffic."},
        {group="WORLD_PVP",mapID=1437,name="Wetlands",levels="20-30",note="Alliance Menethil and Dun Modr traffic remains a lower-risk target route; avoid guards."},
        {group="WORLD_PVP",mapID=1431,name="Duskwood",levels="18-30",note="Alliance traffic crosses Darkshire, Raven Hill and the Stranglethorn road."},
        {group="WORLD_PVP",mapID=1416,name="Alterac Mountains",levels="30-40",note="Alliance and Horde routes converge around elite areas and the Hillsbrad roads."},
        {group="WORLD_PVP",mapID=1444,name="Feralas",levels="40-50",note="Artisan Fishing and travel routes create high-risk cross-faction traffic."},
        {group="WORLD_PVP",mapID=1446,name="Tanaris",levels="40-50",note="Gadgetzan, Zul'Farrak and Engineering routes make this a major level-39 destination."},

        {group="TRAVEL",mapID=1435,name="Swamp of Sorrows",levels="35-45",note="Prepare Stonard, the eastern fishing coast and Sunken Temple approaches."},
        {group="TRAVEL",mapID=1425,name="The Hinterlands",levels="40-50",note="Reveal Revantusk, profession routes and high-risk gear or reputation destinations."},
        {group="TRAVEL",mapID=1427,name="Searing Gorge",levels="43-50",note="High-risk Thorium and Blackrock travel preparation; use an escort."},
        {group="TRAVEL",mapID=1428,name="Burning Steppes",levels="50-58",note="Optional Blackrock and future travel preparation with extreme mob danger."},
        {group="TRAVEL",mapID=1447,name="Azshara",levels="45-55",note="Optional profession, fishing and rare-route preparation; explore only with protection."},
        {group="TRAVEL",mapID=1451,name="Silithus",levels="55-60",note="Optional endgame preparation; extreme risk and no normal level-39 combat route."},
    },
    ALLIANCE = {
        {group="STARTING",mapID=1437,name="Wetlands",levels="20-30",note="Finish Menethil, Dun Modr and the Arathi or Badlands connections."},
        {group="STARTING",mapID=1431,name="Duskwood",levels="18-30",note="Reveal Darkshire, Raven Hill and the Stranglethorn road before the final level."},
        {group="STARTING",mapID=1417,name="Arathi Highlands",levels="30-40",note="Prepare Stromgarde, Arathi Basin and the Alliance First Aid book route."},
        {group="STARTING",mapID=1443,name="Desolace",levels="30-40",note="Reveal Nijel's Point, Maraudon approaches and the Artisan Fishing quest coast."},
        {group="STARTING",mapID=1445,name="Dustwallow Marsh",levels="35-45",note="Prepare Theramore, Nat Pagle and the Alliance Artisan First Aid route."},
        {group="STARTING",mapID=1418,name="Badlands",levels="35-45",note="Reveal every Uldaman approach and the Loch Modan connection."},

        {group="WORLD_PVP",mapID=1434,name="Stranglethorn Vale",levels="30-45",note="Core contested route for arena, fishing, quests and level-39 traffic."},
        {group="WORLD_PVP",mapID=1424,name="Hillsbrad Foothills",levels="20-35",note="The Southshore-Tarren Mill corridor remains a shared world-PvP route."},
        {group="WORLD_PVP",mapID=1441,name="Thousand Needles",levels="25-35",note="Horde traffic crosses Freewind and the Shimmering Flats; avoid settlement guards."},
        {group="WORLD_PVP",mapID=1416,name="Alterac Mountains",levels="30-40",note="Both factions cross the elite areas and Hillsbrad approaches."},
        {group="WORLD_PVP",mapID=1444,name="Feralas",levels="40-50",note="Artisan Fishing and travel routes create high-risk cross-faction traffic."},
        {group="WORLD_PVP",mapID=1446,name="Tanaris",levels="40-50",note="Gadgetzan, Zul'Farrak and Engineering routes make this a major level-39 destination."},

        {group="TRAVEL",mapID=1435,name="Swamp of Sorrows",levels="35-45",note="Prepare the eastern Artisan Fishing coast and Sunken Temple approaches."},
        {group="TRAVEL",mapID=1425,name="The Hinterlands",levels="40-50",note="Reveal Aerie Peak, profession routes and high-risk gear destinations."},
        {group="TRAVEL",mapID=1427,name="Searing Gorge",levels="43-50",note="High-risk Thorium and Blackrock travel preparation; use an escort."},
        {group="TRAVEL",mapID=1428,name="Burning Steppes",levels="50-58",note="Optional Blackrock and future travel preparation with extreme mob danger."},
        {group="TRAVEL",mapID=1447,name="Azshara",levels="45-55",note="Optional profession, fishing and rare-route preparation; explore only with protection."},
        {group="TRAVEL",mapID=1451,name="Silithus",levels="55-60",note="Optional endgame preparation; extreme risk and no normal level-39 combat route."},
    },
}
