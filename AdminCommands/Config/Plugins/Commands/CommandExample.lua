local command = {}

command.Name="Test"

command.Description="Test"

command.Function=function(player:Player, arg)
	print('Test Command Ran!')
end

return command
