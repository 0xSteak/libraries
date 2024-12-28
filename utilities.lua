-- no documentation.
-- made by 0xsteak

local globalTable = getgenv and getgenv() or _G

Steak = {
	reloaded = globalTable.steakloaded,
	floating = false,
	timers = {},
	listeners = {},
	threads = {},
	tween = nil
}

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

-- returns player by userid/name/character, if no argument then returns local player
Steak.player = function(player)
	if player then
		if typeof(player) == "number" then
			return Players:GetPlayerByUserId(player)
		elseif typeof(player) == "Instance" and player:IsA("Model") then
			return Players:GetPlayerFromCharacter(player)
		elseif typeof(player) == "string" then
			return Players:FindFirstChild(player)
		end
	else
		return Players.LocalPlayer
	end
end

-- returns player character or local player character
Steak.character = function(player)
	player = player or Steak.player()

	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		player = Steak.player(player)
	end

	return player and player.Character
end

-- returns player humanoid or local player humanoid
Steak.humanoid = function(player)
	player = player or Steak.player()

	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		player = Steak.player(player)
	end

	return Steak.character(player) and Steak.character(player):FindFirstChild("Humanoid")
end

-- returns player humanoidrootpart or local player humanoidrootpart
Steak.rootPart = function(player)
	player = player or Steak.player()

	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		player = Steak.player(player)
	end

	return Steak.character(player) and Steak.character(player):FindFirstChild("HumanoidRootPart")
end

-- just convenient function for creating instances
Steak.create = function(class, props)
	local instance = Instance.new(class)
	for i,v in pairs(props) do
		if typeof(v) == "Instance" and typeof(i) == "number" then
			v.Parent = instance
		else
			instance[i] = v
		end
	end
	return instance
end

-- format time to string
-- zeroText is text to return if timenum is 0
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

-- random string generator
Steak.randomString = function(length, options)
	local chars = {
		lowcase = "abcdefghijklmnopqrstuvwxyz",
		upcase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
		digits = "1234567890",
		symbols = "!#$%^&*(){}[]|/<>.?"
	}

	local userOptions = options or {}

	options = {
		lowcase = userOptions.lowcase or true,
		upcase = userOptions.upcase or true,
		digits = userOptions.digits or true,
		symbols = userOptions.symbols or false,
		customChars = userOptions.customChars or ""
	}

	local charSet = ""
	local generated = ""

	if options.lowcase then
		charSet ..= chars.lowcase
	end
	if options.upcase then
		charSet ..= chars.upcase
	end
	if options.digits then
		charSet ..= chars.digits
	end
	if options.symbols then
		charSet ..= chars.symbols
	end
	if options.customChars and #options.customChars > 0 then
		charSet ..= options.customChars
	end

	if #charSet == 0 then  -- bro trynna generate string with empty char set
		return 
	end

	for i = 1, length do
		local randomIndex = math.random(1, #charSet)
		generated = generated..charSet:sub(randomIndex, randomIndex)
	end

	return generated
end

-- old roblox message system
Steak.message = function(text, lifetime)
	local oldMessage = CoreGui:FindFirstChild("SteakMessage")
	if oldMessage then
		oldMessage:FindFirstChild("SteakMessage"):Destroy()
	end
	local Message = Steak.create("Message", {
		Name = "SteakMessage",
		Parent = CoreGui,
		Text = text
	})
	if lifetime then
		task.wait(lifetime)
		Message:Destroy()
	end
end

-- also old roblox hint system
Steak.hint = function(text, lifetime)
	local oldHint = CoreGui:FindFirstChild("SteakHint")
	if oldHint then
		oldHint:FindFirstChild("SteakHint"):Destroy()
	end
	local Hint = Steak.create("Hint", {
		Name = "SteakHint",
		Parent = CoreGui,
		Text = text
	})
	if lifetime then
		task.wait(lifetime)
		Hint:Destroy()
	end
end

-- checks if instance has property
Steak.hasProp = function(obj, prop)
	return pcall(function()
		return obj[prop]
	end)
end

-- advanced instance search
-- search types: "Name", "Class", "Property"
Steak.search = function(instance, searchType, recursive, caseSensitive, searchInput, searchInput2)
	local searchResult = {}

	caseSensitive = caseSensitive or true

	if not caseSensitive then
		searchInput = searchInput:lower()
		searchInput2 = searchInput2:lower()
	end

	for i,v in pairs(recursive and instance:GetDescendants() or instance:GetChildren()) do
		local objName = not caseSensitive and v.Name:lower() or v.Name
		if searchType == "Name" then
			if objName == searchInput then
				table.insert(searchResult, v)
			end
		elseif searchType == "Class" then
			if v:IsA(searchInput) then
				table.insert(searchResult, v)
			end
		elseif searchType == "Property" then
			if Steak.hasProp(v, searchInput) and v[searchInput] == searchInput2 then
				table.insert(searchResult, v)
			end
		end
	end

	return searchResult
end

-- just teleport function
Steak.tp = function(x, y, z)
	local rootPart = Steak.rootPart()
	if not rootPart then return end
	if typeof(x) == "number" then
		rootPart.CFrame = CFrame.new(x, y, z)
	elseif typeof(x) == "Instance" and Steak.hasProp(x, "Position") then
		rootPart.CFrame = CFrame.new(x.Position)
	elseif typeof(x) == "Vector3" then
		rootPart.CFrame = CFrame.new(x)
	elseif typeof(x) == "CFrame" then
		rootPart.CFrame = x
	end
end

-- makes ur character to walk to given target
Steak.walkTo = function(target)
	if typeof(target) == "Instance" then
		target = target.Position
	end
	local humanoid = Steak.humanoid()
	if humanoid and typeof(target) == "Vector3" then
		humanoid:MoveTo(target)
	end
end

-- tweens ur character (smooth/interpolated teleport)
Steak.tweenCharacter = function(position, tweenTime, easingStyle, easingDirection)
	Steak.tween = TweenService:Create(Steak.rootPart(), TweenInfo.new(tweenTime, easingStyle or Enum.EasingStyle.Linear, easingDirection or Enum.EasingDirection.Out), {CFrame = position})
	Steak.tween:Play()
end

-- stops the tween if its running
Steak.stopTween = function()
	if Steak.tween then
		Steak.tween:Cancel()
	end
end

-- get distance between u and position or between two positions (arg must be instance or position)
Steak.distance = function(a, b)
	if typeof(a) == "Instance" then
		a = a.Position
	end
	if typeof(b) == "Instance" then
		b = b.Position
	end
	if b == nil then
		return Steak.rootPart() and (Steak.rootPart().Position - a).Magnitude
	else
		return (a - b).Magnitude
	end
end

-- get the closest object from <objects> to <object>
Steak.closestObj = function(object, objects)
	if objects == nil then
		objects = object
		object = Steak.rootPart()
	end
	local a = objects[1]
	for i,v in pairs(objects) do
		if Steak.distance(object, v) < Steak.distance(object, a) then
			a = v
		end
	end
	return a
end

-- godly round function
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
			Parent = workspace,
			Size = Vector3.new(3, 1, 3)
		})
	end
	local floatpart = Steak.floatPart
	local rootPart = Steak.rootPart()
	local pos = CFrame.new(rootPart.Position.X, rootPart.Position.Y - 3.75, rootPart.Position.Z)

	Steak.humanoid().HumanoidDescription.BodyTypeScale = 0

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

