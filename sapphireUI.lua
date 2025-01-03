local lib = {
	settings = {
		dontEnterTextFields = true,
		keybinds = true,
		uiColor = Color3.fromRGB(52, 146, 235),
		theme = 0
	},
	colorable = {},
	colorable2 = {},
	texts = {},
	placeholders = {},
	scrollbars = {},
	buttons = {},
	tabCount = 0,
	ctrl_pressed = false,
	connections = {}
}

--services
local ts = game:GetService('TweenService')
local uis = game:GetService('UserInputService')
local rs = game:GetService('RunService')
local textService = game:GetService("TextService")

table.insert(lib.connections, uis.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftControl then
		lib.ctrl_pressed = true
	end
end))

table.insert(lib.connections, uis.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftControl then
		lib.ctrl_pressed = false
	end
end))

-- function for normal dragging, bc roblox dragging is so shitty
local function makeDraggable(ClickObject, Object) -- credits to idk, not mine
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil
	local UserInputService = game:GetService('UserInputService')

	table.insert(lib.connections, ClickObject.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = Input.Position
			StartPosition = Object.Position

			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end))

	table.insert(lib.connections, ClickObject.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			DragInput = Input
		end
	end))

	table.insert(lib.connections, UserInputService.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - DragStart
			Object.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		end
	end))
end

local function randomString(len)
	local charspack = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890!#$%^&*(){}[]|/<>.?'
	local split = charspack:split('')
	local randomized = ""
	for i = 1, len do
		randomized = randomized..split[math.random(#split)]
	end
	return randomized
end

local function create(class, props)
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

local elementCreate = {}

elementCreate.mainObjects = function()
	return create("ScreenGui", {
		Enabled = true,
		ResetOnSpawn = false,
		create("Frame", {
			Name = "MainWindow",
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			Position = UDim2.new(0.5, -283, not uis.TouchEnabled and 0.5 or 1, -227),
			Size = UDim2.new(0, 566, 0, 455),
			create("UICorner", {CornerRadius = UDim.new(0, 10)}),
			create("Frame", {
				Name = "Top",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.new(1, 0, 0, 30),
				create("ImageLabel", {
					Name = "Icon",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 5, 0, 5),
					Size = UDim2.new(0, 20, 0, 20),
					Image = "rbxassetid://12114859949",
					ImageColor3 = lib.Color
				}),
				create("TextLabel", {
					Name = "Title",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 32, 0, 0),
					Size = UDim2.new(0, 534, 0, 30),
					FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
					Text = "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				create("TextLabel", {
					Name = "Center",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, 30),
					FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
					Text = "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Center
				}),
				create("TextLabel", {
					Name = "Right",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					Size = UDim2.new(1, 0, 0, 30),
					FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
					Text = "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Right
				})
			}),
			create("Frame", {
				Name = "Line",
				BackgroundColor3 = Color3.fromRGB(50, 50, 50),
				BorderSizePixel = 0,
				Position = UDim2.new(0, 164, 0, 50),
				Size = UDim2.new(0, 1, 0, 385),
			}),
			create("ScrollingFrame", {
				Name = "TBContainer",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 30),
				Size = UDim2.new(0, 164, 0, 425),
				CanvasSize = UDim2.new(0, 0, 0, 0),
				ScrollBarThickness = 0,
				create("UIListLayout", {
					Name = "ListLayout",
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 10),
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Top
				}),
				create("UIPadding", {
					Name = "Padding",
					PaddingTop = UDim.new(0, 10)
				})
			}),
			create("Frame", {
				Name = "TContainer",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 166, 0, 30),
				Size = UDim2.new(0, 400, 0, 425),
				ClipsDescendants = true,
				create("UIPageLayout", {
					Name = "_PageLayout",
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 0),
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					GamepadInputEnabled = false,
					ScrollWheelInputEnabled = false,
					TouchInputEnabled = false,
					Animated = true,
					Circular = false,
					EasingDirection = Enum.EasingDirection.Out,
					EasingStyle = Enum.EasingStyle.Quint,
					TweenTime = 0.5,
				})
			}),
			create("Frame", {
				Name = "BlackSolid",
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.fromScale(1, 1),
				create("UICorner", {CornerRadius = UDim.new(0, 10)})
			})
		}),
		create("TextLabel", {
			Name = "Tooltip",
			BackgroundColor3 = Color3.fromRGB(35, 35, 35),
			BackgroundTransparency = 0,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 6, 0, 30),
			Visible = false,
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			Text = "",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			create("UICorner", {CornerRadius = UDim.new(0, 10)})
		})
	})
end
elementCreate.messageBox = function()
	return create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Name = "MessageBox",
		BackgroundColor3 = lib.settings.theme == 0 and Color3.fromRGB(35, 35, 35) or Color3.fromRGB(200, 200, 200),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 275, 0, 132),
		ZIndex = 2,
		create("UICorner", {CornerRadius = UDim.new(0, 10)}),
		create("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Name = "Top",
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.114, 0),
			Size = UDim2.new(1, 0, 0.227, 0),
			ZIndex = 2,
			create("TextLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Name = "Title",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0.916, 0, 0.467, 0),
				FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
				Text = "caption",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				TextScaled = true,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2,
				TextTransparency = 1
			})
		}),
		create("TextLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Name = "Label",
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.473, 0),
			Size = UDim2.new(0.9, 0, 0.492, 0),
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			Text = "text",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextWrapped = true,
			ZIndex = 2,
			TextTransparency = 1
		}),
		create("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Name = "ButtonContainer",
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.814, 0),
			Size = UDim2.new(1, 0, 0.189, 0),
			ZIndex = 2,
			create("UIListLayout", {
				Name = "ListLayout",
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center
			})
		})
	})
end
elementCreate.tab = function()
	return create("ScrollingFrame", {
		Name = "Tab",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(0, 400, 0, 425),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
		BottomImage = "",
		TopImage = "",
		create("Frame", {
			Name = "Left",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 200, 1, 0),
			create("UIListLayout", {
				Name = "ListLayout",
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Top
			}),
			create("UIPadding", {
				Name = "Padding",
				PaddingTop = UDim.new(0, 10)
			})
		}),
		create("Frame", {
			Name = "Right",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 200, 0, 0),
			Size = UDim2.new(0, 200, 1, 0),
			create("UIListLayout", {
				Name = "ListLayout",
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Top
			}),
			create("UIPadding", {
				Name = "Padding",
				PaddingTop = UDim.new(0, 10)
			})
		})
	})
end
elementCreate.tabButton = function()
	return create("TextButton", {
		Name = "TabButton",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 164, 0, 30),
		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
		Text = "Tab",
		TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
		TextSize = 14
	})
end
elementCreate.section = function()
	return create("Frame", {
		Name = "Section",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 25),
		create("TextLabel", {
			Name = "Title",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(0, 170, 0, 24),
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			Text = "",
			TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
			TextSize = 14
		}),
		create("Frame", {
			Name = "Line",
			BackgroundColor3 = lib.settings.theme == 0 and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(175, 175, 175),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 10, 0, 24),
			Size = UDim2.new(0, 150, 0, 1),
		}),
		create("Frame", {
			Name = "Container",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 25),
			Size = UDim2.new(0, 170, 0, 0),
			create("UIListLayout", {
				Name = "ListLayout",
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Top
			}),
			create("UIPadding", {
				Name = "Padding",
				PaddingTop = UDim.new(0, 10)
			})
		})
	})
end
elementCreate.label = function()
	return create("TextLabel", {
		Name = "Label",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(0, 170, 0, 500),
		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
		Text = "",
		TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
		TextSize = 12,
		TextWrapped = true,
	})
end
elementCreate.button = function()
	return create("TextButton", {
		AutoButtonColor = false,
		Name = "Button",
		BackgroundColor3 = lib.settings.uiColor,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 170, 0, 25),
		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
		Text = "Button",
		TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(225, 225, 225),
		TextSize = 14,
		create("UICorner", {CornerRadius = UDim.new(0, 4)})
	})
end
elementCreate.toggle = function()
	return create("TextButton", {
		AutoButtonColor = false,
		Name = "Toggle",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 20),
		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
		Text = "Toggle",
		TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		create("Frame", {
			Name = "Toggle",
			BackgroundColor3 = lib.settings.theme == 0 and Color3.fromRGB(35, 35, 35) or Color3.fromRGB(200, 200, 200),
			Position = UDim2.new(0, 140, 0, 2),
			Size = UDim2.new(0, 30, 0, 16),
			create("UICorner", {CornerRadius = UDim.new(0, 10)}),
			create("Frame", {
				Name = "Circle",
				BackgroundColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
				Position = UDim2.new(0, 3, 0, 3),
				Size = UDim2.new(0, 10, 0, 10),
				create("UICorner", {CornerRadius = UDim.new(0, 10)})
			})
		})
	})
end
elementCreate.textField = function()
	return create("Frame", {
		Name = "TextField",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 45),
		create("TextBox", {
			Name = "Field",
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
			ClearTextOnFocus = false,
			Position = UDim2.new(0, 0, 0, 20),
			Size = UDim2.new(0, 170, 0, 25),
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			PlaceholderColor3 = Color3.fromRGB(175, 175, 175),
			PlaceholderText = "Placeholder",
			Text = "",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			create("UICorner", {CornerRadius = UDim.new(0, 8)})
		}),
		create("TextLabel", {
			Name = "FieldName",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 170, 0, 20),
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			Text = "Text Field",
			TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left
		})
	})
end
elementCreate.slider = function()
	return create("Frame", {
		Name = "Slider",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 30),
		create("UICorner", {CornerRadius = UDim.new(0, 8)}),
		create("TextLabel", {
			Name = "SliderName",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 170, 0, 20),
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			Text = "Slider",
			TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left
		}),
		create("TextLabel", {
			Name = "SliderValue",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 170, 0, 20),
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			Text = "0",
			TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Right
		}),
		create("Frame", {
			Name = "SliderBorder",
			BackgroundColor3 = lib.settings.uiColor,
			Position = UDim2.new(0, 0, 0, 20),
			Size = UDim2.new(0, 170, 0, 10),
			create("UICorner", {CornerRadius = UDim.new(0, 8)}),
			create("Frame", {
				Name = "Fill",
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				Position = UDim2.new(0, 1, 0, 1),
				Size = UDim2.new(0, 168, 0, 8),
				create("UICorner", {CornerRadius = UDim.new(0, 8)}),
			}),
			create("Frame", {
				Name = "Slider",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 2, 0, 2),
				Size = UDim2.new(0, 166, 0, 6),
				create("UICorner", {CornerRadius = UDim.new(0, 8)}),
				create("Frame", {
					Name = "Slider",
					BackgroundColor3 = lib.settings.uiColor,
					BorderSizePixel = 0,
					Size = UDim2.new(0, 0, 0, 6),
					create("UICorner", {CornerRadius = UDim.new(0, 8)}),
				})
			})
		})
	})
