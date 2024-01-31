--[[ 

add slash commands for dbb; https://wowpedia.fandom.com/wiki/Creating_a_slash_command

add options table; https://wowpedia.fandom.com/wiki/Using_the_Interface_Options_Addons_panel

]]

DriveByBuffs = LibStub("AceAddon-3.0"):NewAddon("DriveByBuffs", "AceConsole-3.0", "AceEvent-3.0")

local dbb_Version = "1.0.3"

local dbb_Defaults = {
	["Options"] = {
		["MasterOnOff"] = "On",
		["version"] = dbb_Version,
		["debug"] = false,
	},
};

function dbb_Loaded()
	if (not dbb_Options) then
		dbb_Options = dbb_Defaults["Options"];
		DEFAULT_CHAT_FRAME:AddMessage("DriveByBuffs Options database not found. Generating...");
	end
	if (dbb_Options["version"] < dbb_Version) then
		dbb_Options_temp = dbb_Defaults["Options"];
		for k,v in dbb_Options do
			if (dbb_Defaults["Options"][k]) then
				dbb_Options_temp[k] = v;
			end
		end
		dbb_Options_temp["version"] = dbb_Version;
		dbb_Options = dbb_Options_temp;
	end
end

local function locate(table, value)
	for i = 1, #table do
		if table[i] == value then 
		return true 
		end
	end
end

local dbb_Options = {
name = "DriveByBuffs",
handler = DriveByBuffs,
type = "group",
args = {},
}

function DriveByBuffs:OnInitialize()
	self:Print("Thanks for using DriveByBuffs!")
	DriveByBuffsDB = DriveByBuffsDB or CopyTable(dbb_Defaults)
	self.db = DriveByBuffsDB
	LibStub("AceConfig-3.0"):RegisterOptionsTable("DriveByBuffs", dbb_Options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DriveByBuffs", "DriveByBuffs")
	self:RegisterChatCommand("dbb", "SlashCommand")
	allEmoteOptions()
end

function DriveByBuffs:OnEnable()
	self:Print("Type /dbb to toggle which emotes you want to 'thank' people with.")
end

function DriveByBuffs:OnDisable()
	self:Print("DriveByBuffs RP Stopped")
end

function DriveByBuffs:SlashCommand(msg)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end

function DriveByBuffs:isActive(info)
	print("getter called")
	return DriveByBuffs.db.isActive
end

function DriveByBuffs:setActive(info, value)
	print("setter called")
	DriveByBuffs.db.setActive = value
end

local emotes = {"AMAZE", "APPLAUD", "BASHFUL", "BLUSH", "BOW", "BURP", "CHEER", "CLAP", "FART", "HAIL", "HAPPY", "HUG", "KISS", "SALUTE", "SEXY", "THANK", "CUDDLE", "PRAISE", "COMMEND", "FLIRT"}
function randEmote()
	return emotes[math.random(1, #emotes)]
end

function allEmoteOptions()
	for i, e in ipairs(emotes) do
		local basics = {
			type = "toggle",
			name = "",
			desc = "Toggles the emote bank to include ",
			get = DriveByBuffs.isActive(e),
			set = DriveByBuffs.setActive(e, not value)
		}
		-- insert emote into a basic template
		basics['name'] = string.lower(e)
		basics['desc'] = basics['desc'] .. string.lower(e) .. "."
		--insert basic template into the option arguments
		dbb_Options.args[e] = basics
	end
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