-- discord webhook
Steak.webhook = function(webhook, data)
	local requestfunc = (syn and syn.request or http_request or request)
	requestfunc({
		['Url'] = webhook,
		['Method'] = "POST",
		['Headers'] = {
			['content-type'] = 'application/json'
		},
		['Body'] = HttpService:JSONEncode(data)
	})
end

Steak.kick = function(reason)
	Steak.player():Kick(reason)
end

Steak.plrico = function(id)
	
end

Steak.UI = function()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/0xSteak/libraries/refs/heads/main/sapphireUI.lua"))()
end

Steak.newThread = function(threadName, threadFunction, ...)
	if Steak.threads[threadName] then
		Steak.stopThread(threadName)
	end
	Steak.threads[threadName] = task.spawn(threadFunction, ...)
end

Steak.stopThread = function(threadName)
	task.cancel(Steak.threads[threadName])
end

Steak.arrayFromKeys = function(t, _ipairs)
	local result = {}
	local iter = _ipairs and ipairs(t) or pairs(t)
	for i,v in iter do
		table.insert(result, i)
	end
	return result
end

Steak.rejoinServer = function(retryUntilSuccess)
	if retryUntilSuccess then
		TeleportService.TeleportInitFailed:Connect(function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Steak.player())
		end)
	end
	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Steak.player())
end

Steak.rejoinGame = function(retryUntilSuccess)
	if retryUntilSuccess then
		TeleportService.TeleportInitFailed:Connect(function()
			TeleportService:Teleport(game.PlaceId)
		end)
	end
	TeleportService:Teleport(game.PlaceId)
end

Steak.serverhop = function(placeId)
	local url = ("https://games.roblox.com/v1/games/%s/servers/0/?excludeFullGames=true&limit=100&cursor="):format(placeId or game.PlaceId)
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

Steak.setTimer = function(timerTime, timerName)
	Steak.timers[timerName] = tick() + timerTime
end

Steak.isTimerFinished = function(timerName)
	if Steak.timers[timerName] then
		return tick() >= Steak.timers[timerName]
	end
end

Steak.listen = function(listenerName, event, listenerFunction)
	Steak.unlisten(listenerName)
	Steak.listeners[listenerName] = event:Connect(listenerFunction)
end

Steak.unlisten = function(listenerName)
	if Steak.listeners[listenerName] then
		Steak.listeners[listenerName]:Disconnect()
	end
end

Steak.fireSignal = function(signal, ...)
	if typeof(firesignal) == "function" then
		firesignal(signal)
	elseif typeof(getconnections) == "function" then
		for _, connection in pairs(getconnections(signal)) do
			connection:Fire()
		end
	end
end

Steak.guiClick = function(object, button, clickType)
	clickType = clickType or 5

	local down = "MouseButton"..button.."Down"
	local up = "MouseButton"..button.."Up"
	local click = "MouseButton"..button.."Click"

	if clickType == 1 then
		Steak.fireSignal(object[down])
	elseif clickType == 2 then
		Steak.fireSignal(object[up])
	elseif clickType == 3 then
		Steak.fireSignal(object[click])
	elseif clickType == 4 then
		Steak.fireSignal(object[down])
		task.wait(0.1)
		Steak.fireSignal(object[up])
	elseif clickType == 5 then
		Steak.fireSignal(object[down])
		task.wait(0.1)
		Steak.fireSignal(object[up])
		task.wait(0.1)
		Steak.fireSignal(object[click])
	end
end

-- if Steak.reloaded then
-- 	print("Steak Utilities reloaded")
-- else
-- 	print("Steak Utilities loaded")
-- end

globalTable.steakloaded = true

if typeof(getgenv) == "function" and typeof(getgenv()) == "table" then
	getgenv().Steak = Steak
end

return Steak