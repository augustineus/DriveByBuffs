DriveBy = LibStub("AceAddon-3.0"):NewAddon("DriveBy", "AceConsole-3.0", "AceEvent-3.0")

function DriveBy:OnInitialize()
	self:Print("Thanks for using DriveBy!")
end

function DriveBy:OnEnable()
	self:Print("DriveBy RP Started")
end

local f = CreateFrame("Frame");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local emotes = {"AMAZE", "APPLAUD", "BASHFUL", "BLUSH", "BOW", "BURP", "CHEER", "CLAP", "FART", "HAIL", "HAPPY", "HUG", "KISS", "SALUTE", "SEXY", "THANK", "CUDDLE", "PRAISE", "COMMEND", "FLIRT"}
function randEmote()
	return emotes[math.random(1, #emotes)]
end

local playerGUID = UnitGUID("player")

f:SetScript("OnEvent", function(self, event)
	local ts, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _, buff = CombatLogGetCurrentEventInfo()
	if buff ~= -1 and destGUID == playerGUID and sourceGUID ~= playerGUID then
		DoEmote(randEmote(), sourceName)
	end
end)

function DriveBy:OnDisable()
	self:Print("DriveBy RP Stopped")
end