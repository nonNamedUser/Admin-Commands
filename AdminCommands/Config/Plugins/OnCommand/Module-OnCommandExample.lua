local command = {}

command.Function=function(player:Player, commandName:string)
	print(commandName.." was ran by "..player.Name)
end

return command
