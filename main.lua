DriveByBuffs = LibStub("AceAddon-3.0"):NewAddon("DriveByBuffs", "AceConsole-3.0", "AceEvent-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

local function locate(table, value)
	for i = 1, #table do
		if table[i] == value then 
		 return true 
		end
	end
end

function DriveByBuffs:OnInitialize()
	self:Print("Thanks for using DriveByBuffs!")
	self:RegisterChatCommand("dbb", "SlashCommand")
	allEmoteOptions()
end

function DriveByBuffs:OnEnable()
	self:Print("DriveByBuffs RP Started")
end

function DriveByBuffs:OnDisable()
	self:Print("DriveByBuffs RP Stopped")
end

local options = {
	name = "DriveByBuffs",
	handler = DriveByBuffs,
	type = "group",
	args = {
		msg = {
			type = "input",
			name = "Message",
			desc = "The message to be displayed when you get home.",
			usage = "<Your message>",
			get = "GetMessage",
			set = "SetMessage",
		},
		showOnScreen = {
			type = "toggle",
			name = "Show on Screen",
			desc = "Toggles the display of the message on the screen.",
			get = "IsShowOnScreen",
			set = "ToggleShowOnScreen"
		},
	},
}

function DriveBy:GetMessage(info)
	return self.db.profile.message
end

function DriveBy:SetMessage(info, value)
	self.db.profile.message = value
end

function DriveBy:IsShowOnScreen(info)
	return self.db.profile.showOnScreen
-- get/set emote value
end 

function DriveBy:isActive(info)
	print("getter called")
	return self.db.profile.isActive
end

function DriveBy:ToggleShowOnScreen(info, value)
	self.db.profile.showOnScreen = value
end 

function DriveBy:setActive(info, value)
	print("setter called")
	self.db.profile.setActive = value
end

function allEmoteOptions()
	for i, e in ipairs(emotes) do
		local basics = {
			type = "toggle",
			name = "",
			desc = "Toggles the emote bank to include ",
			get = "isActive",
			set = "setActive"
		}
		-- insert emote into a basic template
		basics['name'] = string.lower(e)
		basics['desc'] = basics['desc'] .. string.lower(e) .. "."
		--insert basic template into the option arguments
		options.args[e] = basics
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
	
	if locate(validBuffs, buff) then 
		if destGUID == playerGUID and sourceGUID ~= playerGUID and subevent == "SPELL_CAST_SUCCESS" then
			DoEmote(randEmote(), sourceName)
		end
	end
end)