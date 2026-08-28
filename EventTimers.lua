local addonName, ns = ...

local EventTimers = {}
ns.EventTimers = EventTimers

local MONTHS = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" }
local DAY_SECONDS = 86400
local LUNAR_NEW_YEAR = {
    [2026]={2,17}, [2027]={2,6}, [2028]={1,26}, [2029]={2,13}, [2030]={2,3},
    [2031]={1,23}, [2032]={2,11}, [2033]={1,31}, [2034]={2,19}, [2035]={2,8},
}

local function civilDayNumber(year,month,day)
    if month<=2 then year=year-1 end
    local era=math.floor(year/400)
    local yearOfEra=year-era*400
    local shiftedMonth=month+(month>2 and -3 or 9)
    local dayOfYear=math.floor((153*shiftedMonth+2)/5)+day-1
    return era*146097+yearOfEra*365+math.floor(yearOfEra/4)-math.floor(yearOfEra/100)+dayOfYear
end

local function civilDate(dayNumber)
    local era=math.floor(dayNumber/146097)
    local dayOfEra=dayNumber-era*146097
    local yearOfEra=math.floor((dayOfEra-math.floor(dayOfEra/1460)+math.floor(dayOfEra/36524)-math.floor(dayOfEra/146096))/365)
    local year=yearOfEra+era*400
    local dayOfYear=dayOfEra-(365*yearOfEra+math.floor(yearOfEra/4)-math.floor(yearOfEra/100))
    local shiftedMonth=math.floor((5*dayOfYear+2)/153)
    local day=dayOfYear-math.floor((153*shiftedMonth+2)/5)+1
    local month=shiftedMonth+(shiftedMonth<10 and 3 or -9)
    if month<=2 then year=year+1 end
    return { year=year, month=month, day=day }
end

local function calendarSeconds(value)
    return civilDayNumber(value.year,value.month,value.monthDay or value.day)*DAY_SECONDS+(value.hour or 0)*3600+(value.minute or value.min or 0)*60+(value.second or value.sec or 0)
end

local function currentServerCalendar()
    if C_DateAndTime and C_DateAndTime.GetCurrentCalendarTime then
        local value=C_DateAndTime.GetCurrentCalendarTime()
        if value and value.year and value.month and (value.monthDay or value.day) then return value end
    end
    local timestamp=GetServerTime and GetServerTime() or (time and time() or os.time())
    local formatDateTime=date or os.date
    local value=formatDateTime("*t",timestamp)
    value.monthDay=value.day
    return value
end

local function formatRemaining(seconds,precise)
    local days=math.floor(seconds/DAY_SECONDS)
    local hours=math.floor((seconds%DAY_SECONDS)/3600)
    local minutes=math.floor((seconds%3600)/60)
    if days>0 then return string.format("%dD %dH",days,hours) end
    if hours>0 then return precise and string.format("%dH %dM",hours,minutes) or string.format("%dH",hours) end
    if precise and minutes>0 then return string.format("%dM",minutes) end
    return "<1H"
end

local function formatDate(value)
    return string.format("%d %s %02d:%02d",value.day,MONTHS[value.month],value.hour,value.minute)
end

local function statusFromWindow(schedule,now,start,finish,overrides)
    local active=now>=start and now<finish
    local remaining=(active and finish or start)-now
    local startDay=math.floor(start/DAY_SECONDS); local endDay=math.floor(finish/DAY_SECONDS)
    local startDate=civilDate(startDay); startDate.hour=math.floor((start%DAY_SECONDS)/3600); startDate.minute=math.floor((start%3600)/60)
    local endDate=civilDate(endDay); endDate.hour=math.floor((finish%DAY_SECONDS)/3600); endDate.minute=math.floor((finish%3600)/60)
    local result = {
        active = active,
        text = (active and "LIVE  •  ENDS IN " or "STARTS IN ")..formatRemaining(remaining),
        window = formatDate(startDate).." - "..formatDate(endDate).." SERVER TIME",
        refreshIn = math.max(1,math.min((remaining%3600)+1,3600)),
        startsAt = startDate,
        endsAt = endDate,
        name = schedule.name,
        category = schedule.category,
        icon = schedule.icon,
        iconItemID = schedule.iconItemID,
        note = schedule.note,
    }
    for key,value in pairs(overrides or {}) do result[key]=value end
    return result
end

local function intervalStatus(schedule,now)
    local anchorDay=civilDayNumber(schedule.anchor.year,schedule.anchor.month,schedule.anchor.day)
    local anchor=anchorDay*DAY_SECONDS+schedule.anchor.hour*3600+schedule.anchor.minute*60
    local frequency=schedule.frequencyDays*DAY_SECONDS
    local cycle=now<anchor and 0 or math.floor((now-anchor)/frequency)
    local start=anchor+cycle*frequency
    local startDay=math.floor(start/DAY_SECONDS)
    local finish=(startDay+schedule.endDayOffset)*DAY_SECONDS+schedule.endHour*3600+schedule.endMinute*60
    if now>=finish then
        start=start+frequency
        startDay=math.floor(start/DAY_SECONDS)
        finish=(startDay+schedule.endDayOffset)*DAY_SECONDS+schedule.endHour*3600+schedule.endMinute*60
    end
    return statusFromWindow(schedule,now,start,finish)
end

