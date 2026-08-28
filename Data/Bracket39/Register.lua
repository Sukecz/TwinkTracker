local addonName, ns = ...

ns.Brackets:RegisterData(39, {
    level = 39,
    bis = ns.Bracket39BisData,
    enchants = ns.Bracket39EnchantsData,
    consumables = ns.Bracket39ConsumablesData,
    basics = ns.Bracket39BasicsData,
    guides = ns.Bracket39GuidesData,
    classTiers = ns.Bracket39ClassTiersData,
    pvp = ns.PvPEventsData.brackets[39],
    exploration = ns.Bracket39ExplorationData,
    explorationCategories = ns.Bracket39ExplorationCategories,
    basicsIntro = "The essential Classic Era rule: experience cannot be locked. Complete Artisan profession and gear routes before level 39.",
})
