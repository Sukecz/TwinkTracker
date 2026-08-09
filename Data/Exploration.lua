local addonName, ns = ...

ns.ExplorationCategories = {
    order = { "STARTING", "WORLD_PVP", "TRAVEL" },
    labels = {
        STARTING = "STARTING & CORE ZONES",
        WORLD_PVP = "WORLD PVP TARGETS",
        TRAVEL = "TRAVEL & TWINK EVENTS",
    },
}

ns.ExplorationData = {
    HORDE = {
        { group="STARTING", mapID=1411, name="Durotar", levels="1-10", note="Clear the roads between the Valley of Trials, Sen'jin Village and Orgrimmar." },
        { group="STARTING", mapID=1412, name="Mulgore", levels="1-10", note="Cover the Thunder Bluff approaches and both main roads across the plains." },
        { group="STARTING", mapID=1420, name="Tirisfal Glades", levels="1-10", note="Explore the Brill, Undercity and western road network before leaving the starter route." },
        { group="STARTING", mapID=1413, name="The Barrens", levels="10-25", note="Core Horde travel hub: reveal Crossroads, Ratchet and the north-south road early." },
        { group="STARTING", mapID=1421, name="Silverpine Forest", levels="10-20", note="Reveal the Sepulcher and Shadowfang Keep approach before dungeon and PvP trips." },

        { group="WORLD_PVP", mapID=1433, name="Redridge Mountains", levels="15-25", note="Primary Horde level-19 world-PvP target. Scout Three Corners, Lakeshire approaches and the road toward Render's Valley." },
        { group="WORLD_PVP", mapID=1424, name="Hillsbrad Foothills", levels="20-35", note="Shared level-19 world-PvP destination. The Tarren Mill-Southshore corridor has traffic from both factions; avoid town guards." },
        { group="WORLD_PVP", mapID=1431, name="Duskwood", levels="18-30", note="Alliance leveling traffic makes the roads around Darkshire and the Redridge connection useful, but mobs and guards are dangerous." },
        { group="WORLD_PVP", mapID=1437, name="Wetlands", levels="20-30", note="Alliance transit traffic uses the Menethil road network. Keep clear of Menethil Harbor guards." },

        { group="TRAVEL", mapID=1435, name="Swamp of Sorrows", levels="35-45", note="Travel shortcut into Redridge: use the climb through the northwestern mountains near the spider cave and descend into southwestern Redridge." },
        { group="TRAVEL", mapID=1442, name="Stonetalon Mountains", levels="15-27", note="Contested Barrens connection and an Alliance world-PvP destination; reveal the roads for future cross-faction travel." },
        { group="TRAVEL", mapID=1440, name="Ashenvale", levels="18-30", note="Reveal the Warsong, Zoram and Astranaar approaches for dungeon, travel and cross-faction activity." },
        { group="TRAVEL", mapID=1436, name="Westfall", levels="10-20", note="Optional Alliance-territory route. Residents are not automatically PvP-flagged, so treat this primarily as travel preparation." },
        { group="TRAVEL", mapID=1439, name="Darkshore", levels="10-20", note="Optional Alliance travel corridor with Auberdine traffic; approach settlements carefully." },
        { group="TRAVEL", mapID=1432, name="Loch Modan", levels="10-20", note="Optional Alliance-territory route for future travel; avoid Thelsamar and tower guards." },
        { group="TRAVEL", mapID=1441, name="Thousand Needles", levels="25-35", note="Optional future transit and PvP route; use a group or accept repeated death runs." },
        { group="TRAVEL", mapID=1434, name="Stranglethorn Vale", levels="30-45", note="Twink event route for the Gurubashi Arena and the weekly Fishing Extravaganza. At level 19, use an escort and expect repeated deaths." },
    },
    ALLIANCE = {
        { group="STARTING", mapID=1429, name="Elwynn Forest", levels="1-10", note="Clear the Northshire, Goldshire and Stormwind road network before moving on." },
        { group="STARTING", mapID=1426, name="Dun Morogh", levels="1-10", note="Reveal Coldridge, Kharanos and the Ironforge approaches while the route is safe." },
        { group="STARTING", mapID=1438, name="Teldrassil", levels="1-10", note="Cover Shadowglen, Dolanaar and the Darnassus road before taking the boat route." },
        { group="STARTING", mapID=1436, name="Westfall", levels="10-20", note="Reveal Sentinel Hill, Moonbrook and the Deadmines approach before final XP planning." },
        { group="STARTING", mapID=1432, name="Loch Modan", levels="10-20", note="Cover Thelsamar and both sides of the loch while completing early travel." },
        { group="STARTING", mapID=1439, name="Darkshore", levels="10-20", note="Reveal Auberdine, the coast road and the Ashenvale connection before level 19." },

        { group="WORLD_PVP", mapID=1442, name="Stonetalon Mountains", levels="15-27", note="Primary Alliance level-19 world-PvP target. Check the Barrens border, Venture Co. intersection and roads around Sun Rock Retreat." },
        { group="WORLD_PVP", mapID=1413, name="The Barrens", levels="10-25", note="Major Alliance level-19 world-PvP route with Horde leveling traffic. Alliance is auto-flagged here, but Horde residents must choose PvP or engage first; check the Stonetalon border and avoid Crossroads guards." },
        { group="WORLD_PVP", mapID=1424, name="Hillsbrad Foothills", levels="20-35", note="Shared level-19 world-PvP destination. Check the Silverpine border and Tarren Mill-Southshore corridor while avoiding guards." },
        { group="WORLD_PVP", mapID=1440, name="Ashenvale", levels="18-30", note="Alliance world-PvP route around Maestra's Post, Zoram Strand and the roads toward the Barrens." },
        { group="WORLD_PVP", mapID=1421, name="Silverpine Forest", levels="10-20", note="Horde leveling and Shadowfang Keep traffic make the Hillsbrad border useful. Alliance is auto-flagged, while Horde residents must choose PvP or engage first; avoid the Sepulcher guards." },
        { group="WORLD_PVP", mapID=1441, name="Thousand Needles", levels="25-35", note="Higher-risk Horde travel and leveling route. Grouped exploration or death runs are strongly recommended." },

        { group="TRAVEL", mapID=1433, name="Redridge Mountains", levels="15-25", note="Core Alliance leveling route and a Horde world-PvP target. Reveal Lakeshire and its approaches before level 19." },
        { group="TRAVEL", mapID=1431, name="Duskwood", levels="18-30", note="Reveal Darkshire and the main roads before 19; higher mobs and visiting Horde add risk." },
        { group="TRAVEL", mapID=1437, name="Wetlands", levels="20-30", note="Important Menethil and Kalimdor transit route; reveal its roads early." },
        { group="TRAVEL", mapID=1434, name="Stranglethorn Vale", levels="30-45", note="Twink event route for the Gurubashi Arena and the weekly Fishing Extravaganza. At level 19, use an escort and expect repeated deaths." },
    },
}
