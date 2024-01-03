--[[LEFT OFF NOTES

base addon is complete!

]] 

DriveBy = LibStub("AceAddon-3.0"):NewAddon("DriveBy", "AceConsole-3.0", "AceEvent-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

function DriveBy:OnInitialize()
	self:Print("Thanks for using DriveBy!")
end

local f = CreateFrame("Frame");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local emotes = {"AMAZE", "APPLAUD", "BASHFUL", "BARK", "BLUSH", "BOW", "BURP", "CHEER", "CLAP", "FART", "HAIL", "HAPPY", "HUG", "KISS", "SALUTE", "SEXY", "THANK", "CUDDLE", "PRAISE", "COMMEND", "FLIRT"}
function randEmote()
	return emotes[math.random(1, #emotes)]
end

f:SetScript("OnEvent", function(self, event)
	local ts, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _, buff = CombatLogGetCurrentEventInfo()
	if buff ~= -1 and destGUID == playerGUID and sourceGUID ~= playerGUID then
		DoEmote(randEmote(), sourceName)
	end
end)