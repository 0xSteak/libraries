--[[

███████╗████████╗███████╗ █████╗ ██╗  ██╗     █████╗ ██████╗ ██╗
██╔════╝╚══██╔══╝██╔════╝██╔══██╗██║ ██╔╝    ██╔══██╗██╔══██╗██║
███████╗   ██║   █████╗  ███████║█████╔╝     ███████║██████╔╝██║
╚════██║   ██║   ██╔══╝  ██╔══██║██╔═██╗     ██╔══██║██╔═══╝ ██║
███████║   ██║   ███████╗██║  ██║██║  ██╗    ██║  ██║██║     ██║ 
╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝     ╚═╝
                                                      By 0xSteak
                          Discord: steak#8439/449784566325182474                              
]]

local reload = false

if not pcall(getgenv) then warn("getgenv is required") return 0 end
if not pcall(setreadonly, {}, false) then warn("setreadonly is required") return 0 end
if getgenv().steakloaded then reload = true end

Steak = {
	reload = reload,
	floating = false,
}


--Services
Steak.rps = function()
	return game:GetService('ReplicatedStorage')
end
Steak.rfs = function()
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
Steak.char = function()
	return Steak.lp().Character or false
end

Steak.hmnd = function()
	return Steak.char().Humanoid or false
end

Steak.hrp = function()
	return Steak.char().HumanoidRootPart or false
end

--Upgrading globals

--Unlocking
setreadonly(Instance, false)
setreadonly(string, false)

--Upgrading
Instance.cr = function(class, props)
	local instance = Instance.new(class)
	for i,v in pairs(props) do
		instance[i] = v
	end
	return instance
end
string.time = function(timenum, zeroText)
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
	elseif days <= 0 and hours <= 0 and minutes <= 0 then
		return seconds.."s"
	elseif days <= 0 and hours <= 0 and minutes <= 0 and seconds <= 0 then
		return zeroText
	end
	return str
end
--[[math.mirror = function(num, min, max)
	if num < min then
		error("SteakAPI: Number can't be lower than minimal number")
	end
	if num > max then
		error("SteakAPI: Number can't be bigger than maximal number")
	end
	if min == max then
		error("SteakAPI: Minimal and Maximal numbers can't be equal")
	end
	local half = (min + max) / 2
	if num < half then
		return half + (num - half)
	elseif num > half then
		return half - (num - half)
	elseif num == half then
		return half
	else
		warn("SteakAPI: Unknown error")
	end
end
]]

if workspace:FindFirstChild("SteakAPI") then
	Steak.Folder = Steak.ws():FindFirstChild("SteakAPI")
else
	Steak.Folder = Instance.cr("Folder", {
		Name = "SteakAPI",
		Parent = Steak.ws()
	})
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
	local Message = Steak.Instance("Message", {
		Name = "SteakMessage",
		Parent = Steak.cg(),
		Text = text
	})
	wait(Time)
	Message:Destroy()
end

Steak.Hint = function(text, Time)
	if Steak.cg():FindFirstChild("SteakHint") then Steak.cg():FindFirstChild("SteakHint"):Destroy() end
	local Hint = Instance.cr("Hint", {
		Name = "SteakHint",
		Parent = Steak.cg(),
		Text = text
	})
	if Time == nil then return end
	wait(Time)
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

Steak.searchByName = function(instance, arg)
	local instance_ = instance or game
	local found = {}
	for i,v in pairs(instance_:GetDescendants()) do
		if Steak.hasProp(v, "Name") then
			if string.find(v.Name, arg) then
				table.insert(found, v)
			end
		end
	end
	return found
end

Steak.searchByProp = function(instance, prop, value)
	local instance_ = instance or game
	local found = {}
	for i,v in pairs(instance_:GetDescendants()) do
		if Steak.hasProp(v, prop) then
			if v[prop] == value then
				table.insert(found, v)
			end
		end
	end
	return found
end

