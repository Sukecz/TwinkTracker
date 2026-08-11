local addonName, ns = ...

ns.Brackets:RegisterData(29, {
    level = 29,
    bis = ns.Bracket29BisData,
    enchants = ns.Bracket29EnchantsData,
    consumables = ns.Bracket29ConsumablesData,
    basics = ns.Bracket29BasicsData,
    guides = ns.Bracket29GuidesData,
    classTiers = ns.Bracket29ClassTiersData,
    pvp = ns.PvPEventsData.brackets[29],
    exploration = ns.Bracket29ExplorationData,
    explorationCategories = ns.Bracket29ExplorationCategories,
    basicsIntro = "The essential Classic Era rule: experience cannot be locked. Prepare every route and XP-bearing reward before level 29.",
})
