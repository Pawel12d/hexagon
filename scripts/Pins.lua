shared.Saving = shared.Saving == nil and true or shared.Saving
shared.Pins = shared.Pins == nil and {
	"rbxassetid://6616945516", -- Easter 2021
	"rbxassetid://6111454171", -- Christmas 2020
	"rbxassetid://5894230059", -- Halloween 2020
	"rbxassetid://4540756250", -- Christmas 2019
	"rbxassetid://4257797755", -- Halloween 2019
	"rbxassetid://2656299034", -- Christmas 2018
	"rbxassetid://2566906953", -- Halloween 2018
	"rbxassetid://2627834049", -- Christmas 2017
	"rbxassetid://1158104700", -- Halloween 2017
	"rbxassetid://3260336994", -- Operation Bright
	"rbxassetid://949727483",  -- DropX S4
	"rbxassetid://734835644",  -- CBCL S1
	"rbxassetid://734723378",  -- CBCL S2
	"rbxassetid://4434228836", -- Battle Pass
	"rbxassetid://6835204580", -- Honk Honk
	"rbxassetid://331180718", -- Rolve Admin
} or shared.Pins

--[[
Pins Scanner:

for i,v in pairs(game.Players:GetPlayers()) do
	if not table.find(shared().Pins, "rbxassetid://"..v.EquippedPin.Value:sub(-10)) and v.EquippedPin.Value ~= "" then
		print(v.EquippedPin.Value)
	end
end
--]]

-- do not edit below --

local mt = getrawmetatable(game)
local oldNamecall = nil

if setreadonly then setreadonly(mt, false) else make_writeable(mt, true) end

oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
	
	if not checkcaller() then
		if method == "FireServer" and self.Name == "EquipPin" then
			if shared.Saving == true then
				writefile("EquippedPin.txt", args[1])
			end
			
			game.Players.LocalPlayer.EquippedPin.Value = args[1]
		elseif method == "InvokeServer" and self.Name == "RequestPins" then
			if shared.Saving == true then
				if isfile("EquippedPin.txt") then
					game.Players.LocalPlayer.PlayerGui.Menew.MainFrame.PlayerCard.Photo.EquippedPin.Image = readfile("EquippedPin.txt")
					game.Players.LocalPlayer.EquippedPin.Value = readfile("EquippedPin.txt")
				end
			end
			
			return shared.Pins
		end
	end
	
	return oldNamecall(self, unpack(args))
end)