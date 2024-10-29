--[[

███████╗████████╗███████╗ █████╗ ██╗  ██╗     █████╗ ██████╗ ██╗
██╔════╝╚══██╔══╝██╔════╝██╔══██╗██║ ██╔╝    ██╔══██╗██╔══██╗██║
███████╗   ██║   █████╗  ███████║█████╔╝     ███████║██████╔╝██║
╚════██║   ██║   ██╔══╝  ██╔══██║██╔═██╗     ██╔══██║██╔═══╝ ██║
███████║   ██║   ███████╗██║  ██║██║  ██╗    ██║  ██║██║     ██║ 
╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝     ╚═╝
                                                      By 0xSteak                              
]]

local globalTable = getgenv and getgenv() or _G

Steak = {
	_version = "v1.0",
	reload = globalTable.steakloaded,
	floating = false,
}

--Services
Steak.rps = function()
	return game:GetService('ReplicatedStorage')
end
Steak.rpf = function()
	return game:GetService('ReplicatedFirst')
end
Steak.ws = function()
	return game:GetService('Workspace')
end
Steak.plrs = function()
	return game:GetService('Players')
end
Steak.cg = function()
	return game:GetService('CoreGui')
end
Steak.rs = function()
	return game:GetService('RunService')
end
Steak.ts = function()
	return game:GetService('TweenService')
end
Steak.hs = function()
	return game:GetService('HttpService')
end
Steak.uis = function()
	return game:GetService('UserInputService')
end
Steak.vu = function()
	return game:GetService('VirtualUser')
end
Steak.vim = function()
	return game:GetService('VirtualInputManager')
end

--Player
Steak.lp = function()
	return Steak.plrs().LocalPlayer
end
Steak.char = function(plr)
	return plr and plr.Character or Steak.lp().Character
end
Steak.hmnd = function(plr)
	return Steak.char(plr) and Steak.char(plr):FindFirstChild("Humanoid")
end
Steak.hrp = function(plr)
	return Steak.char(plr) and Steak.char(plr):FindFirstChild("HumanoidRootPart")
end

Steak.create = function(class, props)
	local instance = Instance.new(class)
	for i,v in pairs(props) do
		if typeof(v) == "Instance" and i ~= "Parent" then
			v.Parent = instance
		else
			instance[i] = v
		end
	end
	return instance
end

Steak.timeToString = function(timenum, zeroText)
	local days = math.floor(timenum / 86400)
	local hours = math.floor(timenum / 3600 - days * 24)
	local minutes = math.floor(timenum / 60 - days * 1440 - hours * 60)
	local seconds = math.floor(timenum - days * 86400 - hours * 3600 - minutes * 60)
	local str = ""
	if days > 0 then
		str = days..":"

		if hours <= 9 then
			str = str.."0"
		end
		str = str..hours..":"

		if minutes <= 9 then
			str = str.."0"
		end
		str = str..minutes..":"

		if seconds <= 9 then
			str = str.."0"
		end
		str = str..seconds
	elseif days <= 0 and hours > 0 then
		str = hours..":"

		if minutes <= 9 then
			str = str.."0"
		end
		str = str..minutes..":"

		if seconds <= 9 then
			str = str.."0"
		end
		str = str..seconds
	elseif days <= 0 and hours <= 0 and minutes > 0 then	
		str = minutes..":"

		if seconds <= 9 then
			str = str.."0"
		end
		str = str..seconds
	elseif days <= 0 and hours <= 0 and minutes <= 0 and seconds > 0 then
		return seconds.."s"
	elseif days <= 0 and hours <= 0 and minutes <= 0 and seconds <= 0 then
		return zeroText
	end
	return str
end