local function rotationStatus(schedule,now)
    local anchor=calendarSeconds(schedule.anchor)
    local frequency=schedule.frequencyDays*DAY_SECONDS
    local cycle=math.floor((now-anchor)/frequency)
    if cycle<0 then cycle=0 end
    local start=anchor+cycle*frequency
    local finish=start+schedule.durationDays*DAY_SECONDS
    if now>=finish then cycle=cycle+1; start=start+frequency; finish=start+schedule.durationDays*DAY_SECONDS end
    local entry=schedule.rotation[(cycle%#schedule.rotation)+1]
    return statusFromWindow(schedule,now,start,finish,{ name=entry.name, icon=entry.icon, iconItemID=entry.iconItemID })
end

local function clockStatus(schedule,now)
    local frequency=schedule.frequencyHours*3600
    local elapsed=now%frequency
    local expectedSeconds=schedule.expectedWindowMinutes*60
    local active=elapsed<expectedSeconds
    local remaining=active and expectedSeconds-elapsed or frequency-elapsed
    return {
        active = active,
        text = active and "EXPECTED NOW" or "EXPECTED IN "..formatRemaining(remaining,true),
        window = "EVERY 3 HOURS FROM 00:00 SERVER TIME",
        refreshIn = math.max(1,math.min(active and remaining or (remaining%60)+1,60)),
        name = schedule.name,
        category = schedule.category,
        icon = schedule.icon,
        iconItemID = schedule.iconItemID,
        note = schedule.note,
    }
end

local function nextMonth(year,month)
    month=month+1
    if month>12 then return year+1,1 end
    return year,month
end

local function darkmoonWindow(year,month)
    local firstDay=civilDayNumber(year,month,1)
    local firstMondayOffset=(5-(firstDay%7)+7)%7
    local startDay=firstDay+firstMondayOffset
    return startDay*DAY_SECONDS+60,(startDay+6)*DAY_SECONDS+23*3600+59*60
end

local function darkmoonStatus(schedule,now,calendar)
    local year,month=calendar.year,calendar.month
    local start,finish=darkmoonWindow(year,month)
    if now>=finish then year,month=nextMonth(year,month); start,finish=darkmoonWindow(year,month) end
    local anchor=schedule.locationAnchor or { year=2026, month=7, index=1 }
    local monthOffset=(year-anchor.year)*12+(month-anchor.month)
    local location=schedule.locations[((anchor.index-1+monthOffset)%#schedule.locations)+1]
    return statusFromWindow(schedule,now,start,finish,{ category="MONTHLY  •  "..location, note="The Faire is currently scheduled for "..location.."." })
end

local function seasonalWindows(schedule,year)
    local values={}
    for _,definition in ipairs(schedule.holidays or {}) do
        local startParts,finishParts
        if definition.lunar then
            local lunar=LUNAR_NEW_YEAR[year]
            if lunar then
                local newYearDay=civilDayNumber(year,lunar[1],lunar[2])
                local startDate=civilDate(newYearDay-1); local endDate=civilDate(newYearDay+13)
                startParts={startDate.year,startDate.month,startDate.day,9,0}
                finishParts={endDate.year,endDate.month,endDate.day,23,59}
            end
        elseif definition.knownYears and definition.knownYears[year] then
            local known=definition.knownYears[year]
            startParts={year,known[1][1],known[1][2],known[1][3],known[1][4]}
            finishParts={year,known[2][1],known[2][2],known[2][3],known[2][4]}
        elseif definition.start then
            startParts={year,definition.start[1],definition.start[2],definition.start[3],definition.start[4]}
            local finishYear=definition.crossesYear and year+1 or year
            finishParts={finishYear,definition.finish[1],definition.finish[2],definition.finish[3],definition.finish[4]}
        end
        if startParts then values[#values+1]={ name=definition.name, icon=definition.icon, start=startParts, finish=finishParts } end
    end
    return values
end

local function partsSeconds(parts)
    return civilDayNumber(parts[1],parts[2],parts[3])*DAY_SECONDS+parts[4]*3600+parts[5]*60
end

local function seasonalStatus(schedule,now,calendar)
    local candidates={}
    for year=calendar.year-1,calendar.year+1 do
        for _,event in ipairs(seasonalWindows(schedule,year)) do
            event.startSeconds=partsSeconds(event.start); event.finishSeconds=partsSeconds(event.finish)
            if now<event.finishSeconds then candidates[#candidates+1]=event end
        end
    end
    table.sort(candidates,function(a,b) return a.startSeconds<b.startSeconds end)
    local event=candidates[1]
    for _,candidate in ipairs(candidates) do if now>=candidate.startSeconds and now<candidate.finishSeconds then event=candidate end end
    return statusFromWindow(schedule,now,event.startSeconds,event.finishSeconds,{ name=event.name, category="NEXT SEASONAL EVENT", icon=event.icon })
end

function EventTimers:GetStatus(key,calendar)
    local schedule=ns.EventTimersData.events[key]
    if not schedule then return nil end
    calendar=calendar or currentServerCalendar()
    local now=calendarSeconds(calendar)
    if schedule.kind=="INTERVAL" then return intervalStatus(schedule,now) end
    if schedule.kind=="ROTATION" then return rotationStatus(schedule,now) end
    if schedule.kind=="CLOCK" then return clockStatus(schedule,now) end
    if schedule.kind=="DARKMOON" then return darkmoonStatus(schedule,now,calendar) end
    if schedule.kind=="SEASONAL" then return seasonalStatus(schedule,now,calendar) end
end
