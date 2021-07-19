--[[
	
	Author: VoidException
	Date: 17/07/2021
	Purpose: Complete handler of the EzScript Plugin
	
	--
	
	Licensed under the Apache License 2.0
	Github: https://github.com/V0idException/EzScript-Roblox
	Twitter: https://twitter.com/ExceptionVoid
	Discord: Unseen#7064
	Devforum: https://devforum.roblox.com/u/voidexception
	
	--
	
	Note: This isn't the nicest code, or the final code, I'll be updating this plugin.
	Please request any features via github (if you can't, then feel free to message me on discord)
]]--

--// Plugin Setup \\-- 

local newToolBar = plugin:CreateToolbar("EzScript")
local Selection = game:GetService("Selection")
local newScriptButton = newToolBar:CreateButton("Open Menu", "", "rbxassetid://4458901886")
local pluginGui = script.Parent.EzScriptUI:Clone() 

local Selection = game:GetService("Selection")

local formats = {
Symbols = [[
-- @: %s
-- #: %s
-- !: %s
					
--// Variables \\--
					
--// Code \\--
]],
Text = [[
-- Author: %s
-- Date: %s
-- Purpose: 5s
			
--// Variables \\--
			
--// Code \\--
]]
}

newScriptButton.ClickableWhenViewportHidden = true

--// Plugin Variables \\--

local settingsDebounce = false
local clickDebounce = false

--// Plugin Code \\--

local newPluginUI = plugin:CreateDockWidgetPluginGui("Create New", DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float, true, false,
	120, 10,    
	250, 250    
))

for _, element in pairs(pluginGui:GetChildren()) do
	element.Parent = newPluginUI
end

newScriptButton.Click:Connect(function()
	newPluginUI.Enabled = not newPluginUI.Enabled
end)

newPluginUI.Holder.Inputs.Create.MouseButton1Click:Connect(function()
	local authorText = newPluginUI.Holder.Inputs.Author_TextInput.Text
	local purposeText = newPluginUI.Holder.Inputs.Purpose_TextInput.Text
	local ToggleSymbols = newPluginUI.Holder.Settings.Toggle_Symbols.Tick.Visible
	local UseLocalScripts = newPluginUI.Holder.Inputs.LocalScript.Check_LocalScript.Visible
	
	local currentDate = os.date("%x")
	
	local function FormatSource(Script)
		if ToggleSymbols then 
			Script.Source = string.format(formats.Symbols,authorText,currentDate,purposeText)
		else
			Script.Source =  string.format(formats.Text,authorText,currentDate,purposeText)
		end
	end
	
	local Script = nil
	
	if UseLocalScripts then 
		Script = Instance.new("LocalScript")
	else 
		Script = Instance.new("Script")
	end
	
	Script.Parent = Selection:Get()[1]
	FormatSource(Script)
	plugin:OpenScript(Script,1)
end)

newPluginUI.Holder.Inputs.LocalScript.Activated:Connect(function()
	newPluginUI.Holder.Inputs.Script.Check_Script.Visible = false
	newPluginUI.Holder.Inputs.LocalScript.Check_LocalScript.Visible = true
end)

newPluginUI.Holder.Inputs.Settings.Activated:Connect(function()
	if settingsDebounce == false then 
		settingsDebounce = true
		newPluginUI.Holder.Settings.Visible = true
	else
		settingsDebounce = false
		newPluginUI.Holder.Settings.Visible = false
	end
end)

newPluginUI.Holder.Settings.Toggle_Symbols.Activated:Connect(function()
	if clickDebounce == false then 
		clickDebounce = true
		newPluginUI.Holder.Settings.Toggle_Symbols.Tick.Visible = true
	else
		clickDebounce = false
		newPluginUI.Holder.Settings.Toggle_Symbols.Tick.Visible = false
	end
end)

newPluginUI.Holder.Inputs.Script.Activated:Connect(function()
	newPluginUI.Holder.Inputs.Script.Check_Script.Visible = true
	newPluginUI.Holder.Inputs.LocalScript.Check_LocalScript.Visible = false
end)
