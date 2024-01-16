DriveByBuffs = LibStub("AceAddon-3.0"):NewAddon("DriveByBuffs", "AceConsole-3.0", "AceEvent-3.0")

function DriveByBuffs:OnInitialize()
	self:Print("Thanks for using DriveByBuffs!")
end

function DriveByBuffs:OnEnable()
	self:Print("DriveByBuffs RP Started")
end

local f = CreateFrame("Frame");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local emotes = {"AMAZE", "APPLAUD", "BASHFUL", "BLUSH", "BOW", "BURP", "CHEER", "CLAP", "FART", "HAIL", "HAPPY", "HUG", "KISS", "SALUTE", "SEXY", "THANK", "CUDDLE", "PRAISE", "COMMEND", "FLIRT"}
function randEmote()
	return emotes[math.random(1, #emotes)]
end

local validBuffs = {"Arcane Intellect", "Power Word: Fortitude", "Mark of the Wild", "Thorns", "Blessing of Wisdom", "Blessing of Might", "Blessing of Kings"}

local function locate(table, value)
	for i = 1, #table do
		if table[i] == value then 
		 return true 
		end
	end
end

local playerGUID = UnitGUID("player")

f:SetScript("OnEvent", function(self, event)
	local ts, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _, buff = CombatLogGetCurrentEventInfo()
	if locate(validBuffs, buff) then 
		if destGUID == playerGUID and sourceGUID ~= playerGUID then
			DoEmote(randEmote(), sourceName)
		end
	end
end)

function DriveByBuffs:OnDisable()
	self:Print("DriveByBuffs RP Stopped")
end