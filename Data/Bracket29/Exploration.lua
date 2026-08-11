local addonName, ns = ...

ns.Bracket29ExplorationCategories = {
    order = { "STARTING", "WORLD_PVP", "TRAVEL" },
    labels = {
        STARTING = "LEVELING & GEAR ROUTES",
        WORLD_PVP = "WORLD PVP TARGETS",
        TRAVEL = "DUNGEONS, REPUTATION & EVENTS",
    },
}

ns.Bracket29ExplorationData = {
    HORDE = {
        { group="STARTING", mapID=1413, name="The Barrens", levels="10-25", note="Reveal Ratchet, the southern roads and dungeon approaches before the final level." },
        { group="STARTING", mapID=1421, name="Silverpine Forest", levels="10-20", note="Finish the Shadowfang Keep route and Hillsbrad connection before XP becomes locked by planning." },
        { group="STARTING", mapID=1442, name="Stonetalon Mountains", levels="15-27", note="Cover Sun Rock Retreat, the Venture Co. roads and the Ashenvale connections." },
        { group="STARTING", mapID=1440, name="Ashenvale", levels="18-30", note="Reveal the Warsong, Zoram Strand and Astranaar approaches used by PvP and dungeon travel." },
        { group="STARTING", mapID=1441, name="Thousand Needles", levels="25-35", note="Complete the Shimmering Flats and Freewind routes needed by several level-29 quest chains." },
        { group="STARTING", mapID=1424, name="Hillsbrad Foothills", levels="20-35", note="Reveal Tarren Mill, the Southshore corridor and Alterac approaches while kills can still be budgeted." },

        { group="WORLD_PVP", mapID=1437, name="Wetlands", levels="20-30", note="Alliance transit and quest traffic follows the Menethil and Dun Modr roads; avoid settlement guards." },
        { group="WORLD_PVP", mapID=1431, name="Duskwood", levels="18-30", note="Level-29 Alliance traffic concentrates around Darkshire, Raven Hill and the main roads." },
        { group="WORLD_PVP", mapID=1433, name="Redridge Mountains", levels="15-25", note="Lower-level Alliance traffic remains active around Lakeshire and its road network." },
        { group="WORLD_PVP", mapID=1434, name="Stranglethorn Vale", levels="30-45", note="Core level-29 contest zone for mastery quests, Gurubashi Arena and the Fishing Extravaganza." },
        { group="WORLD_PVP", mapID=1417, name="Arathi Highlands", levels="30-40", note="Contested roads, profession-book travel and Arathi Basin access make this a recurring destination." },
        { group="WORLD_PVP", mapID=1443, name="Desolace", levels="30-40", note="Alliance travel and quest routes cross the central roads; explore with an escort before 29." },

        { group="TRAVEL", mapID=1418, name="Badlands", levels="35-45", note="Prepare the Uldaman and eastern travel routes before the bracket locks out safe exploration XP." },
        { group="TRAVEL", mapID=1435, name="Swamp of Sorrows", levels="35-45", note="Useful eastern-continent shortcut and dungeon travel corridor; hostile mobs make advance exploration important." },
        { group="TRAVEL", mapID=1416, name="Alterac Mountains", levels="30-40", note="Reveal the Hillsbrad connections and elite areas before using the zone for travel or world PvP." },
        { group="TRAVEL", mapID=1445, name="Dustwallow Marsh", levels="35-45", note="Prepare the Brackenwall, Theramore and Onyxia-road corridors used by vendors and travel." },
        { group="TRAVEL", mapID=1425, name="The Hinterlands", levels="40-50", note="High-risk reputation and travel preparation; use an escort and finish discovery XP before 29." },
    },
    ALLIANCE = {
        { group="STARTING", mapID=1436, name="Westfall", levels="10-20", note="Finish the Deadmines and coastal routes before moving into the higher bracket zones." },
        { group="STARTING", mapID=1432, name="Loch Modan", levels="10-20", note="Reveal both loch roads and the Wetlands and Badlands connections." },
        { group="STARTING", mapID=1439, name="Darkshore", levels="10-20", note="Complete the Auberdine coast and Ashenvale connection before final XP planning." },
        { group="STARTING", mapID=1433, name="Redridge Mountains", levels="15-25", note="Reveal Lakeshire, the eastern road and dungeon or quest-chain approaches." },
        { group="STARTING", mapID=1431, name="Duskwood", levels="18-30", note="Cover Darkshire, Raven Hill and the Stranglethorn connection while discovery XP is still budgeted." },
        { group="STARTING", mapID=1437, name="Wetlands", levels="20-30", note="Prepare Menethil, Dun Modr and the northern road network used by level-29 travel." },

        { group="WORLD_PVP", mapID=1413, name="The Barrens", levels="10-25", note="Horde roads and dungeon traffic remain active; Alliance is auto-flagged and must avoid town guards." },
        { group="WORLD_PVP", mapID=1442, name="Stonetalon Mountains", levels="15-27", note="Check the Barrens border, Sun Rock approaches and contested road intersections." },
        { group="WORLD_PVP", mapID=1440, name="Ashenvale", levels="18-30", note="Warsong, Zoram Strand and the Barrens roads provide level-29 cross-faction traffic." },
        { group="WORLD_PVP", mapID=1424, name="Hillsbrad Foothills", levels="20-35", note="The Tarren Mill-Southshore corridor is a shared level-29 world-PvP route; avoid guards." },
        { group="WORLD_PVP", mapID=1441, name="Thousand Needles", levels="25-35", note="Horde quest traffic uses Freewind and the Shimmering Flats; grouped travel is recommended." },
        { group="WORLD_PVP", mapID=1443, name="Desolace", levels="30-40", note="Horde travel crosses the central roads and settlement approaches; explore before the final level." },

        { group="TRAVEL", mapID=1434, name="Stranglethorn Vale", levels="30-45", note="Core level-29 route for mastery quests, Gurubashi Arena and the Fishing Extravaganza." },
        { group="TRAVEL", mapID=1417, name="Arathi Highlands", levels="30-40", note="Prepare profession-book, Arathi Basin and eastern travel routes before level 29." },
        { group="TRAVEL", mapID=1418, name="Badlands", levels="35-45", note="Reveal the Uldaman and Loch Modan routes early; mobs are dangerous to a level-29 character." },
        { group="TRAVEL", mapID=1445, name="Dustwallow Marsh", levels="35-45", note="Prepare Theramore, Brackenwall and the southern road network with an escort." },
    },
}
