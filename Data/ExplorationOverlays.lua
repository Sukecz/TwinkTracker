local addonName, ns = ...

-- Complete visible-map overlay signatures for the Exploration routes.
-- Source: Blizzard DB2 tables UiMapXMapArt and WorldMapOverlay from
-- Classic Era 1.15.9.69109. A signature is width:height:offsetX:offsetY,
-- matching C_MapExplorationInfo.GetExploredMapTextures() results.
-- These overlays measure map reveal, not every possible exploration XP trigger.
ns.ExplorationOverlayData = {
    [1411] = {
        "128:110:464:33", "160:120:413:476", "160:190:474:384", "190:180:462:286",
        "190:200:327:60", "200:240:549:427", "210:160:427:78", "215:215:355:320",
        "220:230:432:170", "230:230:301:189", "445:160:244:0",
    },
    [1412] = {
        "128:120:473:260", "128:155:379:242", "128:205:303:307", "170:128:458:369",
        "185:128:291:0", "205:128:395:0", "205:230:502:16", "210:180:255:214",
        "215:240:428:80", "225:235:532:238", "256:190:523:356", "256:200:367:303",
        "280:240:249:59", "470:243:270:425",
    },
    [1413] = {
        "95:100:581:247", "100:165:564:52", "115:110:507:294", "120:110:555:0",
        "120:125:384:115", "125:115:492:63", "125:125:556:189", "125:165:442:298",
        "128:100:412:0", "128:105:419:63", "128:128:306:130", "128:128:341:537",
        "128:128:431:479", "140:128:498:119", "145:125:365:350", "150:120:527:307",
        "155:115:407:553", "155:128:335:462", "155:128:481:211", "155:155:431:118",
        "170:120:456:0", "175:185:365:177", "200:145:317:29", "200:185:340:234",
        "210:150:355:402",
    },
    [1420] = {
        "128:158:537:299", "150:128:474:327", "173:128:694:289", "174:220:497:145",
        "175:247:689:104", "186:128:395:277", "201:288:587:139", "211:189:746:125",
        "216:179:630:326", "230:205:698:362", "237:214:757:205", "243:199:363:349",
        "245:205:227:328", "256:156:239:250", "256:210:335:139", "315:235:463:361",
    },
    [1421] = {
        "140:125:391:446", "160:170:470:261", "165:185:382:252", "175:165:402:65",
        "180:128:323:128", "180:185:457:144", "185:165:286:37", "210:160:352:168",
        "210:215:379:447", "220:160:364:359", "240:180:491:417", "240:240:494:262",
        "250:215:593:74", "256:160:465:0", "256:220:459:13",
    },
    [1424] = {
        "125:100:109:482", "165:200:175:275", "205:155:414:154", "215:240:541:236",
        "220:310:509:0", "230:320:524:339", "235:270:418:201", "240:275:637:294",
        "285:155:208:368", "288:225:2:192", "305:275:198:155", "384:365:605:75",
    },
    [1426] = {
        "115:115:252:249", "125:125:217:287", "128:120:792:279", "128:128:573:280",
        "128:165:502:221", "128:165:759:173", "128:180:281:167", "128:190:347:163",
        "150:128:295:385", "155:128:522:322", "155:170:694:273", "165:165:608:291",
        "180:128:274:296", "180:165:166:184", "200:185:314:311", "200:200:386:294",
        "240:185:155:403", "315:200:397:163",
    },
    [1429] = {
        "225:220:422:332", "240:220:250:270", "255:250:551:292", "256:210:704:330",
        "256:237:425:431", "256:240:238:428", "256:249:577:419", "256:256:381:147",
        "256:341:124:327", "306:233:696:435", "310:256:587:190", "485:405:0:0",
    },
    [1431] = {
        "160:330:19:132", "195:145:102:302", "200:175:653:120", "220:220:690:353",
        "220:340:504:117", "235:250:390:382", "250:230:539:369", "255:285:243:348",
        "275:250:55:342", "315:280:631:162", "350:300:85:149", "360:420:298:79",
        "910:210:89:31",
    },
    [1432] = {
        "195:250:109:370", "230:300:125:12", "235:270:229:11", "255:285:215:348",
        "256:230:217:203", "290:175:339:11", "295:358:309:310", "315:235:542:48",
        "320:410:352:87", "345:256:482:321", "370:295:546:199",
    },
    [1433] = {
        "235:270:399:129", "250:250:654:161", "255:300:500:215", "275:256:277:0",
        "320:210:595:320", "340:195:83:197", "365:245:121:72", "365:350:0:284",
        "430:290:187:333", "465:255:484:361", "535:275:133:240",
    },
    [1434] = {
        "90:80:241:92", "90:115:211:359", "95:95:299:88", "95:95:350:335",
        "105:110:311:131", "105:125:387:64", "110:105:260:132", "110:110:306:301",
        "110:140:371:129", "115:115:156:42", "120:120:345:276", "125:120:314:493",
        "125:125:280:368", "125:140:196:3", "128:125:331:59", "128:125:364:231",
        "128:175:432:94", "140:110:269:26", "145:128:203:433", "155:150:388:0",
        "165:175:194:284", "165:190:229:422", "170:90:284:0", "170:125:394:212",
        "190:175:152:90", "200:185:235:189", "245:220:483:8",
    },
    [1435] = {
        "215:365:724:120", "235:205:171:145", "240:245:0:262", "245:305:0:140",
        "256:668:746:0", "275:240:129:236", "300:275:565:218", "315:235:286:110",
        "345:250:552:378", "360:315:279:237", "365:305:492:0",
    },
    [1436] = {
        "165:200:488:0", "195:240:442:241", "200:185:208:375", "200:240:524:252",
        "210:215:387:11", "215:215:307:29", "220:200:317:331", "225:205:328:148",
        "225:210:459:105", "225:256:220:102", "256:175:339:418", "280:190:205:467",
        "288:235:523:377", "305:210:204:260",
    },
    [1437] = {
        "175:128:13:314", "185:240:456:125", "190:160:628:176", "195:185:247:205",
        "200:185:349:115", "200:240:237:41", "205:180:401:21", "205:245:527:264",
        "225:185:347:218", "225:190:89:142", "230:190:470:371", "240:175:77:245",
        "256:250:507:115", "300:240:92:82", "350:360:611:230",
    },
    [1438] = {
        "128:100:494:548", "128:190:335:313", "160:210:382:281", "170:240:272:127",
        "180:256:377:93", "185:128:368:443", "190:128:462:323", "200:200:561:292",
        "225:225:491:153", "256:185:436:380", "315:256:101:247",
    },
    [1439] = {
        "150:215:318:162", "170:195:468:85", "175:158:329:510", "175:183:229:485",
        "180:195:365:181", "190:205:324:306", "195:215:510:0", "200:170:305:412",
        "230:190:375:94",
    },
    [1440] = {
        "128:195:131:137", "146:200:856:151", "155:150:260:373", "165:175:189:324",
        "180:245:520:238", "200:160:796:311", "200:205:392:218", "205:185:272:251",
        "210:185:463:141", "215:305:205:38", "220:195:104:259", "225:255:597:258",
        "235:205:547:426", "245:245:19:28", "245:255:713:344", "255:195:203:158",
        "275:240:356:347", "285:185:694:225",
    },
    [1441] = {
        "190:190:31:155", "205:195:259:131", "210:180:205:70", "210:190:357:264",
        "210:195:391:192", "240:220:492:250", "250:240:179:200", "305:310:0:0",
        "320:365:610:300",
    },
    [1442] = {
        "125:86:663:582", "125:125:475:433", "145:107:572:561", "150:150:389:320",
        "190:97:718:571", "200:215:390:145", "225:120:668:515", "230:355:210:234",
        "270:205:247:0", "288:355:457:282", "320:275:553:197",
    },
}