Steak.searchByClass = function(instance, class)
	local instance_ = instance or game
	local found = {}
	for i,v in pairs(instance_:GetDescendants()) do
		if Steak.hasProp(v, 'ClassName') then
			if string.find(v.ClassName, class) then
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
		if #Steak.searchByProp(Steak.Folder, "Material", Enum.Material.Glass) < 1 then
			local part = Steak.Instance("Part", {
				Name = Steak.randomString(15, true, true, false, true, true),
				Material = Enum.Material.Glass,
				Parent = Steak.ws(),
				Transparency = 1,
				CanCollide = false,
				Anchored = true
			})
			Steak.movepart = part
		else
			Steak.movepart = Steak.searchByProp(Steak.Folder, "Material", Enum.Material.Glass)[1]
		end
		Steak.movepart.Position = arg
		Steak.hmnd():MoveTo(Steak.movepart.Position)
	end
end

Steak.tween = function(pos, time_, easingstyle, easingdir)
	local ts = Steak.ts()
	local t = ts:Create(Steak.hrp(), TweenInfo.new(time_, easingstyle or Enum.EasingStyle.Linear, easingdir or Enum.EasingDirection.Out), {CFrame = pos})
	t:Play()
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
	if not Steak.ws():FindFirstChild("_FLOATPART") then
		Instance.cr("Part", {
			CanCollide = false,
			Anchored = true,
			Transparency = 1,
			Name = "_FLOATPART",
			Parent = Steak.ws()
		})
	end
	local floatfunc = {}
	local floatpart = Steak.ws()._FLOATPART
	local pos = CFrame.new(Steak.hrp().Position.X, Steak.hrp().Position.Y - 3.75, Steak.hrp().Position.Z)
	Steak.hmnd().HumanoidDescription.BodyTypeScale = 0
	floatpart.CFrame = pos
	floatpart.CanCollide = true
	Steak.floating = true
	return floatfunc
end

Steak.disableFloat = function()
	if Steak.ws():FindFirstChild("_FLOATPART") then
		local floatpart = Steak.ws()._FLOATPART
		floatpart.CanCollide = false
		Steak.floating = false
	end
end

Steak.webhook = function(webhook, data)
	if Steak.studio then
		local httpenabled = pcall(function() Steak.hs():RequestAsync({Url = "example.com", Method = "POST"}) end)
		if not httpenabled then error("SteakAPI: Can't use webhook function, seems like you didn't enabled http request in game settings") return end
		Steak.hs():RequestAsync({
			['Url'] = webhook,
			['Method'] = "POST",
			['Headers'] = {
				['content-type'] = 'application/json'
			},
			['Body'] = Steak.hs():JSONEncode(data)
		})
	else
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
end

Steak.kick = function(reason)
	Steak.lp():Kick(reason)
end

Steak.plrico = function(id)
	return "https://www.roblox.com/headshot-thumbnail/image?userId="..tostring(id) or tostring(Steak.lp().UserId).."&width=420&height=420&format=png"
end

Steak.assert = function(mode, value, err)
	if mode == 1 then
		return assert(value, err)
	elseif mode == 2 then
		local suc = pcall(value)
		if suc then
			return value
		else
			error(err)
		end
	elseif mode == 3 then
		local suc = pcall(function() local a = value end)
		if suc then
			return value
		else
			error(err)
		end
	end
end

Steak.vcheck = function(global)
	if global ~= nil then
		return true
	else
		return false
	end
end

Steak.UI = function()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/0xSteak/libraries/main/sapphireUI.lua"))()
end

Steak.newThread = function(func)
    coroutine.wrap(function()
        func()
    end)()
end

Steak.tableFromIndexes = function(t)
	local result = {}
	for i,v in pairs(t) do
		table.insert(result, i)
	end
	return result
end

Steak.rejoin = function()
	game:GetService("TeleportService"):Teleport(game.PlaceId)
end

setreadonly(Instance, true)
setreadonly(string, true)

if Steak.studio then
	if Steak.reload then
		game:GetService('TestService'):Message("Steak Utilities reloaded")
	else
		game:GetService('TestService'):Message("Steak Utilities loaded")
	end
	_G.steakloaded = true
	return Steak
else
	getgenv().Steak = Steak
	--setreadonly(getgenv().Steak, true)
	if Steak.reload then
		game:GetService('TestService'):Message("Steak Utilities reloaded")
	else
		game:GetService('TestService'):Message("Steak Utilities loaded")
	end
	getgenv().steakloaded = true
end