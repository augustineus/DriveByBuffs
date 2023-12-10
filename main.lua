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

-- called when addon is loaded
function DriveBy:OnInitialize()
	-- create a db to save settings to
	self.db = LibStub("AceDB-3.0"):New("DriveBy", defaults, true)
	AC:RegisterOptionsTable("DriveBy_options", options)
	self.optionsFrame = ACD:AddToBlizOptions("DriveBy_options", "DriveBy")

	self:Print("Thanks for using DriveBy!")

	-- register slash commands
	self:RegisterChatCommand("driveby", "SlashCommand")
end

-- called when started
function DriveBy:OnEnable()
	self:Print("Use /driveby to open the options panel.")
end

-- create a slash command
function DriveBy:SlashCommand(msg)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
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
-- if no buff is present in the combat log, it will return as -1
	if buff ~= -1 and destGUID == playerGUID and sourceGUID ~= playerGUID then
		DoEmote(randEmote(), sourceGUID)
	end
end)

-- set values for the example above
function DriveBy:GetMessage(info)
	return self.db.profile.message
end

function DriveBy:SetMessage(info, value)
	self.db.profile.message = value
end

function DriveBy:IsShowOnScreen(info)
	return self.db.profile.showOnScreen
end

function DriveBy:ToggleShowOnScreen(info, value)
	self.db.profile.showOnScreen = value
end

-- called when turned off
function DriveBy:OnDisable()
	self:Print("DriveBy RP Stopped")
end