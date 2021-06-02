local Saving = true

local Pins = {
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
	"rbxassetid://331180718", -- Rolve Admin
}

--[[
for i,v in pairs(game.Players:GetPlayers()) do
	if v ~= game.Players.LocalPlayer then
		if not table.find(Pins, "rbxassetid://"..v.EquippedPin.Value:sub(-10)) and v.EquippedPin.Value ~= "" then
		    print(v.EquippedPin.Value)
		end
	end
end
--]]

-- do not edit below --

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

if setreadonly then setreadonly(mt, false) else make_writeable(mt, true) end

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
	
	if not checkcaller() then
		if method == "FireServer" and self.Name == "EquipPin" then
			if Saving == true then
				writefile("EquippedPin.txt", args[1])
			end
			
			game.Players.LocalPlayer.EquippedPin.Value = args[1]
		elseif method == "InvokeServer" and self.Name == "RequestPins" then
			if Saving == true then
				if isfile("EquippedPin.txt") then
					game.Players.LocalPlayer.PlayerGui.Menew.MainFrame.PlayerCard.Photo.EquippedPin.Image = readfile("EquippedPin.txt")
					game.Players.LocalPlayer.EquippedPin.Value = readfile("EquippedPin.txt")
				end
			end
			
			return Pins
		end
	end
	
	return oldNamecall(self, unpack(args))
end)