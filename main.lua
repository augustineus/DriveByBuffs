DriveByBuffs = LibStub("AceAddon-3.0"):NewAddon("DriveByBuffs", "AceConsole-3.0", "AceEvent-3.0")

function DriveByBuffs:OnInitialize()
	self:Print("Thanks for using DriveByBuffs!")
end

function DriveByBuffs:OnEnable()
	self:Print("DriveByBuffs RP Started")
end

function DriveByBuffs:OnDisable()
	self:Print("DriveByBuffs RP Stopped")
end

local function locate(table, value)
	for i = 1, #table do
		if table[i] == value then 
		 return true 
		end
	end
end

local emotes = {"AMAZE", "APPLAUD", "BASHFUL", "BLUSH", "BOW", "BURP", "CHEER", "CLAP", "FART", "HAIL", "HAPPY", "HUG", "KISS", "SALUTE", "SEXY", "THANK", "CUDDLE", "PRAISE", "COMMEND", "FLIRT"}
function randEmote()
	return emotes[math.random(1, #emotes)]
end

local validBuffs = {"Arcane Intellect", "Power Word: Fortitude", "Mark of the Wild", "Thorns", "Blessing of Wisdom", "Blessing of Might", "Blessing of Kings"}

local playerGUID = UnitGUID("player")

local f = CreateFrame("Frame");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
	local ts, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _, buff = CombatLogGetCurrentEventInfo()
	print(CombatLogGetCurrentEventInfo())
	if locate(validBuffs, buff) then 
		if destGUID == playerGUID and sourceGUID ~= playerGUID and subevent == "SPELL_CAST_SUCCESS" then
			DoEmote(randEmote(), sourceName)
		end
	end
end)

