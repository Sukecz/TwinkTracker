local output = {}
local originalPrint = print
print = function(message) output[#output+1] = message end

SlashCmdList = {}
SLASH_OTHER1 = "/tt"

local toggles = 0
local ns = {
    MainWindow = {
        Toggle = function() toggles = toggles + 1 end,
    },
}

assert(loadfile("SlashCommands.lua"))("TwinkTracker",ns)
ns:RegisterSlashCommands()

assert(SLASH_TWINKTRACKER1=="/twinktracker")
assert(SLASH_TWINKTRACKER2=="/tt")
assert(SLASH_TWINKTRACKER3=="/twink")
assert(SLASH_TWINKTRACKER4=="/twt")
assert(type(SlashCmdList.TWINKTRACKER)=="function")

SlashCmdList.TWINKTRACKER("")
assert(toggles==1)
assert(#output==1 and string.find(output[1],"/twt",1,true))

print = originalPrint
print("test_slash_commands.lua: ok")
