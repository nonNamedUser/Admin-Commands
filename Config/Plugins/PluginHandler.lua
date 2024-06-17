local oncommand=script.Parent.OnCommand
local commands=script.Parent.Commands

local module={}

function module:GetCommands()
	local cmds={}
	for _, cmdModule in commands:GetChildren() do
		if not cmdModule:IsA('ModuleScript') then return end
		local module=require(cmdModule)
		
		table.insert(cmds, {['Name']=module.Name,['Description']=module.Description, ['Function']=module.Function})
	end
	task.wait()
	return cmds
end

function module:GetOnCommands()
	local functions={}
	
	for _, osModule in oncommand:GetChildren() do
		if not osModule:IsA('ModuleScript') then return end
		local module=require(osModule)
		table.insert(functions, {['Function']=module.Function})
	end
	task.wait()
	return functions
end

return module
