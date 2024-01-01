--[[LEFT OFF NOTES

args table SHOULD look like example below, unsure how to print entire table?

getter called 20 times (once per #emotes) and no checkmarks are changing/when they do its all 20 of them

]] 

DriveBy = LibStub("AceAddon-3.0"):NewAddon("DriveBy", "AceConsole-3.0", "AceEvent-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")

-- create a defaults table for the settings/options
local defaults = {
	profile = {
		message = "Welcome Home!",
		showOnScreen = true,
	},
}
-- options table, must be defined first
local options = { 
	name = "DriveBy",
	handler = DriveBy,
	type = "group",
	args = {},
}

-- create bank of emotes
local emotes = {"AMAZE", "APPLAUD", "BASHFUL", "BLUSH", "BOW", "BURP", "CHEER", "CLAP", "FART", "HAIL", "HAPPY", "HUG", "KISS", "SALUTE", "SEXY", "THANK", "CUDDLE", "PRAISE", "COMMEND", "FLIRT"}
function randEmote()
	return emotes[math.random(1, #emotes)]
end

--[[function allEmoteOptions()
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
]]--
-- called when addon is loaded
function DriveBy:OnInitialize()
	-- create a db to save settings to
	self.db = LibStub("AceDB-3.0"):New("DriveBy", defaults, true)
	--AC:RegisterOptionsTable("DriveBy_options", options)
	--self.optionsFrame = ACD:AddToBlizOptions("DriveBy_options", "DriveBy")

	self:Print("Thanks for using DriveBy!")

	-- register slash commands
	self:RegisterChatCommand("driveby", "SlashCommand")
	--allEmoteOptions()
end

-- called when started
function DriveBy:OnEnable()
	--self:Print("Use /driveby to open the options panel.")
end

-- create a slash command
function DriveBy:SlashCommand(msg)
	--InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end
--create a hidden frame
local f = CreateFrame("Frame");
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

-- define player name
local playerGUID = UnitGUID("player")

--create emote command
f:SetScript("OnEvent", function(self, event)
	local ts, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, _, buff = CombatLogGetCurrentEventInfo()
-- if no buff is present in the combat log, it will return as -1
	if buff ~= -1 and destGUID == playerGUID and sourceGUID ~= playerGUID then
		DoEmote(randEmote(), sourceGUID)
	end
end)

-- get/set emote value
function DriveBy:isActive(info)
	--return self.db.profile.isActive
end

function DriveBy:setActive(info, value)
	--self.db.profile.setActive = value
end

-- called when turned off
function DriveBy:OnDisable()
	self:Print("DriveBy RP Stopped")
end