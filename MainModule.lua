return function (Settings,Plugins)
	local settings=require(Settings)
	
	local pluginManager=require(Plugins)

	local commands = pluginManager:GetCommands()

	local runOnCommand=pluginManager:GetOnCommands()

	local prefix=settings.Prefix

	function checkwhitelist(plr:Player)
		if table.find(settings.UserIds,plr.UserId) then
			return true
		elseif settings.groupEnabled == true then
			if table.find(settings.groupInfo.MemberIds, plr:GetRankInGroup(settings.groupInfo.GroupId)) then
				return true
			end
		else
			return false
		end
	end

	function chatted(plr:Player)
		plr.Chatted:Connect(function(msg)
			msg=string.lower(msg)

			msg=string.split(msg, ' ')

			for _, command in ipairs(commands) do
				if msg[1]==prefix..string.lower(command.Name) then
					command.Function(plr,msg)
					for _, module in ipairs(runOnCommand) do
						module.Function(plr,command.Name)
					end
				end
			end
		end)
	end

	for _,plr in game.Players:GetPlayers() do
		if plr:FindFirstChild('Loaded') then
			if plr:FindFirstChild('Loaded'):IsA('BoolValue') then
				if plr:FindFirstChild('Loaded').Value==true then return end
			end
		end
		local loaded=Instance.new('BoolValue', plr) loaded.Name="Loaded" loaded.Value=true

		if settings.whitelistEnabled == true then
			local s=task.spawn(checkwhitelist,plr)
			if s then
				task.spawn(chatted, plr)
			end
		elseif settings.whitelistEnabled == false then
			task.spawn(chatted, plr)
		end
	end

	task.wait()

	game.Players.PlayerAdded:Connect(function(plr)
		if plr:FindFirstChild('Loaded') then
			if plr:FindFirstChild('Loaded'):IsA('BoolValue') then
				if plr:FindFirstChild('Loaded').Value==true then return end
			end
		end
		local loaded=Instance.new('BoolValue', plr) loaded.Name="Loaded" loaded.Value=true

		if settings.whitelistEnabled == true then
			local s=task.spawn(checkwhitelist,plr)
			if s then
				task.spawn(chatted, plr)
			end
		elseif settings.whitelistEnabled == false then
			task.spawn(chatted, plr)
		end
	end)
end
