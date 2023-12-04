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