Steak.randomString = function(length, letters, numbers, symbols, lowcase, upcase)
	local letters_ = {
		['lowcase_'] = 'abcdefghijklmnopqrstuvwxyz',
		['upcase_'] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	}
	local numbers_ = '1234567890'
	local symbols_ = '!#$%^&*(){}[]|/<>.?'
	local main = ''
	if letters == true then
		if lowcase == true then
			main = main..letters_['lowcase_']
		end
		if upcase == true then
			main = main..letters_['upcase_']
		end
		if lowcase == nil and upcase == nil then
			main = main..letters_['lowcase_']
			main = main..letters_['upcase_']
		end
	end
	if numbers == true then
		main = main..numbers_
	end
	if symbols == true then
		main = main..symbols_
	end
	local split = main:split('')
	local generated = ''
	for i = 1, length do
		generated = generated..split[math.random(1, #split)]
	end
	return generated
end

Steak.Message = function(text, Time)
	if Steak.cg():FindFirstChild("SteakMessage") then Steak.cg():FindFirstChild("SteakMessage"):Destroy() end
	local Message = Steak.create("Message", {
		Name = "SteakMessage",
		Parent = Steak.cg(),
		Text = text
	})
	if Time == nil then return end
	task.wait(Time)
	Message:Destroy()
end

Steak.Hint = function(text, Time)
	if Steak.cg():FindFirstChild("SteakHint") then Steak.cg():FindFirstChild("SteakHint"):Destroy() end
	local Hint = Steak.create("Hint", {
		Name = "SteakHint",
		Parent = Steak.cg(),
		Text = text
	})
	if Time == nil then return end
	task.wait(Time)
	Hint:Destroy()
end

Steak.hasProp = function(obj, prop)
	local function a()
		local b = obj[prop]
	end
	local success = pcall(function() a() end)
	if success then
		return true
	else
		return false
	end
end

Steak.searchByName = function(instance, text, searchType, caseSensitive)
	searchType = searchType or 0
	local found = {}
	for i,v in pairs(instance:GetDescendants()) do
		if Steak.hasProp(v, "Name") then
			local a = caseSensitive and v.Name:lower() or v.Name
			local b = caseSensitive and text:lower() or text.Name
			if searchType == 0 and string.find(a, b) then
				table.insert(found, v)
			elseif searchType == 1 and v.Name == text then
			end
		end
	end
	return found
end

Steak.searchByProp = function(instance, prop, value)
	local found = {}
	for i,v in pairs(instance:GetDescendants()) do
		if Steak.hasProp(v, prop) then
			if v[prop] == value then
				table.insert(found, v)
			end
		end
	end
	return found
end

Steak.searchByClass = function(instance, class)
	local found = {}
	for i,v in pairs(instance:GetDescendants()) do
		if Steak.hasProp(v, 'ClassName') then
			if v.ClassName == class then
				table.insert(found, v)
			end
		end
	end
	return found
end

Steak.tp = function(x, y, z)
	if typeof(x) == 'number' then
		Steak.hrp().CFrame = CFrame.new(x, y, z)
	elseif typeof(x) == 'Instance' and Steak.hasProp(x, "Position") then
		Steak.hrp().CFrame = CFrame.new(x.Position.X, x.Position.Y, x.Position.Z)
	elseif typeof(x) == "Vector3" then
		Steak.hrp().CFrame = CFrame.new(x)
	elseif typeof(x) == "CFrame" then
		Steak.hrp().CFrame = x
	end
end

Steak.move = function(arg)
	if typeof(arg) == 'Instance' then
		Steak.hmnd():MoveTo(arg.Position)
	elseif typeof(arg) == 'Vector3' then
		if not Steak.movepart then
			local part = Steak.Instance("Part", {
				Name = Steak.randomString(15, true, true, false, true, true),
				Material = Enum.Material.Glass,
				Parent = Steak.ws(),
				Transparency = 1,
				CanCollide = false,
				Anchored = true
			})
			Steak.movepart = part
		end
		Steak.movepart.Position = arg
		Steak.hmnd():MoveTo(Steak.movepart.Position)
	end
end

Steak.tween = function(pos, time_, easingstyle, easingdir)
	Steak.ts()
	:Create(Steak.hrp(), TweenInfo.new(time_, easingstyle or Enum.EasingStyle.Linear, easingdir or Enum.EasingDirection.Out), {CFrame = pos})
	:Play()
end

Steak.distance = function(a, b)
	a = a
	b = b
	if typeof(a) == "Instance" then
		a = a.Position
	end
	if typeof(b) == "Instance" then
		b = b.Position
	end
	if b == nil then
		local distance = (Steak.hrp().Position - a).Magnitude
		return distance
	else
		local distance = (a - b).Magnitude
		return distance
	end
end

Steak.closestObj = function(object, objects)
	object = object
	objects = objects
	if objects == nil then
		objects = object
		object = Steak.hrp()
	end
	local a = objects[1]
	for i,v in pairs(objects) do
		if Steak.distance(object, v) < Steak.distance(object, a) then
			a = v
		end
	end
	return a
end

Steak.round = function(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

Steak.float = function()
	if not Steak.floatPart then
		Steak.floatPart = Steak.create("Part", {
			CanCollide = false,
			Anchored = true,
			Transparency = 1,
			Name = Steak.randomString(10),
			Parent = Steak.ws(),
			Size = Vector3.new(3, 1, 3)
		})
	end
	local floatpart = Steak.floatPart
	local pos = CFrame.new(Steak.hrp().Position.X, Steak.hrp().Position.Y - 3.75, Steak.hrp().Position.Z)

	Steak.hmnd().HumanoidDescription.BodyTypeScale = 0

	floatpart.CFrame = pos
	floatpart.CanCollide = true

	Steak.floating = true
end

Steak.disableFloat = function()
	if Steak.floatPart then
		local floatpart = Steak.floatPart
		floatpart.CanCollide = false
		Steak.floating = false
	end
end

Steak.webhook = function(webhook, data)
	local requestfunc = (syn and syn.request or http_request or request)
	requestfunc({
		['Url'] = webhook,
		['Method'] = "POST",
		['Headers'] = {
			['content-type'] = 'application/json'
		},
		['Body'] = Steak.hs():JSONEncode(data)
	})
end

Steak.kick = function(reason)
	Steak.lp():Kick(reason)
end

Steak.plrico = function(id)
	return "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(id) or tostring(Steak.lp().UserId).."&width=420&height=420&format=png"
end

Steak.UI = function()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/0xSteak/libraries/main/sapphireUI.lua"))()
end

Steak.newThread = function(func)
    local a = coroutine.create(func)
	coroutine.resume(a)
	return a
end

Steak.tableFromIndexes = function(t)
	local result = {}
	for i,v in pairs(t) do
		table.insert(result, i)
	end
	return result
end

Steak.rejoin = function()
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Steak.lp())
end

Steak.dumpTable = function(_t)
	local count = 0
	local function tableLength(t)
		local length = 0
		for _ in t do
			length +=1
		end
		return length
	end
	local function dump(t)
		if type(t) == 'table' then
			count += 1
			local s = '{\n'..string.rep("    ", count)
			local i = 0
			for k,v in pairs(t) do
				i += 1
			   	if type(k) ~= 'number' then k = '"'..k..'"' end
				if i < tableLength(t) then
					s = s .. '['..k..'] = ' .. dump(v) .. ',\n'..string.rep("    ", count)
				else
					s = s .. '['..k..'] = ' .. dump(v) .. ',\n'
				end
			   	
			end
			count -= 1
			return s .. string.rep("    ", count) ..  '}'
		 else
			return tostring(t)
		 end
	end

	return dump(_t)
end

Steak.Obj = function(...)
	local objects = {...}
	local waitTimeout
	local obj = objects[2]
	table.remove(objects, 1)

	for i,v in objects do
		
	end
end

if getgenv then
	getgenv().Steak = Steak
end

if Steak.reload then
	print(("Steak API %s reloaded"):format(Steak._version))
else
	print(("Steak API %s loaded"):format(Steak._version))
end

globalTable.steakloaded = true

return Steak