end
elementCreate.dropdown = function()
	return create("Frame", {
		Name = "Dropdown",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 45),
		ClipsDescendants = true,
		create("TextLabel", {
			Name = "DropdownName",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 170, 0, 20),
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			Text = "Dropdown",
			TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left
		}),
		create("TextButton", {
			AutoButtonColor = false,
			Name = "Toggle",
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
			Position = UDim2.new(0, 0, 0, 20),
			Size = UDim2.new(0, 170, 0, 25),
			Text = "",
			create("UICorner", {CornerRadius = UDim.new(0, 8)}),
			create("TextLabel", {
				Name = "Value",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 0),
				Size = UDim2.new(0, 160, 0, 25),
				FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
				Text = "...",
				TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			create("TextLabel", {
				Name = "Arrow",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 145, 0, 0),
				Size = UDim2.new(0, 25, 0, 25),
				FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
				Text = "▼",
				TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
				TextSize = 10
			})
		}),
		create("Frame", {
			Name = "Container",
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
			Position = UDim2.new(0, 0, 0, 55),
			Size = UDim2.new(0, 170, 0, 90),
			create("UICorner", {CornerRadius = UDim.new(0, 8)}),
			create("TextBox", {
				Name = "_SearchBox",
				BackgroundTransparency = 1,
				ClearTextOnFocus = true,
				Size = UDim2.new(0, 170, 0, 18),
				FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
				PlaceholderColor3 = Color3.fromRGB(175, 175, 175),
				PlaceholderText = "Search...",
				Text = "",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 12,
				create("Frame", {
					Name = "Line",
					BackgroundColor3 = Color3.fromRGB(70, 70, 70),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 15, 0, 18),
					Size = UDim2.new(0, 140, 0, 1)
				})
			}),
			create("ScrollingFrame", {
				Name = "Container",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 18),
				Size = UDim2.new(0, 170, 0, 90),
				ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
				ScrollBarThickness = 2,
				create("UIListLayout", {
					Name = "ListLayout",
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Top
				}),
			})
		})
	})
end
elementCreate.list = function()
	return create("Frame", {
		Name = "List",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 45),
		ClipsDescendants = true,
		create("TextLabel", {
			Name = "ListName",
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 170, 0, 20),
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			Text = "List",
			TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left
		}),
		create("TextButton", {
			AutoButtonColor = false,
			Name = "Toggle",
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
			Position = UDim2.new(0, 0, 0, 20),
			Size = UDim2.new(0, 170, 0, 25),
			Text = "",
			create("UICorner", {CornerRadius = UDim.new(0, 8)}),
			create("TextLabel", {
				Name = "Value",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 0),
				Size = UDim2.new(0, 160, 0, 25),
				FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
				Text = "0 Objects",
				TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
				TextSize = 12,
				TextXAlignment = Enum.TextXAlignment.Left
			}),
			create("TextLabel", {
				Name = "Arrow",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 145, 0, 0),
				Size = UDim2.new(0, 25, 0, 25),
				FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
				Text = "▼",
				TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
				TextSize = 10
			})
		}),
		create("Frame", {
			Name = "Container",
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
			Position = UDim2.new(0, 0, 0, 55),
			Size = UDim2.new(0, 170, 0, 90),
			create("UICorner", {CornerRadius = UDim.new(0, 8)}),
			create("Frame", {
				Name = "Add",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 170, 0, 24),
				create("TextBox", {
					Name = "Field",
					BackgroundColor3 = Color3.fromRGB(30, 30, 30),
					ClearTextOnFocus = true,
					Position = UDim2.new(0, 2, 0, 3),
					Size = UDim2.new(0, 140, 0, 18),
					FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
					PlaceholderColor3 = Color3.fromRGB(175, 175, 175),
					PlaceholderText = "Object Name",
					Text = "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12,
					create("UICorner", {CornerRadius = UDim.new(0, 8)}),
				}),
				create("TextButton", {
					Name = "Button",
					AutoButtonColor = false,
					BackgroundColor3 = Color3.fromRGB(64, 163, 255),
					Position = UDim2.new(0, 144, 0, 3),
					Size = UDim2.new(0, 20, 0, 18),
					Text = "",
					create("UICorner", {CornerRadius = UDim.new(0, 4)}),
					create("ImageLabel", {
						Name = "Icon",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 2, 0, 1),
						Size = UDim2.new(0, 16, 0, 16),
						Image = "rbxassetid://401613236",
						ImageColor3 = Color3.fromRGB(20, 20, 20)
					})
				})
			}),
			create("ScrollingFrame", {
				Name = "Container",
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 0, 0, 24),
				Size = UDim2.new(0, 170, 0, 90),
				ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
				ScrollBarThickness = 2,
				create("UIListLayout", {
					Name = "ListLayout",
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Top
				}),
			})
		})
	})
end
elementCreate.listObject = function()
	return create("TextLabel", {
		Name = "Object",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 20),
		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
		Text = "Option",
		TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
		TextSize = 12,
		create("TextButton", {
			Name = "Button",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.fromRGB(64, 163, 255),
			Position = UDim2.new(0, 144, 0, 2),
			Size = UDim2.new(0, 20, 0, 20),
			Text = "",
			create("ImageLabel", {
				Name = "Icon",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 3, 0, 3),
				Size = UDim2.new(0, 14, 0, 14),
				Rotation = 45,
				Image = "rbxassetid://401613236",
				ImageColor3 = Color3.fromRGB(255, 49, 49)
			})
		})
	})
end
elementCreate.dropdownOption = function()
	return create("TextButton", {
		Name = "Option",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 20),
		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
		Text = "Option",
		TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
		TextSize = 12
	})
end
elementCreate.line = function()
	return create("Frame", {
		Name = "Line",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 20),
		create("Frame", {
			Name = "Line",
			BackgroundColor3 = lib.settings.theme == 0 and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(175, 175, 175),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 10, 0, 10),
			Size = UDim2.new(0, 150, 0, 1),
		})
	})
end
elementCreate.menu = function()
	return create("Frame", {
		Name = "_MENU",
		BackgroundColor3 = Color3.fromRGB(10, 10, 10),
		BorderSizePixel = 0,
		create("UIListLayout", {
			Name = "ListLayout",
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Top
		}),
		create("UIPadding", {
			Name = "Padding",
			PaddingLeft = UDim.new(0, 5)
		}),
		create("UICorner", {CornerRadius = UDim.new(0, 10)})
	})
end
elementCreate.menuOption = function()
	return create("TextButton", {
		Name = "MenuOption",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 0, 0, 20),
		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
		Text = "",
		TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
		TextSize = 12
	})
end
elementCreate.colorpicker = function()
	return create("TextButton", {
		Name = "Colorpicker",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 170, 0, 20),
		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
		Text = "Colorpicker",
		TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
		TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
		create("TextButton", {
			AutoButtonColor = false,
			Name = "Toggle",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0,
			Position = UDim2.new(0, 154, 0, 2),
			Size = UDim2.new(0, 16, 0, 16),
			Text = "",
			create("UICorner", {CornerRadius = UDim.new(1, 0)})
		})
	})
end
elementCreate.palette = function()
	return create("Frame", {
		Name = "Palette",
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BackgroundTransparency = 0,
		Size = UDim2.new(0, 154, 0, 116),
		Visible = false,
		ZIndex = 2,
		create("UICorner", {CornerRadius = UDim.new(0, 10)}),
		create("Frame", {
			Name = "ValImg",
			BackgroundColor3 = Color3.fromRGB(255, 0, 0),
			BackgroundTransparency = 0,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderMode = Enum.BorderMode.Outline,
			BorderSizePixel = 1,
			Position = UDim2.new(0, 131, 0, 5),
			Size = UDim2.new(0, 10, 0, 106),
			ZIndex = 2,
			create("UIGradient", {
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
				},
				Rotation = 90
			}),
			create("TextLabel", {
				Name = "Arrow",
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 0, 0),
				Rotation = 90,
				Size = UDim2.new(0, 8, 0, 10),
				ZIndex = 2,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
				Text = "▼",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 10,
				TextStrokeTransparency = 0,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		}),
		create("ImageLabel", {
			Name = "HueSatImg",
			BackgroundTransparency = 1,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderMode = Enum.BorderMode.Outline,
			BorderSizePixel = 1,
			Position = UDim2.new(0, 5, 0, 5),
			Size = UDim2.new(0, 121, 0, 106),
			ZIndex = 2,
			Image = "rbxassetid://698052001",
			ScaleType = Enum.ScaleType.Stretch,
			create("TextLabel", {
				Name = "Cursor",
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 0, 0),
				Rotation = 90,
				Size = UDim2.new(0, 12, 0, 12),
				ZIndex = 2,
				FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.ExtraLight),
				Text = "+",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 31,
				TextStrokeTransparency = 0,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center
			})
		})
	})
end

--[[
config example:
{
	name = "Sapphire",
	parent = game.CoreGui,
	showAtStart = true,
	icon = "rbxassetid://12114859949",
	settings = {
		dontEnterTextFields = true,
		uiColor = Color3.fromRGB(255, 255, 255),
		theme = 1
	}
}
]]

