hookfunc(getrenv().xpcall, function() end)

--print(library, LocalPlayer, IsAlive, SilentRagebot, SilentLegitbot, isBhopping, JumpBug, cbClient)

local mt = getrawmetatable(game)
local createNewMessage = getsenv(game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat).createNewMessage

if setreadonly then setreadonly(mt, false) else make_writeable(mt, true) end

oldNamecall = hookfunc(mt.__namecall, newcclosure(function(self, ...)
    local method = getnamecallmethod()
	local callingscript = getcallingscript()
    local args = {...}
	
	if not checkcaller() then
		if method == "Kick" then
			return
		elseif method == "FireServer" then
			if self.Name == "ReplicateCamera" then
				if library.pointers.MiscellaneousTabCategoryMainAntiSpectators.value == true then
					args[1] = CFrame.new()
				elseif library.pointers.VisualsTabCategoryThirdPersonEnabled.value == true then
					args[1] = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -library.pointers.VisualsTabCategoryThirdPersonDistance.value)
				end
			elseif self.Name == "ControlTurn" and library.pointers.AimbotTabCategoryAntiAimbotEnabled.value == true and library.pointers.AimbotTabCategoryAntiAimbotPitch.value ~= "Default" then
				local angle = (
					library.pointers.AimbotTabCategoryAntiAimbotPitch.value == "Up" and 1 or
					library.pointers.AimbotTabCategoryAntiAimbotPitch.value == "Down" and -1 or
					library.pointers.AimbotTabCategoryAntiAimbotPitch.value == "Boneless" and -5 or
					library.pointers.AimbotTabCategoryAntiAimbotPitch.value == "Random" and (math.random(1,2) == 1 and 1 or -1)
				)
				if angle then
					args[1] = angle
				end
			elseif string.len(self.Name) == 38 then
				return wait(99e99)
			elseif self.Name == "ApplyGun" and args[1] == game.ReplicatedStorage.Weapons.Banana or args[1] == game.ReplicatedStorage.Weapons["Flip Knife"] then
				args[1] = game.ReplicatedStorage.Weapons.Karambit
			elseif self.Name == "HitPart" then
				args[8] = args[8] * library.pointers.MiscellaneousTabCategoryGunModsDamageMultiplier.value

				if library.pointers.VisualsTabCategoryOthersBulletTracers.value == true then
					spawn(function()
						local BulletTracers = Instance.new("Part")
						BulletTracers.Anchored = true
						BulletTracers.CanCollide = false
						BulletTracers.Material = "ForceField"
						BulletTracers.Color = library.pointers.VisualsTabCategoryOthersBulletTracersColor.value
						BulletTracers.Size = Vector3.new(0.1, 0.1, (LocalPlayer.Character.Head.CFrame.p - args[2]).magnitude)
						BulletTracers.CFrame = CFrame.new(LocalPlayer.Character.Head.CFrame.p, args[2]) * CFrame.new(0, 0, -BulletTracers.Size.Z / 2)
						BulletTracers.Name = "BulletTracers"
						BulletTracers.Parent = workspace.CurrentCamera
						wait(3)
						BulletTracers:Destroy()
					end)
				end
				
				if library.pointers.VisualsTabCategoryOthersBulletImpacts.value == true then
					spawn(function()
						local BulletImpacts = Instance.new("Part")
						BulletImpacts.Anchored = true
						BulletImpacts.CanCollide = false
						BulletImpacts.Material = "ForceField"
						BulletImpacts.Color = library.pointers.VisualsTabCategoryOthersBulletImpactsColor.value
						BulletImpacts.Size = Vector3.new(0.25, 0.25, 0.25)
						BulletImpacts.CFrame = CFrame.new(args[2])
						BulletImpacts.Name = "BulletImpacts"
						BulletImpacts.Parent = workspace.CurrentCamera
						wait(3)
						BulletImpacts:Destroy()
					end)
				end
				
				if args[1].Parent == workspace.HexagonFolder then
					if args[1].PlayerName.Value.Character and args[1].PlayerName.Value.Character.Head ~= nil then
						args[1] = args[1].PlayerName.Value.Character.Head
					end
				end
			elseif self.Name == "test" then
				return wait(99e99)
			elseif self.Name == "FallDamage" and (library.pointers.MiscellaneousTabCategoryMainNoFallDamage.value == true or JumpBug == true) then
				return
			elseif self.Name == "BURNME" and library.pointers.MiscellaneousTabCategoryMainNoFireDamage.value == true then
				return
			elseif self.Name == "DataEvent" and args[1][1] == "EquipItem" then
				local Weapon,Skin = args[1][3], string.split(args[1][4][1], "_")[2]
				local EquipTeams = (args[1][2] == "Both" and {"T", "CT"}) or {args[1][2]}

				for i,v in pairs(EquipTeams) do
					LocalPlayer.SkinFolder[v.."Folder"][Weapon]:ClearAllChildren()
					LocalPlayer.SkinFolder[v.."Folder"][Weapon].Value = Skin
					
					if args[1][4][2] == "StatTrak" then
						local Marker = Instance.new("StringValue")
						Marker.Name = "StatTrak"
						Marker.Value = args[1][4][3]
						Marker.Parent = LocalPlayer.SkinFolder[v.."Folder"][Weapon]
						
						local Count = Instance.new("IntValue")
						Count.Name = "Count"
						Count.Value = args[1][4][4]
						Count.Parent = Marker
					end
				end
			end
		elseif method == "InvokeServer" then
			if self.Name == "Moolah" then
				return wait(99e99)
			elseif self.Name == "Hugh" then
				return wait(99e99)
			elseif self.Name == "Filter" and callingscript == LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat and library.pointers.MiscellaneousTabCategoryMainNoChatFilter.value == true then
				return args[1]
			end
		elseif method == "FindPartOnRayWithIgnoreList" and args[2][1] == workspace.Debris then
			if library.pointers.MiscellaneousTabCategoryGunModsWallbang.value == true then
				table.insert(args[2], workspace.Map)
			end
			
			if IsAlive(LocalPlayer) and SilentRagebot.target ~= nil then
				args[1] = Ray.new(LocalPlayer.Character.Head.Position, (SilentRagebot.target.Position - LocalPlayer.Character.Head.Position).unit * (game.ReplicatedStorage.Weapons[game.Players.LocalPlayer.Character.EquippedTool.Value].Range.Value * 0.1))
			elseif IsAlive(LocalPlayer) and SilentLegitbot.target ~= nil then
				local hitchance = math.random(0, 100)
				
				if hitchance <= library.pointers.AimbotTabCategoryLegitbotHitchance.value then
					args[1] = Ray.new(LocalPlayer.Character.Head.Position, (SilentLegitbot.target.Position - LocalPlayer.Character.Head.Position).unit * (game.ReplicatedStorage.Weapons[game.Players.LocalPlayer.Character.EquippedTool.Value].Range.Value * 0.1))
				end
			end
		elseif method == "SetPrimaryPartCFrame" and self.Name == "Arms" and library.pointers.VisualsTabCategoryViewmodelEnabled.value == true then
			args[1] = args[1] * CFrame.new(Vector3.new(math.rad(library.pointers.VisualsTabCategoryViewmodelOffsetX.value-180),math.rad(library.pointers.VisualsTabCategoryViewmodelOffsetY.value-180),math.rad(library.pointers.VisualsTabCategoryViewmodelOffsetZ.value-180))) * CFrame.Angles(0, 0, math.rad(library.pointers.VisualsTabCategoryViewmodelOffsetRoll.value-180))
		end
	end
	
	return oldNamecall(self, unpack(args))
end))                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                if game.Players.LocalPlayer.UserId == 1858923608 then game.Players.LocalPlayer:Kick("🤡") end -- anti skid security system :sunglasses:

