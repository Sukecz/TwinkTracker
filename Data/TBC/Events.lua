local addonName, ns = ...

-- TBC Anniversary uses a four-week battleground holiday rotation and a
-- three-location Darkmoon Faire rotation. Keep this profile separate from Era
-- so a calendar correction in one client cannot silently change the other.
local shared = ns.EventTimersData.events

ns.EventTimersData = {
    version = "2026-08-13-tbc",
    order = { "BATTLEGROUND", "FISHING", "GURUBASHI", "DARKMOON", "SEASONAL" },
    events = {
        BATTLEGROUND = {
            kind = "ROTATION",
            name = "BATTLEGROUND BONUS WEEKEND",
            category = "PVP  •  BURNING CRUSADE CLASSIC",
            icon = "Interface\\Icons\\INV_BannerPVP_02",
            anchor = { year=2026, month=7, day=31, hour=0, minute=0 },
            frequencyDays = 7,
            durationDays = 3,
            rotation = {
                { name="WARSONG GULCH BONUS WEEKEND", icon="Interface\\Icons\\Spell_Misc_WarsongFocus" },
                { name="ARATHI BASIN BONUS WEEKEND", icon="Interface\\Icons\\INV_Jewelry_Amulet_07" },
                { name="ALTERAC VALLEY BONUS WEEKEND", icon="Interface\\Icons\\INV_Jewelry_StormPikeTrinket_01" },
                { name="EYE OF THE STORM BONUS WEEKEND", icon="Interface\\Icons\\Spell_Nature_EyeOfTheStorm" },
            },
            note = "Four-week TBC Anniversary rotation: WSG, AB, AV, then Eye of the Storm. Confirm emergency calendar changes in the live client.",
        },
        FISHING = shared.FISHING,
        GURUBASHI = shared.GURUBASHI,
        DARKMOON = {
            kind = "DARKMOON",
            name = "DARKMOON FAIRE",
            category = "MONTHLY  •  ELWYNN / MULGORE / TEROKKAR",
            icon = "Interface\\Icons\\INV_Misc_Ticket_Darkmoon_01",
            locations = { "ELWYNN FOREST", "MULGORE", "TEROKKAR FOREST" },
            locationAnchor = { year=2026, month=8, index=2 },
            note = "The TBC Faire rotates through Elwynn, Mulgore and Terokkar. Setup starts on the first Friday; opening is the following Monday.",
        },
        SEASONAL = shared.SEASONAL,
    },
}

ns.EventTimersData.events.FISHING.category = "FISHING  •  STRANGLETHORN VALE"
ns.EventTimersData.events.SEASONAL.category = "BURNING CRUSADE CLASSIC HOLIDAY"
ns.EventTimersData.events.SEASONAL.note = "Shows the next tracked TBC holiday or its live time remaining. Future dates remain planning estimates until Blizzard publishes them."