lib.new = function(config)
	local libNew = {}

	if config.settings then
		if config.settings.dontEnterTextFields ~= nil then
			lib.settings.dontEnterTextFields = config.settings.dontEnterTextFields
		end
		if config.settings.keybinds ~= nil then
			lib.settings.keybinds = config.settings.keybinds
		end
		if config.settings.uiColor ~= nil then
			lib.settings.uiColor = config.settings.uiColor
		end
		if config.settings.theme ~= nil then
			lib.settings.theme = config.settings.theme
		end
	end

	local function insert_colorable(obj, prop)
		lib.colorable[obj] = prop
	end

	local function remove_colorable(obj)
		lib.colorable[obj] = nil
	end

	local function insert_colorable2(obj)
		lib.colorable2[obj] = obj
	end

	local function remove_colorable2(obj)
		lib.colorable2[obj] = nil
	end

	local function insert_texts(obj)
		lib.texts[obj] = obj
	end

	local function remove_texts(obj)
		lib.texts[obj] = nil
	end

	local function insert_placeholders(obj)
		lib.placeholders[obj] = obj
	end

	local function remove_placeholders(obj)
		lib.texts[obj] = nil
	end

	local function insert_scrollbars(obj)
		lib.scrollbars[obj] = obj
	end

	local function remove_scrollbars(obj)
		lib.texts[obj] = nil
	end

	local function insert_buttons(obj)
		lib.buttons[obj] = nil
	end

	local function updateColor()
		for i,v in pairs(lib.colorable) do -- 0 backgroundcolor, 1 textcolor, 2 imagecolor
			if v ~= nil then
				if v == 0 then
					i.BackgroundColor3 = lib.settings.uiColor
				elseif v == 1 then
					i.TextColor3 = lib.settings.uiColor
				elseif v == 2 then
					i.ImageColor3 = lib.settings.uiColor
				end		
			end
		end
	end

	local tt = {}

	local gui = elementCreate.mainObjects()
	local mainWindow = gui.MainWindow
	local top = mainWindow.Top
	local topIcon = top.Icon
	local topTitle = top.Title
	local topCenter = top.Center
	local topRight = top.Right
	local tContainer = mainWindow.TContainer
	local tbContainer = mainWindow.TBContainer
	local tooltip = gui.Tooltip

	local function setTheme(theme)
		local colors
		if theme == 0 then
			colors = {Color3.fromRGB(20, 20, 20), Color3.fromRGB(50, 50, 50), Color3.fromRGB(255, 255, 255), Color3.fromRGB(175, 175, 175), Color3.fromRGB(35, 35, 35)} -- background, color2, text color, placeholder text color
		elseif theme == 1 then
			colors = {Color3.fromRGB(225, 225, 225), Color3.fromRGB(175, 175, 175), Color3.fromRGB(0, 0, 0), Color3.fromRGB(100, 100, 100), Color3.fromRGB(200, 200, 200)} -- background, color2, text color, placeholder text color
		end
		local function smoothColorChange(obj, prop, val)
			local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
			local t = ts:Create(obj, tinfo, {[prop] = val})
			t:Play()
		end
		smoothColorChange(mainWindow, "BackgroundColor3", colors[1])
		smoothColorChange(tooltip, "BackgroundColor3", colors[5])
		for i,v in pairs(lib.colorable2) do
			if v ~= nil then
				smoothColorChange(v, "BackgroundColor3", colors[2])
			end
		end
		for i,v in pairs(lib.texts) do
			if v ~= nil then
				smoothColorChange(v, "TextColor3", colors[3])
			end
		end
		for i,v in pairs(lib.placeholders) do
			if v ~= nil then
				smoothColorChange(v, "PlaceholderColor3", colors[4])
			end
		end
		for i,v in pairs(lib.scrollbars) do
			if v ~= nil then
				smoothColorChange(v, "ScrollBarImageColor3", colors[3])
			end
		end
		for i,v in pairs(lib.buttons) do
			if v ~= nil then
				smoothColorChange(v, "TextColor3", colors[1])
			end
		end
		lib.settings.theme = theme
	end

	makeDraggable(top, mainWindow)

	insert_colorable(topIcon, 2)
	insert_texts(topTitle)
	insert_texts(topCenter)
	insert_texts(topRight)
	insert_texts(tooltip)
	insert_colorable2(mainWindow.Line)

	setTheme(lib.settings.theme)

	gui.Name = randomString(30)
	if config.showAtStart == nil then
		config.showAtStart = true
	end
	if not config.showAtStart then
		gui.Enabled = false
		libNew.show = function()
			gui.Enabled = true
		end
	end
	gui.Parent = config.parent or game.CoreGui
	topIcon.Image = config.icon or ""
	topIcon.ImageColor3 = lib.settings.uiColor
	topTitle.Text = config.name or "Untitled"

	--[[tContainer.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		tContainer.CanvasSize = UDim2.new(0, 0, 0, tContainer.ListLayout.AbsoluteContentSize.Y)
	end)]]

	local function addTooltip(obj, text)
		local a
		local b
		if not uis.TouchEnabled then
			a = obj.MouseEnter:Connect(function()
				tooltip.Text = text
				tooltip.Visible = true
			end)
			b = obj.MouseLeave:Connect(function()
				tooltip.Visible = false
			end)
		else
			a = obj.InputBegan:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.Touch then
					tooltip.Text = text
					tooltip.Visible = true
				end
			end)
			b = obj.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.Touch then
					tooltip.Visible = false
				end
			end)
		end
		return function()
			a:Disconnect()
			b:Disconnect()
		end
	end

	local mouse = function() return game.Players.LocalPlayer:GetMouse() end
	table.insert(lib.connections, mouse().Button1Down:Connect(function()
		tooltip.Visible = false
	end))

	table.insert(lib.connections, rs.RenderStepped:Connect(function()
		if tooltip.Visible then
			tooltip.Position = UDim2.new(0, mouse().X, 0, mouse().Y - tooltip.Size.Y.Offset)
		end
	end))

	tooltip:GetPropertyChangedSignal("Text"):Connect(function()
		local textserv = game:GetService("TextService")
		local a = textserv:GetTextSize(tooltip.Text, 14, "Ubuntu", Vector2.new(300, 81))
		tooltip.Size = UDim2.new(0, a.X + 5, 0, a.Y + 11)
	end)

	local function messageBox(caption, text, buttons, callback)
		local element = elementCreate.messageBox()

		element.Name = caption.."_msg"
		element.Parent = mainWindow
		element.Top.Title.Text = caption
		element.Label.Text = text

		local a = false

		for i,v in pairs(mainWindow:GetChildren()) do
			if string.find(v.Name, "_msg") and v ~= element and v ~= nil then
				v.Destroying:Wait()
			end
		end

		local function checkmessages()
			local check = false
			for i,v in pairs(mainWindow:GetChildren()) do
				if string.find(v.Name, "_msg") and v ~= element then
					check = true
					break
				end
			end
			return check
		end

		local function tween(obj, props)
			if tt[obj] ~= nil then tt[obj]:Cancel() end
			local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local t = ts:Create(obj, tinfo, props)
			t:Play()
			tt[obj] = t
		end

		local function show()
			element.Size = UDim2.new(0, 275 * 0.8, 0, 132 * 0.8)
			tween(element, {Size = UDim2.new(0, 275, 0, 132), BackgroundTransparency = 0})
			tween(mainWindow.BlackSolid, {BackgroundTransparency = 0.75})
			tween(element.Top.Title, {TextTransparency = 0})
			tween(element.Label, {TextTransparency = 0})
			for i,v in pairs(element.ButtonContainer:GetChildren()) do
				if v.ClassName == "TextButton" then
					tween(v, {BackgroundTransparency = 0, TextTransparency = 0})
				end
			end
		end

		local function hide()
			a = true
			tween(element, {Size = UDim2.new(0, 275 * 0.8, 0, 132 * 0.8), BackgroundTransparency = 1})
			if not checkmessages() then tween(mainWindow.BlackSolid, {BackgroundTransparency = 1}) end
			tween(element.Top.Title, {TextTransparency = 1})
			tween(element.Label, {TextTransparency = 1})
			for i,v in pairs(element.ButtonContainer:GetChildren()) do
				if v.ClassName == "TextButton" then
					tween(v, {BackgroundTransparency = 1, TextTransparency = 1})
				end
			end
			repeat wait() until element.BackgroundTransparency == 1
			element:Destroy()
		end

		local tt2 = {}

		if buttons then
			for i,title in pairs(buttons) do
				local button = elementCreate.button()

				button.Name = title
				button.ZIndex = 2
				button.Parent = element.ButtonContainer
				button.AnchorPoint = Vector2.new(0.5, 0.5)
				button.Text = title
				button.Size = UDim2.new(math.clamp(button.TextBounds.X + 10, 75, 999) / element.ButtonContainer.AbsoluteSize.X, 0, 1, 0)
				button.BackgroundTransparency = 1
				button.TextTransparency = 1

				button.MouseEnter:Connect(function()
					if a then return end
					if tt2[button] ~= nil then tt2[button]:Cancel() end
					local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
					local h,s,v = Color3.toHSV(button.BackgroundColor3)
					local finalcolor
					if s > 0.15 then
						finalcolor = Color3.fromHSV(h, s - 0.15, v)
					elseif v < 0.85 then
						finalcolor = Color3.fromHSV(h, s, v + 0.15)
					end
					local t = ts:Create(button, tinfo, {BackgroundColor3 = finalcolor})
					t:Play()
					tt2[button] = t
				end)

				button.MouseLeave:Connect(function()
					if a then return end
					if tt2[button] ~= nil then tt2[button]:Cancel() end
					local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
					local t = ts:Create(button, tinfo, {BackgroundColor3 = lib.settings.uiColor})
					t:Play()
					tt2[button] = t
				end)

				button.MouseButton1Down:Connect(function()
					if lib.settings.theme == 0 then
						button.TextColor3 = Color3.fromRGB(225, 225, 225)
					else
						button.TextColor3 = Color3.fromRGB(20, 20, 20)
					end
				end)

				button.MouseButton1Up:Connect(function()
					if lib.settings.theme == 0 then
						button.TextColor3 = Color3.fromRGB(20, 20, 20)
					else
						button.TextColor3 = Color3.fromRGB(225, 225, 225)
					end
				end)

				button.MouseButton1Click:Connect(function()
					task.spawn(hide)
					if callback then callback(title) end
				end)
			end
		end

		--[[for i,v in pairs(element:GetDescendants()) do
			if v.ClassName ~= "UICorner" and v.ClassName ~= "UIListLayout" then
				v.Size = UDim2.new(v.AbsoluteSize.X / v.Parent.AbsoluteSize.X, 0, v.AbsoluteSize.Y / v.Parent.AbsoluteSize.Y, 0)
			end
		end]]

		show()

		return {
			hide = hide,
			editTitle = function(editedTitle)
				element.Top.Title.Text = editedTitle
			end,
			editText = function(editedText)
				element.Label.Text = editedText
			end,
			getObj = function()
				return element
			end,
		}
	end

	local function showMenu(options)
		local menuObj = elementCreate.menu()

		menuObj.Name = randomString(30)
		menuObj.BackgroundTransparency = 1
		menuObj.Parent = gui

		local maxSize = 0

		for i,v in ipairs(options) do
			local option = elementCreate.menuOption()

			option.Name = v.Name
			option.TextTransparency = 1
			option.Parent = menuObj
			option.Text = v.Name

			option.Size = UDim2.fromOffset(option.TextBounds.X + 10, 30)

			if maxSize < option.TextBounds.X then
				maxSize = option.TextBounds.X
			end

			option.MouseButton1Down:Connect(function()
				v.Callback()
			end)
		end

		menuObj.Size = UDim2.fromOffset(maxSize + 20, menuObj.ListLayout.AbsoluteContentSize.Y)
		menuObj.Position = UDim2.fromOffset(mouse().X, mouse().Y)

		local function tween(obj, props)
			if tt[obj] ~= nil then tt[obj]:Cancel() end
			local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local t = ts:Create(obj, tinfo, props)
			t:Play()
			tt[obj] = t
		end

		local function show()
			tween(menuObj, {BackgroundTransparency = 0})
			for i,v in ipairs(options) do
				tween(menuObj[v.Name], {TextTransparency = 0})
			end
		end

		local function destroy()
			tween(menuObj, {BackgroundTransparency = 1})
			for i,v in ipairs(options) do
				tween(menuObj[v.Name], {TextTransparency = 1})
			end
			wait(0.5)
			menuObj:Destroy()
		end

		show()
		wait(0.1)

		local connection1
		local connection2

		connection1 = uis.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				destroy()
				connection1:Disconnect()
				connection2:Disconnect()
			end
		end)

		connection2 = uis.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				destroy()
				connection1:Disconnect()
				connection2:Disconnect()
			end
		end)

		table.insert(lib.connections, connection1)
		table.insert(lib.connections, connection2)
	end

	local function selectTab(tabName)
		tbContainer[tabName].TextColor3 = lib.settings.uiColor
		insert_colorable(tbContainer[tabName], 1)
		remove_texts(tbContainer[tabName])
		for i,v in pairs(tbContainer:GetChildren()) do
			if v.Name ~= tabName and v.Name ~= "ListLayout" and v.Name ~= "Padding" then
				remove_colorable(v)
				insert_texts(v)
				if lib.settings.theme == 0 then
					v.TextColor3 = Color3.fromRGB(255, 255, 255)
				elseif lib.settings.theme == 1 then
					v.TextColor3 = Color3.fromRGB(0, 0, 0)
				end
			end
		end
		--[[if tt[tContainer] ~= nil then tt[tContainer]:Cancel() end
		local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local t = ts:Create(tContainer, tinfo, {CanvasPosition = Vector2.new(0, 425 * tContainer[tabName].LayoutOrder)})
		t:Play()
		tt[tContainer] = t]]
		tContainer._PageLayout:JumpTo(tContainer[tabName])
	end
	
	-- Palette
	
	local Palette = {isMouseOnPalette = false, lock = false}
	
	local paletteObj : Frame = elementCreate.palette()
	paletteObj.Parent = gui
	
	local paletteCurrentCallback = function() end

	local SettingValue = false
	local SettingHueSat = false
	
	Palette.Init = function()
		local ValImg : Frame = paletteObj.ValImg
		local HueSatImg : ImageLabel = paletteObj.HueSatImg
		local Cursor = HueSatImg.Cursor
		local Arrow = ValImg.Arrow
		
		local Color = {0, 0, 1}
		
		paletteObj.MouseEnter:Connect(function()
			Palette.isMouseOnPalette = true
		end)
		
		paletteObj.MouseLeave:Connect(function()
			Palette.isMouseOnPalette = false
		end)
		
		--[[uis.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				if not Palette.isMouseOnPalette and paletteObj.Visible and not Palette.lock then
					SettingValue = false
					SettingHueSat = false
					paletteObj.Visible = false
					paletteObj.Position = UDim2.new(-1, 0, -1, 0)
				end
			end
		end)]]
		
		ValImg.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Palette.isMouseOnPalette = true
				SettingValue = true
			end
		end)
		
		ValImg.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Palette.isMouseOnPalette = false
				SettingValue = false
				
				local Value = math.clamp((ValImg.AbsolutePosition.Y - input.Position.Y + ValImg.AbsoluteSize.Y) / ValImg.AbsoluteSize.Y, 0, 1)
				Arrow.Position = UDim2.new(1, 0, math.clamp((input.Position.Y - ValImg.AbsolutePosition.Y) / ValImg.AbsoluteSize.Y, 0, 1), 0)
				Color[3] = Value
				paletteCurrentCallback(Color3.fromHSV(Color[1], Color[2], Color[3]))
			end
		end)
		
		HueSatImg.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Palette.isMouseOnPalette = true
				SettingHueSat = true

				local Hue = math.clamp((HueSatImg.AbsolutePosition.X - input.Position.X + HueSatImg.AbsoluteSize.X) / HueSatImg.AbsoluteSize.X, 0, 1)
				local Sat = math.clamp((HueSatImg.AbsolutePosition.Y - input.Position.Y + HueSatImg.AbsoluteSize.Y) / HueSatImg.AbsoluteSize.Y, 0, 1)
				Cursor.Position = UDim2.new(math.clamp((input.Position.x - HueSatImg.AbsolutePosition.x) / HueSatImg.AbsoluteSize.X, 0, 1), 0, math.clamp((input.Position.Y - HueSatImg.AbsolutePosition.Y) / HueSatImg.AbsoluteSize.Y, 0, 1), 0)
				Color[1] = Hue
				Color[2] = Sat
				
				ValImg.BackgroundColor3 = Color3.fromHSV(Hue, Sat, 1)
				paletteCurrentCallback(Color3.fromHSV(Color[1], Color[2], Color[3]))
			end
		end)

		HueSatImg.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Palette.isMouseOnPalette = false
				SettingHueSat = false
			end
		end)

        table.insert(lib.connections, uis.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                if SettingValue then
                    local Value = math.clamp((ValImg.AbsolutePosition.Y - input.Position.Y + ValImg.AbsoluteSize.Y) / ValImg.AbsoluteSize.Y, 0, 1)
                    Arrow.Position = UDim2.new(1, 0, math.clamp((input.Position.Y - ValImg.AbsolutePosition.Y) / ValImg.AbsoluteSize.Y, 0, 1), 0)
                    Color[3] = Value
                    paletteCurrentCallback(Color3.fromHSV(Color[1], Color[2], Color[3]))
                end
                if SettingHueSat then
                    local Hue = math.clamp((HueSatImg.AbsolutePosition.X - input.Position.X + HueSatImg.AbsoluteSize.X) / HueSatImg.AbsoluteSize.X, 0, 1)
                    local Sat = math.clamp((HueSatImg.AbsolutePosition.Y - input.Position.Y + HueSatImg.AbsoluteSize.Y) / HueSatImg.AbsoluteSize.Y, 0, 1)
                    Cursor.Position = UDim2.new(math.clamp((input.Position.x - HueSatImg.AbsolutePosition.x) / HueSatImg.AbsoluteSize.X, 0, 1), 0, math.clamp((input.Position.Y - HueSatImg.AbsolutePosition.Y) / HueSatImg.AbsoluteSize.Y, 0, 1), 0)
                    Color[1] = Hue
                    Color[2] = Sat
                    
                    ValImg.BackgroundColor3 = Color3.fromHSV(Hue, Sat, 1)
                    paletteCurrentCallback(Color3.fromHSV(Color[1], Color[2], Color[3]))
                end
            end
        end))
	end
	
	Palette.SetColor = function(color)
		local h,s,v = Color3.toHSV(color)
		
		local ValImg : Frame = paletteObj.ValImg
		local HueSatImg : ImageLabel = paletteObj.HueSatImg
		local Cursor = HueSatImg.Cursor
		local Arrow = ValImg.Arrow
		
		ValImg.BackgroundColor3 = Color3.fromHSV(h, s, 1)
		Arrow.Position = UDim2.new(1, 0, 1 - v, 0)
		
		Cursor.Position = UDim2.new(1 - h, 0, 1 - s, 0)
	end
	
	Palette.Show = function(position, callback)
		if paletteObj.Visible then
			SettingValue = false
			SettingHueSat = false
			paletteObj.Visible = false
			paletteObj.Position = UDim2.new(-1, 0, -1, 0)
			return
		end
        Palette.lock = true
		paletteObj.Visible = true
		paletteObj.Position = position
		paletteCurrentCallback = callback
        wait(.1)
        Palette.lock = false
	end

    Palette.Init()

	table.insert(lib.connections, uis.InputEnded:Connect(function(i, gpe)
		if i.KeyCode == Enum.KeyCode.RightControl and not gpe then
			gui.Enabled = not gui.Enabled
		end
	end))

	libNew.addTab = function(tabName)
		local addTab = {}

		local tab = elementCreate.tab()
		local tabButton = elementCreate.tabButton()

		tab.Name = tabName
		tab.Parent = tContainer

		tabButton.Name = tabName
		tabButton.Parent = tbContainer
		tabButton.Text = tabName

		insert_scrollbars(tab)
		insert_texts(tabButton)

		tab.LayoutOrder = lib.tabCount
		lib.tabCount += 1

		local function getSide(longest)
			local Left = tab.Left.ListLayout
			local Right = tab.Right.ListLayout
			if Left.AbsoluteContentSize.Y > Right.AbsoluteContentSize.Y then
				if longest then
					return Left.Parent
				else
					return Right.Parent
				end
			elseif Left.AbsoluteContentSize.Y < Right.AbsoluteContentSize.Y then
				if longest then
					return Right.Parent
				else
					return Left.Parent
				end
			else
				return Left.Parent
			end
		end

		local function a()
			if getSide(true).Name == "Left" then
				tab.CanvasSize = UDim2.new(0, 0, 0, tab.Left.ListLayout.AbsoluteContentSize.Y + 20)
			else
				tab.CanvasSize = UDim2.new(0, 0, 0, tab.Right.ListLayout.AbsoluteContentSize.Y + 20)
			end
		end
		tab.Left.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(a)
		tab.Right.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(a)

		if lib.tabCount == 1 then
			selectTab(tabName)
		end

		tabButton.MouseButton1Click:Connect(function()
			selectTab(tabName)
		end)

		addTab.addSection = function(sectionName)
			local addSection = {}

			local section = elementCreate.section()
			local sectionTitle = section.Title
			local sectionLine = section.Line
			local sectionContainer = section.Container

			section.Name = sectionName
			section.Parent = getSide(false)
			sectionTitle.Text = sectionName

			insert_texts(sectionTitle)
			insert_colorable2(sectionLine)

			sectionContainer.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				section.Size = UDim2.new(0, 170, 0, 35 + sectionContainer.ListLayout.AbsoluteContentSize.Y)
				sectionContainer.Size = UDim2.new(0, 170, 0, sectionContainer.ListLayout.AbsoluteContentSize.Y + 10)
			end)

			addSection.addLabel = function(labelText, labelAlignment)
				local addLabel = {}

				local label = elementCreate.label()

				label.Name = randomString(30)
				label.Parent = sectionContainer
				--label.Text = #labelText > 26 and labelText:sub(1, 26).."..." or labelText
				label.Text = labelText
				label.TextXAlignment = labelAlignment == 0 and Enum.TextXAlignment.Left or labelAlignment == 1 and Enum.TextXAlignment.Center or labelAlignment == 2 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Center

				label.Size = UDim2.new(0, 170, 0, textService:GetTextSize(labelText, 12, Enum.Font.Ubuntu, Vector2.new(170, 99999)).Y)

				insert_texts(label)

				--[[local labelTooltip

				if #labelText > 26 then
					labelTooltip = addTooltip(label, labelText)
				end]]

				addLabel.getObj = function(prop)
					return label
				end

				addLabel.set = function(val, prop)
					if prop == 1 then
						label.TextXAlignment = val == 0 and Enum.TextXAlignment.Left or val == 1 and Enum.TextXAlignment.Center or val == 2 and Enum.TextXAlignment.Right
					else
						label.Text = val
						label.Size = UDim2.new(0, 170, 0, textService:GetTextSize(val, 12, Enum.Font.Ubuntu, Vector2.new(170, 99999)).Y)
						--[[label.Text = #val > 26 and val:sub(1, 26).."..." or val
						if #val > 26 then
							if labelTooltip then
								labelTooltip()
							end
							labelTooltip = addTooltip(label, val)
						else
							if labelTooltip then
								labelTooltip()
							end
						end]]
					end
				end

				return addLabel
			end

			addSection.addButton = function(args)
				local buttonText = args.name
				local buttonCallback = args.callback or function() end
				local info = args.info
				local disabled = args.disabled

				local addButton = {}

				local button = elementCreate.button()

				button.Name = buttonText
				button.Parent = sectionContainer
				if #buttonText > 26 or string.find(buttonText, "\n") then
					button.Text = buttonText:sub(1, 26).."..."
				else
					button.Text = buttonText
				end

				local disabled = disabled

				if disabled then
					button.BackgroundTransparency = 0.5
					button.TextTransparency = 0.5
				end

				insert_colorable(button, 0)
				insert_buttons(button)

				local buttonTooltip

				if #buttonText > 26 or string.find(buttonText, "\n") then
					buttonTooltip = addTooltip(button, buttonText)
				end

				button.MouseEnter:Connect(function()
					if not disabled then
						if tt[button] ~= nil then tt[button]:Cancel() end
						local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
						local h,s,v = Color3.toHSV(button.BackgroundColor3)
						local finalcolor
						if s > 0.15 then
							finalcolor = Color3.fromHSV(h, s - 0.15, v)
						elseif v < 0.85 then
							finalcolor = Color3.fromHSV(h, s, v + 0.15)
						end
						local t = ts:Create(button, tinfo, {BackgroundColor3 = finalcolor})
						t:Play()
						tt[button] = t
					end
				end)

				button.MouseLeave:Connect(function()
					if not disabled then
						if tt[button] ~= nil then tt[button]:Cancel() end
						local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
						local t = ts:Create(button, tinfo, {BackgroundColor3 = lib.settings.uiColor})
						t:Play()
						tt[button] = t
					end
				end)

				button.MouseButton1Down:Connect(function()
					if not disabled then
						if lib.settings.theme == 0 then
							button.TextColor3 = Color3.fromRGB(225, 225, 225)
						else
							button.TextColor3 = Color3.fromRGB(20, 20, 20)
						end
					end
				end)

				button.MouseButton1Up:Connect(function()
					if lib.settings.theme == 0 then
						button.TextColor3 = Color3.fromRGB(20, 20, 20)
					else
						button.TextColor3 = Color3.fromRGB(225, 225, 225)
					end
				end)

				local callback = buttonCallback
				local keybind = nil
				local binding = false

				local function startBinding()
					binding = true
					local keybindtext
					if keybind == nil then
						keybindtext = "nil"
					else
						keybindtext = keybind.Name
					end
					local disconnecting = false
					local inputconnection
					local function disconnect()
						inputconnection:Disconnect()
					end
					local msgbox = messageBox("Keybind ("..button.Text..") ["..keybindtext.."]", "Press key to bind...", {"Cancel"}, function()
						binding = false
						disconnect()
					end)
					inputconnection = uis.InputEnded:Connect(function(input)
						if disconnecting then return end
						if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode ~= Enum.KeyCode.LeftControl and not uis:GetFocusedTextBox() then
							local blacklist = {"W","A","S","D","Slash","Tab","Backspace","Escape","Space","Delete","Unknown","Backquote","LeftControl"}
							local blacklisted = table.find(blacklist, input.KeyCode.Name) and true or false
							disconnecting = true
							if blacklisted then
								keybind = nil
							else
								keybind = input.KeyCode
							end
							local keybindName = keybind and keybind.Name or "NONE"
							msgbox.editText("Binded: ["..keybindName.."]")
							wait(1)
							msgbox.hide()
							binding = false
							disconnect()
						end
					end)
					table.insert(lib.connections, inputconnection)
				end

				button.MouseButton2Down:Connect(function()
					if info ~= nil then
						if keybind ~= nil then
							showMenu({
								{
									Name = "Info",
									Callback = function()
										messageBox(buttonText, info, {"Ok"})
									end
								},
								{
									Name = "Set Keybind",
									Callback = function()
										startBinding()
									end
								},
								{
									Name = "Remove Keybind",
									Callback = function()
										keybind = nil
									end
								}
							})
						else
							showMenu({
								{
									Name = "Info",
									Callback = function()
										messageBox(buttonText, info, {"Ok"})
									end
								},
								{
									Name = "Set Keybind",
									Callback = function()
										startBinding()
									end
								}
							})
						end
					else
						if keybind ~= nil then
							showMenu({
								{
									Name = "Set Keybind",
									Callback = function()
										startBinding()
									end
								},
								{
									Name = "Remove Keybind",
									Callback = function()
										keybind = nil
									end
								}
							})
						else
							showMenu({
								{
									Name = "Set Keybind",
									Callback = function()
										startBinding()
									end
								}
							})
						end
					end
				end)

				button.MouseButton1Click:Connect(function()
					if not disabled then
						callback()
					end
				end)

				--[[button.MouseButton1Click:Connect(function()
					if lib.settings.keybinds and lib.ctrl_pressed then

					end
				end)]]

				table.insert(lib.connections, uis.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == keybind and not disabled and not binding and not uis:GetFocusedTextBox() then
							callback()
						end
					end
				end))

				addButton.getObj = function()
					return button
				end

				addButton.set = function(val, prop)
					prop = prop or 0
					if prop == 0 then
						if #val > 26 or string.find(val, "\n") then
							button.Text = val:sub(1, 26).."..."
						else
							button.Text = val
						end
						if #val > 26 then
							if buttonTooltip then
								buttonTooltip()
							end
							buttonTooltip = addTooltip(button, val)
						else
							if buttonTooltip then
								buttonTooltip()
							end
						end
					elseif prop == 1 then
						callback = val
					elseif prop == 2 then
						if val then
							disabled = val
							button.BackgroundTransparency = 0.5
							button.TextTransparency = 0.5
						else
							disabled = val
							button.BackgroundTransparency = 0
							button.TextTransparency = 0
						end
					end
				end

				return addButton
			end

			addSection.addToggle = function(args)
				local toggleName = args.name
				local initState = args.initState
				local toggleCallback = args.callback or function() end
				local info = args.info
				local disabled = args.disabled

				local addToggle = {}

				local stateBool = initState or false
				toggleCallback = toggleCallback

				local toggle = elementCreate.toggle()

				toggle.Name = toggleName
				toggle.Parent = sectionContainer

				if #toggleName > 20 or string.find(toggleName, "\n") then
					toggle.Text = toggleName:sub(1, 20).."..."
				else
					toggle.Text = toggleName
				end

				if stateBool then
					toggle.Toggle.BackgroundColor3 = lib.settings.uiColor
					insert_colorable(toggle.Toggle, 0)
					toggle.Toggle.Circle.Position = UDim2.new(0, 17, 0, 3)
				end

				if disabled then
					toggle.TextTransparency = 0.5
					toggle.Toggle.BackgroundTransparency = 0.5
					toggle.Toggle.Circle.BackgroundTransparency = 0.5
				end

				insert_texts(toggle)
				insert_placeholders(toggle.Toggle)
				insert_texts(toggle.Toggle.Circle)

				local toggleTooltip

				if #toggleName > 20 or string.find(toggleName, "\n") then
					toggleTooltip = addTooltip(toggle, toggleName)
				end

				local function setState(bool)
					if tt[toggle.Toggle.Circle] ~= nil then tt[toggle.Toggle.Circle]:Cancel() end
					if tt[toggle.Toggle] ~= nil then tt[toggle.Toggle]:Cancel() end
					local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					local tween1 = ts:Create(toggle.Toggle.Circle, tinfo, {Position = UDim2.new(0, bool and 17 or not bool and 3, 0, 3)})
					local tween2 = ts:Create(toggle.Toggle, tinfo, {BackgroundColor3 = bool and lib.settings.uiColor or not bool and Color3.fromRGB(40, 40, 40)})
					tween1:Play()
					tween2:Play()
					tt[toggle.Toggle.Circle] = tween1
					tt[toggle.Toggle] = tween2
					if bool then
						insert_colorable(toggle.Toggle, 0)
					else
						remove_colorable(toggle.Toggle)
					end
				end

				toggle.MouseButton1Click:Connect(function()
					if not disabled then
						stateBool = not stateBool
						setState(stateBool)
						toggleCallback(stateBool)
					end
				end)

				local keybind = nil
				local binding = false

				local function startBinding()
					binding = true
					local keybindtext
					if keybind == nil then
						keybindtext = "NONE"
					else
						keybindtext = keybind.Name
					end
					local disconnecting = false
					local inputconnection
					local function disconnect()
						inputconnection:Disconnect()
					end
					local msgbox = messageBox("Keybind ("..toggle.Text..") ["..keybindtext.."]", "Press key to bind...", {"Cancel"}, function()
						binding = false
						disconnect()
					end)
					inputconnection = uis.InputEnded:Connect(function(input)
						if disconnecting then return end
						if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode ~= Enum.KeyCode.LeftControl and not uis:GetFocusedTextBox() then
							local blacklist = {"W","A","S","D","Slash","Tab","Backspace","Escape","Space","Delete","Unknown","Backquote"}
							local blacklisted = table.find(blacklist, input.KeyCode.Name) and true or false
							disconnecting = true
							if blacklisted then
								keybind = nil
							else
								keybind = input.KeyCode
							end
							local keybindName = keybind and keybind.Name or "NONE"
							msgbox.editText("Binded: ["..keybindName.."]")
							wait(1)
							msgbox.hide()
							binding = false
							disconnect()
						end
					end)
					table.insert(lib.connections, inputconnection)
				end

				toggle.MouseButton2Down:Connect(function()
					if info ~= nil then
						if keybind ~= nil then
							showMenu({
								{
									Name = "Info",
									Callback = function()
										messageBox(toggleName, info, {"Ok"})
									end
								},
								{
									Name = "Set Keybind",
									Callback = function()
										startBinding()
									end
								},
								{
									Name = "Remove Keybind",
									Callback = function()
										keybind = nil
									end
								}
							})
						else
							showMenu({
								{
									Name = "Info",
									Callback = function()
										messageBox(toggleName, info, {"Ok"})
									end
								},
								{
									Name = "Set Keybind",
									Callback = function()
										startBinding()
									end
								}
							})
						end
					else
						if keybind ~= nil then
							showMenu({
								{
									Name = "Set Keybind",
									Callback = function()
										startBinding()
									end
								},
								{
									Name = "Remove Keybind",
									Callback = function()
										keybind = nil
									end
								}
							})
						else
							showMenu({
								{
									Name = "Set Keybind",
									Callback = function()
										startBinding()
									end
								}
							})
						end
					end
				end)

				table.insert(lib.connections, uis.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == keybind and not disabled and not binding and not uis:GetFocusedTextBox() then
							stateBool = not stateBool
							setState(stateBool)
							toggleCallback(stateBool)
						end
					end
				end))

				addToggle.getObj = function()
					return toggle
				end

				addToggle.set = function(val, prop)
					prop = prop or 3
					if prop == 0 then
						if #val > 20 or string.find(val, "\n") then
							toggle.Text = val:sub(1, 20).."..."
						else
							toggle.Text = val
						end
						if #val > 20 then
							if toggleTooltip then
								toggleTooltip()
								toggleTooltip = nil
							end
							toggleTooltip = addTooltip(toggle, val)
						elseif #val <= 20 and toggleTooltip then
							toggleTooltip()
							toggleTooltip = nil
						end
					elseif prop == 1 then
						toggleCallback = val
					elseif prop == 2 then
						if val then
							disabled = val
							toggle.TextTransparency = 0.5
							toggle.Toggle.BackgroundTransparency = 0.5
							toggle.Toggle.Circle.BackgroundTransparency = 0.5
						else
							disabled = val
							toggle.TextTransparency = 0
							toggle.Toggle.BackgroundTransparency = 0
							toggle.Toggle.Circle.BackgroundTransparency = 0
						end
					elseif prop == 3 then
						stateBool = val
						setState(stateBool)
						toggleCallback(stateBool)
					end
				end

				addToggle.get = function()
					return stateBool
				end

				return addToggle
			end

			addSection.addTextField = function(args)
				local fieldName = args.name
				local fieldPlaceholder = args.placeholder
				local fieldCallback = args.callback or function() end
				local fieldDisabled = args.disabled
				local fieldFilter = args.filter

				local addTextField = {}

				local fieldCallback = fieldCallback
				local textField = elementCreate.textField()

				textField.Name = fieldName
				textField.Parent = sectionContainer
				textField.Field.PlaceholderText = fieldPlaceholder

				if #fieldName > 26 or string.find(fieldName, "\n") then
					textField.FieldName.Text = fieldName:sub(1, 26).."..."
				else
					textField.FieldName.Text = fieldName
				end

				local fieldTooltip

				if #fieldName > 26 or string.find(fieldName, "\n") then
					fieldTooltip = addTooltip(textField.FieldName, fieldName)
				end

				textField.Field.FocusLost:Connect(function()
					fieldCallback(textField.Field.Text)
				end)

				if fieldFilter then
					textField.Field:GetPropertyChangedSignal("Text"):Connect(function()
						textField.Field.Text = textField.Field.Text:match(fieldFilter) or ""
					end)
				end

				addTextField.getObj = function()
					return textField
				end

				addTextField.set = function(val, prop)
					prop = prop or 3
					if prop == 0 then
						if #val > 26 or string.find(val, "\n") then
							textField.FieldName.Text = val:sub(1, 26).."..."
						else
							textField.FieldName.Text = val
						end
						if #val > 26 then
							if fieldTooltip then
								fieldTooltip()
								fieldTooltip = nil
							end
							fieldTooltip = addTooltip(textField.FieldName, val)
						elseif #val <= 26 and fieldTooltip then
							fieldTooltip()
							fieldTooltip = nil
						end
					elseif prop == 1 then
						fieldCallback = val
					elseif prop == 2 then

					elseif prop == 3 then
						textField.Field.Text = val
						fieldCallback(val)
					end
				end

				addTextField.get = function()
					return textField.Field.Text
				end

				return addTextField
			end

			addSection.addSlider = function(args)
				local sliderName = args.name
				local min = args.min
				local max = args.max
				local initVal = args.initVal
				local decimals = args.decimals
				local suffix = args.suffix
				local sliderCallback = args.callback or function() end


				local addSlider = {}

				decimals = decimals or 0
				suffix = suffix or ""
				sliderCallback = sliderCallback

				local SliderMain = elementCreate.slider()
				local Slider = SliderMain.SliderBorder.Slider.Slider

				local GlobalSliderValue = initVal and math.clamp(initVal, min, max) or (min + max) / 2

				SliderMain.Name = sliderName
				SliderMain.Parent = sectionContainer

				if #sliderName > 26 or string.find(sliderName, "\n") then
					SliderMain.SliderName.Text = sliderName:sub(1, 26).."..."
				else
					SliderMain.SliderName.Text = sliderName
				end

				local sliderTooltip

				if #sliderName > 26 or string.find(sliderName, "\n") then
					sliderTooltip = addTooltip(SliderMain.SliderName, sliderName)
				end

				insert_colorable(SliderMain.SliderBorder, 0)
				insert_colorable(Slider, 0)


				local function round(num, numDecimalPlaces)
					local mult = 10^(numDecimalPlaces or 0)
					return math.floor(num * mult + 0.5) / mult
				end

				local Sliding = false

				SliderMain.SliderBorder.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						Sliding = true
						local Position = UDim2.new(math.clamp((i.Position.X - SliderMain.SliderBorder.AbsolutePosition.X) / SliderMain.SliderBorder.AbsoluteSize.X, 0, 1), 0, 0, 6)
						if tt[Slider] ~= nil then tt[Slider]:Cancel() end
						local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
						local t = ts:Create(Slider, tinfo, {Size = Position})
						t:Play()
						local Percentage = Position.X.Scale
						local SliderValue = round(Percentage * (max - min) + min, decimals)
						GlobalSliderValue = SliderValue
						SliderMain.SliderValue.Text = tostring(SliderValue)..suffix
					end
				end)

				SliderMain.SliderBorder.InputEnded:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						Sliding = false
						sliderCallback(GlobalSliderValue)
					end
				end)

				table.insert(lib.connections, uis.InputChanged:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
						if Sliding then
							local Position = UDim2.new(math.clamp((i.Position.X - SliderMain.SliderBorder.AbsolutePosition.X) / SliderMain.SliderBorder.AbsoluteSize.X, 0, 1), 0, 0, 6)
							if tt[Slider] ~= nil then tt[Slider]:Cancel() end
							local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
							local t = ts:Create(Slider, tinfo, {Size = Position})
							t:Play()
							local Percentage = Position.X.Scale
							local SliderValue = round(Percentage * (max - min) + min, decimals)
							SliderMain.SliderValue.Text = tostring(SliderValue)..suffix
							GlobalSliderValue = SliderValue
						end
					end
				end))

				local function setValue(value, call)
					value = math.clamp(value, min, max)
					local percent = (value - min) / (max - min)
					GlobalSliderValue = value
					Slider.Size = UDim2.new(math.clamp(percent, 0, 1), 0, 0, 6)
					SliderMain.SliderValue.Text = tostring(round(value, decimals))..suffix
					if call then
						sliderCallback(GlobalSliderValue)
					end
				end

				setValue(GlobalSliderValue)

				addSlider.getObj = function()
					return SliderMain
				end

				addSlider.set = function(val, prop)
					prop = prop or 3
					if prop == 0 then
						if #val > 26 or string.find(val, "\n") then
							SliderMain.SliderName.Text = val:sub(1, 26).."..."
						else
							SliderMain.SliderName.Text = val
						end
						if #val > 26 then
							if sliderTooltip then
								sliderTooltip()
								sliderTooltip = nil
							end
							sliderTooltip = addTooltip(SliderMain.SliderName, val)
						elseif #val <= 26 and sliderTooltip then
							sliderTooltip()
							sliderTooltip = nil
						end
					elseif prop == 1 then
						sliderCallback = val
					elseif prop == 2 then

					elseif prop == 3 then
						setValue(val, true)
					end
				end

				addSlider.get = function()
					return GlobalSliderValue
				end

				return addSlider
			end

			addSection.addDropdown = function(args)
				local dropdownName = args.name
				local options = args.options
				local initVal = args.initVal
				local multiSelect = args.multiSelect
				local searchBoxEnabled = args.searchBoxEnabled
				local dropdownCallback = args.callback or function() end

				local addDropdown = {}

				local currentVal = initVal or nil

				local Dropdown = elementCreate.dropdown()
				local DropdownContainer = Dropdown.Container.Container

				Dropdown.Name = dropdownName
				Dropdown.Parent = sectionContainer

				if #dropdownName > 20 or string.find(dropdownName, "\n") then
					Dropdown.DropdownName.Text = dropdownName:sub(1, 26).."..."
				else
					Dropdown.DropdownName.Text = dropdownName
				end

				local dropdownTooltip

				if #dropdownName > 26 or string.find(dropdownName, "\n") then
					dropdownTooltip = addTooltip(Dropdown.DropdownName, dropdownName)
				end

				if not searchBoxEnabled then
					DropdownContainer.Parent._SearchBox:Destroy()
					DropdownContainer.Position = UDim2.new(0, 0, 0, 0)
				end

				local opened = false
				local searchBoxSizeY = searchBoxEnabled and 18 or 0

				local containerSizeY = math.clamp(DropdownContainer.ListLayout.AbsoluteContentSize.Y, 0, 200)
				DropdownContainer.Parent.Size = UDim2.new(0, 170, 0, math.clamp(DropdownContainer.ListLayout.AbsoluteContentSize.Y + searchBoxSizeY, searchBoxSizeY, 200 + searchBoxSizeY))
				DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownContainer.ListLayout.AbsoluteContentSize.Y)
				DropdownContainer.Size = UDim2.new(0, 170, 0, containerSizeY)
				if opened then
					Dropdown.Size = UDim2.new(0, 170, 0, 45 + containerSizeY + 10 + searchBoxSizeY)
				end

				DropdownContainer.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					containerSizeY = math.clamp(DropdownContainer.ListLayout.AbsoluteContentSize.Y, 0, 200)
					DropdownContainer.Parent.Size = UDim2.new(0, 170, 0, math.clamp(DropdownContainer.ListLayout.AbsoluteContentSize.Y + searchBoxSizeY, searchBoxSizeY, 200 + searchBoxSizeY))
					DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownContainer.ListLayout.AbsoluteContentSize.Y)
					DropdownContainer.Size = UDim2.new(0, 170, 0, containerSizeY)
					if opened then
						Dropdown.Size = UDim2.new(0, 170, 0, 45 + containerSizeY + 10 + searchBoxSizeY)
					end
				end)

				local function cleanSearchBox()
					if searchBoxEnabled then
						DropdownContainer.Parent._SearchBox.Text = ""
					end
				end

				local function open()
					cleanSearchBox()
					if tt[Dropdown] ~= nil then tt[Dropdown]:Cancel() end
					if tt[Dropdown.Toggle.Arrow] ~= nil then tt[Dropdown.Toggle.Arrow]:Cancel() end
					local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					local t = ts:Create(Dropdown, tinfo, {Size = UDim2.new(0, 170, 0, 45 + containerSizeY + 10 + searchBoxSizeY)})
					local t2 = ts:Create(Dropdown.Toggle.Arrow, tinfo, {Rotation = 180})
					t:Play()
					t2:Play()
					if not uis.TouchEnabled then
						--DropdownContainer.Parent._SearchBox:CaptureFocus()
					end
					opened = true
				end

				local function close()
					if tt[Dropdown] ~= nil then tt[Dropdown]:Cancel() end
					if tt[Dropdown.Toggle.Arrow] ~= nil then tt[Dropdown.Toggle.Arrow]:Cancel() end
					local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					local t = ts:Create(Dropdown, tinfo, {Size = UDim2.new(0, 170, 0, 45)})
					local t2 = ts:Create(Dropdown.Toggle.Arrow, tinfo, {Rotation = 0})
					t:Play()
					t2:Play()
					opened = false
				end

				Dropdown.Toggle.MouseButton1Click:Connect(function()
					if opened then
						close()
					else
						open()
					end
				end)

				if searchBoxEnabled then
					DropdownContainer.Parent._SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
						if #DropdownContainer.Parent._SearchBox.Text > 0 then
							for i,v in pairs(DropdownContainer:GetChildren()) do
								if v:IsA("TextButton") and string.find(v.Text:lower(), DropdownContainer.Parent._SearchBox.Text:lower()) then
									v.Visible = true
								elseif v:IsA("TextButton") then
									v.Visible = false
								end
							end
						else
							for i,v in pairs(DropdownContainer:GetChildren()) do
								if v:IsA("TextButton")then
									v.Visible = true
								end
							end
						end
					end)
				end

				local selected = {}

				for i,v in pairs(options) do
					local option = elementCreate.dropdownOption()

					option.Name = v
					option.Parent = DropdownContainer
					option.Text = v

					if multiSelect then
						if initVal and table.find(initVal, v) then
							option.TextColor3 = lib.settings.uiColor
							insert_colorable(option, 1)
							table.insert(selected, v)
							Dropdown.Toggle.Value.Text = "Selected ("..#selected..")"
						end
					else
						if initVal == v then
							Dropdown.Toggle.Value.Text = v
						end
					end

					option.MouseButton1Click:Connect(function()
						if multiSelect then
							if table.find(selected, v) then
								option.TextColor3 = Color3.fromRGB(255, 255, 255)
								remove_colorable(option)
								table.remove(selected, table.find(selected, v))
								Dropdown.Toggle.Value.Text = "Selected ("..#selected..")"
								dropdownCallback(selected)
							else
								option.TextColor3 = lib.settings.uiColor
								insert_colorable(option, 1)
								table.insert(selected, v)
								Dropdown.Toggle.Value.Text = "Selected ("..#selected..")"
								dropdownCallback(selected)
							end
						else
							currentVal = v
							Dropdown.Toggle.Value.Text = v
							dropdownCallback(v)
							close()
						end
					end)
				end

				addDropdown.get = function()
					if multiSelect then
						return selected
					else
						return currentVal
					end
				end

				addDropdown.set = function(val, prop)
					prop = prop or 1
					if prop == 1 then
						if multiSelect then
							table.clear(selected)
							for i, option in pairs(DropdownContainer:GetChildren()) do
								if option:IsA("TextButton") and table.find(val, option.Text) then
									option.TextColor3 = lib.settings.uiColor
									insert_colorable(option, 1)
									table.insert(selected, option.Text)
									Dropdown.Toggle.Value.Text = "Selected ("..#selected..")"
								end
							end
							dropdownCallback(selected)
						else
							currentVal = val
							Dropdown.Toggle.Value.Text = val
							dropdownCallback(val)
						end
					elseif prop == 2 then
						for i, option in pairs(DropdownContainer:GetChildren()) do
							if option:IsA("TextButton") then
								option:Destroy()
							end
						end
						for i,v in pairs(val) do
							local option = elementCreate.dropdownOption()
		
							option.Name = v
							option.Parent = DropdownContainer
							option.Text = v

							if opened and #DropdownContainer.Parent._SearchBox.Text > 0 then
								if string.find(option.Text:lower(), DropdownContainer.Parent._SearchBox.Text:lower()) then
									option.Visible = true
								else
									option.Visible = false
								end
							else
								option.Visible = true
							end
		
							option.MouseButton1Click:Connect(function()
								if multiSelect then
									if table.find(selected, v) then
										option.TextColor3 = Color3.fromRGB(255, 255, 255)
										remove_colorable(option)
										table.remove(selected, table.find(selected, v))
										Dropdown.Toggle.Value.Text = "Selected ("..#selected..")"
										dropdownCallback(selected)
									else
										option.TextColor3 = lib.settings.uiColor
										insert_colorable(option, 1)
										table.insert(selected, v)
										Dropdown.Toggle.Value.Text = "Selected ("..#selected..")"
										dropdownCallback(selected)
									end
								else
									currentVal = v
									Dropdown.Toggle.Value.Text = v
									dropdownCallback(v)
									close()
								end
							end)
						end
					elseif prop == 3 then
						for i, option in pairs(DropdownContainer:GetChildren()) do
							if option:IsA("TextButton") and val[option.Text] then
								option.TextColor3 = val[option.Text]
							end
						end
					end
				end

				return addDropdown
			end

			addSection.addList = function(args)
				local listName = args.name
				local initVal = args.initVal or {}
				local objectsName = args.objectsName or "Objects"
				local addPlaceholder = args.addPlaceholder or "Object Name"
				local addCallback = args.addCallback or function() return true end
				local removeCallback = args.removeCallback or function() return true end
				local updateCallback = args.updateCallback

				local addList = {}

				local currentVal = initVal or nil

				local List = elementCreate.list()
				local ListContainer = List.Container.Container

				List.Name = listName
				List.Parent = sectionContainer

				List.Container.Add.Field.PlaceholderText = addPlaceholder
				List.Toggle.Value.Text = #currentVal.." "..objectsName

				if #listName > 26 or string.find(listName, "\n") then
					List.ListName.Text = listName:sub(1, 26).."..."
				else
					List.ListName.Text = listName
				end

				local listTooltip

				if #listName > 26 or string.find(listName, "\n") then
					listTooltip = addTooltip(List.ListName, listName)
				end

				local opened = false
				local containerSizeY = 0

				containerSizeY = math.clamp(ListContainer.ListLayout.AbsoluteContentSize.Y, 0, 200)
				ListContainer.Parent.Size = UDim2.new(0, 170, 0, math.clamp(ListContainer.ListLayout.AbsoluteContentSize.Y + 24, 24, 224))
				ListContainer.CanvasSize = UDim2.new(0, 0, 0, ListContainer.ListLayout.AbsoluteContentSize.Y)
				ListContainer.Size = UDim2.new(0, 170, 0, containerSizeY)
				if opened then
					List.Size = UDim2.new(0, 170, 0, 45 + containerSizeY + 10 + 24)
				end

				ListContainer.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					containerSizeY = math.clamp(ListContainer.ListLayout.AbsoluteContentSize.Y, 0, 200)
					ListContainer.Parent.Size = UDim2.new(0, 170, 0, math.clamp(ListContainer.ListLayout.AbsoluteContentSize.Y + 24, 24, 224))
					ListContainer.CanvasSize = UDim2.new(0, 0, 0, ListContainer.ListLayout.AbsoluteContentSize.Y)
					ListContainer.Size = UDim2.new(0, 170, 0, containerSizeY)
					if opened then
						List.Size = UDim2.new(0, 170, 0, 45 + containerSizeY + 10 + 24)
					end
				end)

				local function cleanAddBox()
					ListContainer.Parent.Add.Field.Text = ""
				end

				local function open()
					cleanAddBox()
					if tt[List] ~= nil then tt[List]:Cancel() end
					if tt[List.Toggle.Arrow] ~= nil then tt[List.Toggle.Arrow]:Cancel() end
					local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					local t = ts:Create(List, tinfo, {Size = UDim2.new(0, 170, 0, 45 + containerSizeY + 10 + 24)})
					local t2 = ts:Create(List.Toggle.Arrow, tinfo, {Rotation = 180})
					t:Play()
					t2:Play()
					if not uis.TouchEnabled then
						--DropdownContainer.Parent._SearchBox:CaptureFocus()
					end
					opened = true
				end

				local function close()
					if tt[List] ~= nil then tt[List]:Cancel() end
					if tt[List.Toggle.Arrow] ~= nil then tt[List.Toggle.Arrow]:Cancel() end
					local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					local t = ts:Create(List, tinfo, {Size = UDim2.new(0, 170, 0, 45)})
					local t2 = ts:Create(List.Toggle.Arrow, tinfo, {Rotation = 0})
					t:Play()
					t2:Play()
					opened = false
				end

				List.Toggle.MouseButton1Click:Connect(function()
					if opened then
						close()
					else
						open()
					end
				end)

				ListContainer.Parent.Add.Button.MouseButton1Click:Connect(function()
					local objectName = ListContainer.Parent.Add.Field.Text
					if #objectName < 1 then
						messageBox("Error", addPlaceholder.." cannot be empty.", {"Ok"})
						return
					end
					if table.find(currentVal, objectName) then
						messageBox("Error", "This "..addPlaceholder.." already exists.", {"Ok"})
						return
					end
					if not addCallback(objectName) then
						return
					end
					table.insert(currentVal, objectName)
					local object = elementCreate.listObject()

					object.Name = objectName
					object.Parent = ListContainer
					object.Text = objectName

					object.Button.MouseButton1Click:Connect(function()
						if removeCallback(objectName) then
							table.remove(currentVal, table.find(currentVal, objectName))
							List.Toggle.Value.Text = #currentVal.." "..objectsName
							object:Destroy()
						end
					end)

					updateCallback(currentVal)
					List.Toggle.Value.Text = #currentVal.." "..objectsName
				end)

				for i,v in pairs(currentVal) do
					local object = elementCreate.listObject()

					object.Name = v
					object.Parent = ListContainer
					object.Text = v

					object.Button.MouseButton1Click:Connect(function()
						if removeCallback(v) then
							table.remove(currentVal, table.find(currentVal, v))
							List.Toggle.Value.Text = #currentVal.." "..objectsName
							object:Destroy()
						end
					end)
				end

				updateCallback(currentVal)
				List.Toggle.Value.Text = #currentVal.." "..objectsName

				addList.get = function()
					return currentVal
				end

				addList.set = function(val, prop)
					currentVal = val
					for i,v in pairs(ListContainer:GetChildren()) do
						if v:IsA("TextLabel") then
							v:Destroy()
						end
					end
					for i,v in pairs(currentVal) do
						local object = elementCreate.listObject()
	
						object.Name = v
						object.Parent = ListContainer
						object.Text = v
	
						object.Button.MouseButton1Click:Connect(function()
							if removeCallback(v) then
								table.remove(currentVal, table.find(currentVal, v))
								List.Toggle.Value.Text = #currentVal.." "..objectsName
								object:Destroy()
							end
						end)
					end
					updateCallback(currentVal)
					List.Toggle.Value.Text = #currentVal.." "..objectsName
				end

				return addList
			end
			
			addSection.addColorpicker = function(args)
				local addColorpicker = {}
				
				local Name = args.name
				local Color = args.defaultColor or Color3.fromHSV(1, 0, 1)
				local Callback = args.callback
				
				local Colorpicker = elementCreate.colorpicker()
				
				Colorpicker.Name = Name
				Colorpicker.Parent = sectionContainer
				Colorpicker.Toggle.BackgroundColor3 = Color
				
				if #Name > 20 or string.find(Name, "\n") then
					Colorpicker.Text = Name:sub(1, 26).."..."
				else
					Colorpicker.Text = Name
				end

				local colorpickerTooltip

				if #Name > 26 or string.find(Name, "\n") then
					colorpickerTooltip = addTooltip(Colorpicker, Name)
				end

               --[[ Colorpicker.MouseButton1Down:Connect(function()
                    Palette.lock = true
                end)]]
				
				Colorpicker.Toggle.MouseButton1Click:Connect(function()
					Palette.SetColor(Color)
					Palette.Show(UDim2.new(0, Colorpicker.Toggle.AbsolutePosition.X - paletteObj.AbsoluteSize.X + Colorpicker.Toggle.AbsoluteSize.X, 0, Colorpicker.Toggle.AbsolutePosition.Y + Colorpicker.Toggle.AbsoluteSize.Y + 4), function(color)
						Color = color
						Colorpicker.Toggle.BackgroundColor3 = color
						Callback(color)
					end)
				end)

                addColorpicker.get = function()
                    local h, s, v = Color3.toHSV(Color)
                    return {h, s, v}
                end

                addColorpicker.set = function(color)
                    Color = Color3.fromHSV(color[1], color[2], color[3])
                    Colorpicker.Toggle.BackgroundColor3 = Color
                    Callback(Color)
                end
				
				return addColorpicker
			end

			addSection.addLine = function()
				local line = elementCreate.line()
				line.Parent = sectionContainer
			end

			return addSection
		end

		return addTab
	end

	libNew.messageBox = messageBox

	libNew.pushNotification = function(caption, text, buttons, callback)
		local element = elementCreate.messageBox()

		element.Name = caption.."_notif"
		element.Parent = gui
		element.Top.Title.Text = caption
		element.Label.Text = text

		local a = false

		for i,v in pairs(mainWindow:GetChildren()) do
			if string.find(v.Name, "_notif") and v ~= element and v ~= nil then
				v.Destroying:Wait()
			end
		end

		local function checkmessages()
			local check = false
			for i,v in pairs(mainWindow:GetChildren()) do
				if string.find(v.Name, "_notif") and v ~= element then
					check = true
					break
				end
			end
			return check
		end

		local function tween(obj, props)
			if tt[obj] ~= nil then tt[obj]:Cancel() end
			local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local t = ts:Create(obj, tinfo, props)
			t:Play()
			tt[obj] = t
		end

		local function show()
			tween(element, {Size = UDim2.new(0, 275, 0, 132), BackgroundTransparency = 0})

		end

		local function hide()
			a = true
			tween(element, {Size = UDim2.new(0, 275 * 0.8, 0, 132 * 0.8), BackgroundTransparency = 1})
			if not checkmessages() then tween(mainWindow.BlackSolid, {BackgroundTransparency = 1}) end
			tween(element.Top.Title, {TextTransparency = 1})
			tween(element.Label, {TextTransparency = 1})
			for i,v in pairs(element.ButtonContainer:GetChildren()) do
				if v.ClassName == "TextButton" then
					tween(v, {BackgroundTransparency = 1, TextTransparency = 1})
				end
			end
			repeat wait() until element.BackgroundTransparency == 1
			element:Destroy()
		end

		if buttons then
			for i,title in pairs(buttons) do
				local button = elementCreate.button()

				button.Name = title
				button.ZIndex = 2
				button.Parent = element.ButtonContainer
				button.AnchorPoint = Vector2.new(0.5, 0.5)
				button.Text = title
				button.Size = UDim2.new(math.clamp(button.TextBounds.X + 10, 75, 999) / element.ButtonContainer.AbsoluteSize.X, 0, 1, 0)
				button.BackgroundTransparency = 1
				button.TextTransparency = 1

				button.MouseEnter:Connect(function()
					if a then return end
					if tt[button] ~= nil then tt[button]:Cancel() end
					local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
					local h,s,v = Color3.toHSV(button.BackgroundColor3)
					local finalcolor
					if s > 0.15 then
						finalcolor = Color3.fromHSV(h, s - 0.15, v)
					elseif v < 0.85 then
						finalcolor = Color3.fromHSV(h, s, v + 0.15)
					end
					local t = ts:Create(button, tinfo, {BackgroundColor3 = finalcolor})
					t:Play()
					tt[button] = t
				end)

				button.MouseLeave:Connect(function()
					if a then return end
					if tt[button] ~= nil then tt[button]:Cancel() end
					local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
					local t = ts:Create(button, tinfo, {BackgroundColor3 = lib.settings.uiColor})
					t:Play()
					tt[button] = t
				end)

				button.MouseButton1Down:Connect(function()
					if lib.settings.theme == 0 then
						button.TextColor3 = Color3.fromRGB(225, 225, 225)
					else
						button.TextColor3 = Color3.fromRGB(20, 20, 20)
					end
				end)

				button.MouseButton1Up:Connect(function()
					if lib.settings.theme == 0 then
						button.TextColor3 = Color3.fromRGB(20, 20, 20)
					else
						button.TextColor3 = Color3.fromRGB(225, 225, 225)
					end
				end)

				button.MouseButton1Click:Connect(function()
					if callback then callback(title) end
					hide()
				end)
			end
		end

		--[[for i,v in pairs(element:GetDescendants()) do
			if v.ClassName ~= "UICorner" and v.ClassName ~= "UIListLayout" then
				v.Size = UDim2.new(v.AbsoluteSize.X / v.Parent.AbsoluteSize.X, 0, v.AbsoluteSize.Y / v.Parent.AbsoluteSize.Y, 0)
			end
		end]]

		show()

		return {
			hide = hide,
			editTitle = function(editedTitle)
				element.Top.Title.Text = editedTitle
			end,
			editText = function(editedText)
				element.Label.Text = editedText
			end,
			getObj = function()
				return element
			end,
		}
	end

	libNew.setConfig = function(configTable)
		if configTable.dontEnterTextFields then
			lib.settings.dontEnterTextFields = configTable.dontEnterTextFields
		elseif configTable.uiColor then
			lib.settings.uiColor = configTable.uiColor
			updateColor()
		elseif configTable.theme then
			setTheme(configTable.theme)
		end
	end

	libNew.setTopCenterText = function(text)
		topCenter.Text = text
	end

	libNew.setTopRightText = function(text)
		topRight.Text = text
	end

	libNew.getObject = function()
		return gui
	end

	libNew.destroy = function()
		for i,v in pairs(lib.connections) do
			if typeof(v) == "RBXScriptConnection" then
				v:Disconnect()
			end
		end
		gui:Destroy()
	end

	return libNew
end

return lib