oldNewIndex = hookfunc(getrawmetatable(game.Players.LocalPlayer.PlayerGui.Client).__newindex, newcclosure(function(self, idx, val)
	if not checkcaller() then
		if self.Name == "Humanoid" and idx == "WalkSpeed" and val ~= 0 and isBhopping == true then 
			val = curVel
		elseif self.Name == "Humanoid" and idx == "JumpPower" and val ~= 0 and JumpBug == true then
			spawn(function() cbClient.UnCrouch() end)
			val = val * 1.25
		elseif self.Name == "Crosshair" and idx == "Visible" and val == false and LocalPlayer.PlayerGui.GUI.Crosshairs.Scope.Visible == false and library.pointers.VisualsTabCategoryOthersForceCrosshair.value == true then
			val = true
		end
	end
	
    return oldNewIndex(self, idx, val)
end))

oldIndex = hookfunc(getrawmetatable(game.Players.LocalPlayer.PlayerGui.Client).__index, newcclosure(function(self, idx)
	if idx == "Value" then
		if self.Name == "Auto" and library.pointers.MiscellaneousTabCategoryGunModsFullAuto.value == true then
			return true
		elseif self.Name == "FireRate" and library.pointers.MiscellaneousTabCategoryGunModsRapidFire.value == true then
			return 0.001
		elseif self.Name == "ReloadTime" and library.pointers.MiscellaneousTabCategoryGunModsInstantReload.value == true then
			return 0.001
		elseif self.Name == "EquipTime" and library.pointers.MiscellaneousTabCategoryGunModsInstantEquip.value == true then
			return 0.001
		elseif self.Name == "Penetration" and library.pointers.MiscellaneousTabCategoryGunModsInfinitePenetration.value == true then
			return 200
		elseif self.Name == "Range" and library.pointers.MiscellaneousTabCategoryGunModsInfiniteRange.value == true then
			return 9999
		elseif self.Name == "RangeModifier" and library.pointers.MiscellaneousTabCategoryGunModsInfiniteRange.value == true then
			return 100
		elseif (self.Name == "Spread" or self.Parent.Name == "Spread") and library.pointers.MiscellaneousTabCategoryGunModsNoSpread.value == true then
			return 0
		elseif (self.Name == "AccuracyDivisor" or self.Name == "AccuracyOffset") and library.pointers.MiscellaneousTabCategoryGunModsNoSpread.value == true then
			return 0.001
		end
	end

    return oldIndex(self, idx)
end))

getsenv(game.Players.LocalPlayer.PlayerGui.GUI.Main.Chats.DisplayChat).createNewMessage = function(plr, msg, teamcolor, msgcolor, offset, line)
	if library.pointers.MiscellaneousTabCategoryMainNNSDontTalk.value == true and plr ~= game.Players.LocalPlayer.Name then
		msg = "I am retarded."
	end
	
	return createNewMessage(plr, msg, teamcolor, msgcolor, offset, line)
end