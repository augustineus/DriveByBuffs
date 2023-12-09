DriveBy = LibStub("AceAddon-3.0"):NewAddon("DriveBy", "AceConsole-3.0", "AceEvent-3.0")

-- double checking that the addon works
-- ideas for dev
-- using either a spell name to trace back to any spell id, or using the combat log, target the player that cast the spell then use a bank of emotes to emote back at them

-- called when addon is loaded
function DriveBy:OnInitialize()
	self:Print("Thanks for using DriveBy!")
end

-- called when started
function DriveBy:OnEnable()
	self:Print("DriveBy RP Started")
end

--create a hidden frame
local f = CreateFrame("Frame");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- define player name
local playerGUID = UnitGUID("player")

-- create bank of emotes
local emotes = {"AMAZE", "APPLAUD", "BASHFUL", "BLUSH", "BOW", "BURP", "CHEER", "CLAP", "FART", "HAIL", "HAPPY", "HUG", "KISS", "SALUTE", "SEXY", "THANK", "CUDDLE", "PRAISE", "COMMEND", "FLIRT"}
function randEmote()
	return emotes[math.random(1, #emotes)]
end

--create emote command
f:SetScript("OnEvent", function(self, event)
	local ts, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _, buff = CombatLogGetCurrentEventInfo()

	if buff ~= nil and destGUID == playerGUID and sourceGUID ~= playerGUID then
		DoEmote(randEmote(), sourceGUID)
	end
end)

-- called when turned off
function DriveBy:OnDisable()
	self:Print("DriveBy RP Stopped")
end

-- next steps: open a settings panel to turn off specific emotes, disable party/raid emoting, add your own emotes?