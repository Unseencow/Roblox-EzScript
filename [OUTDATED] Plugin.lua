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

--// Variables \\--

	--// Plugin Setup \\-- 

local newToolBar = plugin:CreateToolbar("EzScript")
local newScriptButton = newToolBar:CreateButton("Open Menu", "", "rbxassetid://4458901886")
local pluginGui = script.EzScriptUI:Clone() 

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

for _, v in pairs(pluginGui:GetChildren()) do
	v.Parent = newPluginUI
end

newScriptButton.Click:Connect(function()
	newPluginUI.Enabled = not newPluginUI.Enabled
end)

newPluginUI.Holder.Inputs.Create.MouseButton1Click:Connect(function()
	local authorText = newPluginUI.Holder.Inputs.Author_TextInput.Text
	local purposeText = newPluginUI.Holder.Inputs.Purpose_TextInput.Text
	local currentDate = os.date("%x")
	if newPluginUI.Holder.Inputs.LocalScript.Check_LocalScript.Visible == true then 
		local newLocalScript = Instance.new("LocalScript")
		newLocalScript.Parent = game.Selection:Get()[1]
		if newPluginUI.Holder.Settings.Toggle_Symbols.Tick.Visible == true then 
			newLocalScript.Source = "--[[ \n \n	@: " .. authorText .. "\n	#: " .. currentDate ..  "\n	!: " .. purposeText .. "\n \n]]-- \n \n \n--// Variables \\-- \n \n \n--// Code \\--"
		else
			newLocalScript.Source =  "--[[ \n \n	Author: " .. authorText .. "\n	Date: " .. currentDate ..  "\n	Purpose: " .. purposeText .. "\n \n]]-- \n \n \n--// Variables \\-- \n \n \n--// Code \\--"
		end		
	elseif newPluginUI.Holder.Inputs.Script.Check_Script.Visible == true then
		local newScript = Instance.new("Script")
		newScript.Parent = game.Selection:Get()[1]
		if newPluginUI.Holder.Settings.Toggle_Symbols.Tick.Visible == true then 
			newScript.Source = "--[[ \n \n	@: " .. authorText .. "\n	#: " .. currentDate ..  "\n	!: " .. purposeText .. "\n \n]]-- \n \n \n--// Variables \\-- \n \n \n--// Code \\--"
		else
			newScript.Source =  "--[[ \n \n	Author: " .. authorText .. "\n	Date: " .. currentDate ..  "\n	Purpose: " .. purposeText .. "\n \n]]-- \n \n \n--// Variables \\-- \n \n \n--// Code \\--"
		end	
	end
end)

newPluginUI.Holder.Inputs.LocalScript.MouseButton1Click:Connect(function()
	newPluginUI.Holder.Inputs.Script.Check_Script.Visible = false
	newPluginUI.Holder.Inputs.LocalScript.Check_LocalScript.Visible = true
end)

newPluginUI.Holder.Inputs.Settings.MouseButton1Click:Connect(function()
	if settingsDebounce == false then 
		settingsDebounce = true
		newPluginUI.Holder.Settings.Visible = true
	else
		settingsDebounce = false
		newPluginUI.Holder.Settings.Visible = false
	end
end)

newPluginUI.Holder.Settings.Toggle_Symbols.MouseButton1Click:Connect(function()
	if clickDebounce == false then 
		clickDebounce = true
		newPluginUI.Holder.Settings.Toggle_Symbols.Tick.Visible = true
	else
		clickDebounce = false
		newPluginUI.Holder.Settings.Toggle_Symbols.Tick.Visible = false
	end
end)

newPluginUI.Holder.Inputs.Script.MouseButton1Click:Connect(function()
	newPluginUI.Holder.Inputs.Script.Check_Script.Visible = true
	newPluginUI.Holder.Inputs.LocalScript.Check_LocalScript.Visible = false
end)