-- Human-readable AreaTable names for each overlay above, in matching order.
-- Some Blizzard overlays reveal several adjacent named areas together.
ns.ExplorationOverlayNames = {
    [1411] = {
        "Skull Rock", "Kolkar Crag", "Sen'jin Village", "Tiragarde Keep", "Thunder Ridge", "Echo Isles",
        "Drygulch Ravine / Razorwind Canyon", "Valley of Trials", "Razor Hill", "Razormane Grounds",
        "Orgrimmar",
    },
    [1412] = {
        "Ravaged Caravan", "Thunderhorn Water Well", "Palemane Rock", "Winterhoof Water Well",
        "Wildmane Water Well", "Windfury Ridge", "Red Rocks", "Bael'dun Digsite", "The Golden Plains",
        "The Venture Co. Mine", "The Rolling Plains", "Bloodhoof Village", "Thunder Bluff",
        "Red Cloud Mesa / Camp Narache",
    },
    [1413] = {
        "The Merchant Coast", "Far Watch Post", "Raptor Grounds", "Boulder Lode Mine", "The Forgotten Pools",
        "Grol'dom Farm", "Ratchet", "Bramblescar", "The Mor'shan Rampart", "Dreadmist Peak", "Honor's Stand",
        "Razorfen Kraul", "Bael Modan", "Thorn Hill", "Camp Taurajo", "Northwatch Hold", "Razorfen Downs",
        "Blackthorn Ridge", "The Stagnant Oasis", "The Crossroads", "The Sludge Fen", "Lushwater Oasis",
        "The Dry Hills", "Agama'gor", "Field of Giants",
    },
    [1420] = {
        "Brill", "Cold Hearth Manor", "Crusader Outpost", "Garren's Haunt", "Scarlet Watch Post",
        "Stillwater Pond", "Brightwater Lake", "Whispering Gardens / Terrace of Repose", "Balnir Farmstead",
        "The Bulwark", "Venomweb Vale", "Nightmare Vale", "Deathknell", "Solliden Farmstead",
        "Agamand Mills", "Undercity",
    },
    [1421] = {
        "Pyrewood Village", "Deep Elem Mine", "Olsen's Farthing", "The Dead Field", "North Tide's Hollow",
        "The Decrepit Ferry", "The Skittering Dark", "The Sepulcher", "The Greymane Wall", "Shadowfang Keep",
        "Beren's Peril", "Ambermill", "Fenris Isle / The Dawning Isles", "Malden's Orchard / The Ivar Patch",
        "The Shining Strand / Valgan's Field",
    },
    [1424] = {
        "Purgation Isle", "Azurelode Mine", "Darrow Hill", "Nethander Stead", "Tarren Mill",
        "Eastern Strand", "Southshore", "Dun Garok", "Western Strand", "Southpoint Tower",
        "Hillsbrad Fields", "Durnholde Keep",
    },
    [1426] = {
        "Brewnall Village", "Frostmane Hold", "South Gate Outpost", "Amberstill Ranch", "Misty Pine Refuge",
        "North Gate Outpost", "Iceflow Lake", "Shimmer Ridge", "Coldridge Pass", "The Tundrid Hills",
        "Helm's Bed Lake / Ironband's Compound", "Gol'Bolar Quarry", "Chill Breeze Valley", "Gnomeregan",
        "The Grizzled Den", "Kharanos / Steelgrill's Depot", "Coldridge Valley / Anvilmar",
        "Gates of Ironforge",
    },
    [1429] = {
        "Crystal Lake", "Goldshire", "Tower of Azora / Jasperlode Mine", "Eastvale Logging Camp",
        "Jerod's Landing", "Fargodeep Mine / The Stonefield Farm / The Maclure Vineyards",
        "Brackwell Pumpkin Patch", "Northshire Valley", "Forest's Edge / Westbrook Garrison",
        "Ridgepoint Tower", "Stone Cairn Lake", "Stormwind City",
    },
    [1431] = {
        "The Hushed Bank", "Raven Hill", "Manor Mistmantle", "Tranquil Gardens Cemetery", "Brightwood Grove",
        "The Yorgen Farmstead", "The Rotting Orchard", "Vul'Gol Ogre Mound", "Addle's Stead",
        "Darkshire / Beggar's Haunt", "Raven Hill Cemetery / Forlorn Rowe", "Twilight Grove",
        "The Darkened Bank",
    },
    [1432] = {
        "Valley of Kings", "North Gate Pass / Algaz Station", "Silver Stream Mine", "Stonesplinter Valley",
        "Thelsamar", "Stonewrought Dam", "Grizzlepaw Ridge", "Mo'grosh Stronghold", "The Loch",
        "Ironband's Excavation Site", "The Farstrider Lodge",
    },
    [1433] = {
        "Alther's Mill", "Galardell Valley / Tower of Ilgalar", "Stonewatch / Stonewatch Tower",
        "Render's Camp / Render's Rock", "Stonewatch Falls", "Lakeshire",
        "Redridge Canyons / Rethban Caverns", "Three Corners", "Lakeridge Highway", "Render's Valley",
        "Lake Everstill",
    },
    [1434] = {
        "Bal'lal Ruins", "Nek'mani Wellspring", "Kal'ai Ruins", "Ruins of Aboraz", "Mizjah Ruins",
        "Venture Co. Base Camp", "Grom'gol Base Camp", "Ruins of Jubuwal", "Balia'mah Ruins",
        "Zuuldaia Ruins", "Crystalvein Mine", "Jaguero Isle", "Mistvale Valley", "Ruins of Zul'Kunda",
        "Lake Nazferiti", "Ziata'jai Ruins", "Mosh'Ogg Ogre Mound", "Nesingwary's Expedition",
        "Booty Bay / Janeiro's Point", "Kurzen's Compound", "Bloodsail Compound", "Wild Shore", "Rebel Camp",
        "Ruins of Zul'Mamwe", "The Vile Reef", "Gurubashi Arena", "Zul'Gurub",
    },
    [1435] = {
        "Sorrowmurk", "The Harborage", "Itharius's Cave", "Misty Valley",
        "Misty Reed Strand / Misty Reed Post", "Splinterspear Junction", "Pool of Tears",
        "The Shifting Mire", "Stagalbog", "Stonard", "Fallow Sanctuary",
    },
    [1436] = {
        "The Jansen Stead", "Sentinel Hill", "Demont's Place", "The Dead Acre", "Furlbrow's Pumpkin Farm",
        "Jangolode Mine", "Moonbrook / Stendel's Pond", "The Molsen Farm", "Saldean's Farm",
        "Gold Coast Quarry", "The Dagger Hills", "Westfall Lighthouse", "The Dust Plains",
        "Alexston Farmstead",
    },
    [1437] = {
        "Menethil Harbor", "The Green Belt", "Raptor Ridge", "Whelgar's Excavation Site", "Ironbeard's Tomb",
        "Saltspray Glen", "Dun Modr", "Mosshide Fen", "Angerfang Encampment", "Bluegill Marsh",
        "Thelgen Rock / Dun Algaz", "Black Channel Marsh", "Direforge Hill", "Sundown Marsh",
        "Dragonmaw Gates / Grim Batol",
    },
    [1438] = {
        "Rut'theran Village", "Pools of Arlithrien", "Ban'ethil Hollow", "The Oracle Glade",
        "Wellspring Lake / Wellspring River", "Gnarlpine Hold", "Dolanaar", "Starbreeze Village",
        "Shadowglen", "Lake Al'Ameth", "Darnassus",
    },
    [1439] = {
        "Auberdine", "Tower of Althalaxx", "The Master's Glaive", "Remtravel's Excavation", "Bashal'Aran",
        "Ameth'Aran", "Ruins of Mathystra", "Grove of the Ancients", "Cliffspring River / Cliffspring Falls",
    },
    [1440] = {
        "Lake Falathim", "Bough Shadow", "The Ruins of Stardust", "Fire Scar Shrine", "Raynewood Retreat",
        "Warsong Lumber Camp", "Iris Lake", "Astranaar", "The Howling Vale", "Maestra's Post",
        "The Shrine of Aessina", "Night Run / Splintertree Post",
        "Fallen Sky Lake / The Dor'Danil Barrow Den", "The Zoram Strand", "Felfire Hill",
        "Thistlefur Village", "Mystral Lake / Silverwind Refuge / Greenpaw Village", "Satyrnaar",
    },
    [1441] = {
        "Highperch", "Darkcloud Pinnacle", "The Great Lift", "Freewind Post", "Splithoof Crag",
        "Windbreak Canyon", "The Screeching Canyon", "Camp E'thok / Whitereach Post", "The Shimmering Flats",
    },
    [1442] = {
        "Malaka'jin", "Sishir Canyon", "Boulderslide Ravine", "Sun Rock Retreat", "Camp Aparaje",
        "Mirkfallon Lake", "Grimtotem Post", "The Charred Vale", "Stonetalon Peak", "Webwinder Path",
        "Windshear Crag / The Talondeep Path",
    },
}
