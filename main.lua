WelcomeHome = LibStub("AceAddon-3.0"):NewAddon("WelcomeHome", "AceConsole-3.0")

function WelcomeHome:OnInitialize()
	-- Called when the addon is loaded
	self:Print("Hello World!")
end

function WelcomeHome:OnEnable()
	-- Called when the addon is enabled
end

function WelcomeHome:OnDisable()
	-- Called when the addon is disabled
end

-- double checking that the addon works

-- ideas for dev

-- using either a spell name to trace back to any spell id, or using the combat log, target the player that cast the spell then use a bank of emotes to emote back at them

DriveBy = LibStub("AceAddon-3.0"):NewAddon("WelcomeHome", "AceConsole-3.0", "AceEvent-3.0")

--create a frame to print the combat log to that is hidden
local frame = createFrame("Frame", "CombatLogHandler_Obi");
-- hide frame/make 0 size
frame:SetFrameStrata("BACKGROUND");
frame:SetWidth(0);
frame:SetHeight(0);
--add the CLEU to the frame
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", OnEvent)
--print all unfiltered combat log events to a hidden frame
local function OnEvent(self, event)
	print(CombatLogGetCurrentEventInfo())
end

function DriveBy:OnInitialize()
	-- called when addon is loaded
	self:Print("Thanks for using DriveBy!")
	name = C_PlayerInfo.GetName
end

function DriveBy:OnEnable()
	-- called when started
	self:Print("DriveBy RP Started")
	self:RegisterEvent("")
end

function DriveBy:OnDisable()
	-- called when turned off
	self:Print("DriveBy RP Stopped")
end

function detectBuff(self, event, msg, author, tar)
	--if CombatLogGetCurrentEventInfo(timestampchangeme, _AURA_APPLIED)  
end
-- CombatLogGetCurrentEventInfo(timestampchangeme, _AURA_APPLIED)

--change me later
local playerGUID = UnitGUID("player")
local UVE_BEEN_BUFFED = "Your %s critically hit %s for %d damage!" -- change me

f:SetScript("OnEvent", function(self, event)
	local _, subevent, _, sourceGUID, _, _, _, _, destName = CombatLogGetCurrentEventInfo()
	local spellId, amount, critical

	if subevent == "SWING_DAMAGE" then
		amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
	elseif subevent == "SPELL_DAMAGE" then
		spellId, _, _, amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
	end

	if critical and sourceGUID == playerGUID then
		-- get the link of the spell or the MELEE globalstring
		local action = spellId and GetSpellLink(spellId) or MELEE
		print(MSG_CRITICAL_HIT:format(action, destName, amount))
	end
end)