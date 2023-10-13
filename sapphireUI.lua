local lib = {
	settings = {
		dontEnterTextFields = true,
		showAtStart = true,
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
	ctrl_pressed = false
}

--services
local ts = game:GetService('TweenService')
local uis = game:GetService('UserInputService')
local rs = game:GetService('RunService')

uis.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftControl then
		lib.ctrl_pressed = true
	end
end)

uis.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftControl then
		lib.ctrl_pressed = false
	end
end)

-- function for normal dragging, bc roblox dragging is so shitty
local function makeDraggable(ClickObject, Object) -- credits to idk, not mine
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil
	local UserInputService = game:GetService('UserInputService')

	ClickObject.InputBegan:Connect(function(Input)
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
	end)

	ClickObject.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			DragInput = Input
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - DragStart
			Object.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
		end
	end)
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
		ResetOnSpawn = false,
		create("Frame", {
			Name = "MainWindow",
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			Position = UDim2.new(0.5, -283, 0.5, -227),
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
			create("ScrollingFrame", {
				Name = "TContainer",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 166, 0, 30),
				Size = UDim2.new(0, 400, 0, 425),
				CanvasSize = UDim2.new(0, 0, 0, 0),
				ScrollBarThickness = 0,
				ScrollingEnabled = false,
				create("UIListLayout", {
					Name = "ListLayout",
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 0),
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					VerticalAlignment = Enum.VerticalAlignment.Top
				})
			}),
			create("Frame", {
				Name = "BlackSolid",
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0, 0),
				Size = UDim2.fromScale(1, 1)
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
			Position = UDim2.new(0.5, 0, 0, 15),
			Size = UDim2.new(1, 0, 0, 30),
			ZIndex = 2,
			create("TextLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Name = "Title",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 142, 0, 15),
				Size = UDim2.new(0, 265, 0, 30),
				FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
				Text = "caption",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2,
				TextTransparency = 1
			})
		}),
		create("TextLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Name = "Label",
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0, 62),
			Size = UDim2.new(1, 0, 0.492, 0),
			FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			Text = "text",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = 2,
			TextTransparency = 1
		}),
		create("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Name = "ButtonContainer",
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0, 107),
			Size = UDim2.new(0, 275, 0, 25),
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
		Size = UDim2.new(0, 170, 0, 20),
		FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json"),
		Text = "",
		TextColor3 = lib.settings.theme == 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
		TextSize = 12
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
			create("ScrollingFrame", {
				Name = "Container",
				BackgroundTransparency = 1,
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
		if config.settings.showAtStart ~= nil then
			lib.settings.showAtStart = config.settings.showAtStart
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
	if not lib.settings.showAtStart then
		gui.Enabled = false
		libNew.show = function()
			gui.Enabled = true
		end
	end
	gui.Parent = config.parent or game.CoreGui
	topIcon.Image = config.icon or ""
	topIcon.ImageColor3 = lib.settings.uiColor
	topTitle.Text = config.name

	tContainer.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		tContainer.CanvasSize = UDim2.new(0, 0, 0, tContainer.ListLayout.AbsoluteContentSize.Y)
	end)

	local function addTooltip(obj, text)
		local a = obj.MouseEnter:Connect(function()
			tooltip.Text = text
			tooltip.Visible = true
		end)
		local b = obj.MouseLeave:Connect(function()
			tooltip.Visible = false
		end)
		return function()
			a:Disconnect()
			b:Disconnect()
		end
	end

	local mouse = function() return game.Players.LocalPlayer:GetMouse() end
	mouse().Button1Down:Connect(function()
		tooltip.Visible = false
	end)

	rs.RenderStepped:Connect(function()
		if tooltip.Visible then
			tooltip.Position = UDim2.new(0, mouse().X, 0, mouse().Y - tooltip.Size.Y.Offset)
		end
	end)

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
			if tt[obj] ~= nil then tt[obj]:Pause() end
			local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local t = ts:Create(obj, tinfo, props)
			t:Play()
			tt[obj] = t
		end

		local function show()
			element.Size = UDim2.new(0, 290, 0, 139)
			tween(element, {Size = UDim2.new(0, 275, 0, 132), BackgroundTransparency = 0})
			--tween(mainWindow.BlackSolid, {BackgroundTransparency = 0.75})
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
			tween(element, {Size = UDim2.new(0, 290, 0, 139), BackgroundTransparency = 1})
			--if not checkmessages() then tween(mainWindow.BlackSolid, {BackgroundTransparency = 1}) end
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
				button.Size = UDim2.new(0, 75, 0, 25)
				button.BackgroundTransparency = 1
				button.TextTransparency = 1

				button.MouseEnter:Connect(function()
					if a then return end
					if tt[button] ~= nil then tt[button]:Pause() end
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
					if tt[button] ~= nil then tt[button]:Pause() end
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

		function menu(options)
			local menuObj = elementCreate.menu()

			menuObj.Name = randomString(30)
			menuObj.Visible = false
			menuObj.Parent = gui

			local maxSize = 0

			for i,v in pairs(options) do
				local option = elementCreate.menuOption()

				option.Name = i
				option.Parent = menuObj
				option.Text = i

				option.Size = UDim2.fromOffset(option.TextBounds.X + 10, 30)

				if maxSize < option.TextBounds.X then
					maxSize = option.TextBounds.X
				end

				option.MouseButton1Click:Connect(function()
					v()
				end)
			end

			menuObj.Size = UDim2.new(maxSize + 20, menuObj.ListLayout.AbsoluteContentSize.Y)
			menuObj.Position = UDim2.fromOffset(mouse().X, mouse().Y)

			mouse().Button1Up:Once(function()
				menuObj:Destroy()
			end)
		end

		for i,v in pairs(element:GetDescendants()) do
			if v.ClassName ~= "UICorner" and v.ClassName ~= "UIListLayout" then
				v.Size = UDim2.new(v.AbsoluteSize.X / v.Parent.AbsoluteSize.X, 0, v.AbsoluteSize.Y / v.Parent.AbsoluteSize.Y, 0)
			end
		end

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
		if tt[tContainer] ~= nil then tt[tContainer]:Pause() end
		local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local t = ts:Create(tContainer, tinfo, {CanvasPosition = Vector2.new(0, 425 * tContainer[tabName].LayoutOrder)})
		t:Play()
		tt[tContainer] = t
	end

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
				tab.CanvasSize = UDim2.new(0, 0, 0, tab.Left.ListLayout.AbsoluteContentSize.Y)
			else
				tab.CanvasSize = UDim2.new(0, 0, 0, tab.Right.ListLayout.AbsoluteContentSize.Y)
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
				label.Text = #labelText > 26 and labelText:sub(1, 26).."..." or labelText
				label.TextXAlignment = labelAlignment == 0 and Enum.TextXAlignment.Left or labelAlignment == 1 and Enum.TextXAlignment.Center or labelAlignment == 2 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Center

				insert_texts(label)

				local labelTooltip

				if #labelText > 26 then
					labelTooltip = addTooltip(label, labelText)
				end

				addLabel.getObj = function(prop)
					return label
				end

				addLabel.set = function(val, prop)
					if prop == 1 then
						label.TextXAlignment = val == 0 and Enum.TextXAlignment.Left or val == 1 and Enum.TextXAlignment.Center or val == 2 and Enum.TextXAlignment.Right
					else
						label.Text = #val > 26 and val:sub(1, 26).."..." or val
						if #val > 26 then
							if labelTooltip then
								labelTooltip()
							end
							labelTooltip = addTooltip(label, val)
						else
							if labelTooltip then
								labelTooltip()
							end
						end
					end
				end

				return addLabel
			end

			addSection.addButton = function(buttonText, buttonCallback, info, disabled)
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
						if tt[button] ~= nil then tt[button]:Pause() end
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
						if tt[button] ~= nil then tt[button]:Pause() end
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
					local msgbox = messageBox("Keybind ("..button.Text..") ["..keybindtext.."]", "Press key to bind...", {"Cancel"})
					local disconnecting = false
					local inputconnection
					local function disconnect()
						inputconnection:Disconnect()
					end
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
							msgbox.editText("Binded: ["..keybind.Name.."]")
							wait(1)
							msgbox.hide()
							binding = false
							disconnect()
						end
					end)
				end

				button.MouseButton2Click:Connect(function()
					if info ~= nil then
						if keybind ~= nil then
							menu({
								["Info"] = function()
									messageBox(buttonText, info, {"Ok"})
								end,
								["Set Keybind"] = function()
									startBinding()
								end,
								["Remove Keybind"] = function()
									keybind = nil
								end
							})
						else
							menu({
								["Info"] = function()
									messageBox(buttonText, info, {"Ok"})
								end,
								["Set Keybind"] = function()
									startBinding()
								end
							})
						end
					else
						if keybind ~= nil then
							menu({
								["Set Keybind"] = function()
									startBinding()
								end,
								["Remove Keybind"] = function()
									keybind = nil
								end
							})
						else
							menu({
								["Set Keybind"] = function()
									startBinding()
								end
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

				uis.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == keybind and not disabled and not binding and not uis:GetFocusedTextBox() then
							callback()
						end
					end
				end)

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

			addSection.addToggle = function(toggleName, initState, toggleCallback, disabled)
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
					if tt[toggle.Toggle.Circle] ~= nil then tt[toggle.Toggle.Circle]:Pause() end
					if tt[toggle.Toggle] ~= nil then tt[toggle.Toggle]:Pause() end
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
					if not lib.ctrl_pressed and not disabled then
						stateBool = not stateBool
						setState(stateBool)
						toggleCallback(stateBool)
					end
				end)

				local keybind = nil
				local binding = false

				toggle.MouseButton1Click:Connect(function()
					if lib.settings.keybinds and lib.ctrl_pressed then
						binding = true
						local keybindtext
						if keybind == nil then
							keybindtext = "NONE"
						else
							keybindtext = keybind.Name
						end
						local msgbox = messageBox("Keybind ("..toggle.Text..") ["..keybindtext.."]", "Press key to bind...", {"Cancel"})
						local disconnecting = false
						local inputconnection
						local function disconnect()
							inputconnection:Disconnect()
						end
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
					end
				end)

				uis.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == keybind and not disabled and not binding and not uis:GetFocusedTextBox() then
							stateBool = not stateBool
							setState(stateBool)
							toggleCallback(stateBool)
						end
					end
				end)

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

			addSection.addTextField = function(fieldName, fieldPlaceholder, fieldCallback, fieldDisabled)
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
					end
				end

				addTextField.get = function()
					return textField.Field.Text
				end

				return addTextField
			end

			addSection.addSlider = function(sliderName, min, max, initVal, decimals, suffix, sliderCallback)
				local addSlider = {}

				decimals = decimals or 0
				suffix = suffix or ""
				sliderCallback = sliderCallback

				local SliderMain = elementCreate.slider()
				local Slider = SliderMain.SliderBorder.Slider.Slider

				local GlobalSliderValue = initVal and math.clamp(initVal, min, max) or (min + max) / 2

				SliderMain.Name = sliderName
				SliderMain.Parent = sectionContainer

				if #sliderName > 20 or string.find(sliderName, "\n") then
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
					if i.UserInputType == Enum.UserInputType.MouseButton1 then
						Sliding = true
						local Position = UDim2.new(math.clamp((i.Position.X - SliderMain.SliderBorder.AbsolutePosition.X) / SliderMain.SliderBorder.AbsoluteSize.X, 0, 1), 0, 0, 6)
						if tt[Slider] ~= nil then tt[Slider]:Pause() end
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
					if i.UserInputType == Enum.UserInputType.MouseButton1 then
						Sliding = false
						sliderCallback(GlobalSliderValue)
					end
				end)

				uis.InputChanged:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseMovement then
						if Sliding then
							local Position = UDim2.new(math.clamp((i.Position.X - SliderMain.SliderBorder.AbsolutePosition.X) / SliderMain.SliderBorder.AbsoluteSize.X, 0, 1), 0, 0, 6)
							if tt[Slider] ~= nil then tt[Slider]:Pause() end
							local tinfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
							local t = ts:Create(Slider, tinfo, {Size = Position})
							t:Play()
							local Percentage = Position.X.Scale
							local SliderValue = round(Percentage * (max - min) + min, decimals)
							SliderMain.SliderValue.Text = tostring(SliderValue)..suffix
							GlobalSliderValue = SliderValue
						end
					end
				end)

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
			
			addSection.addDropdown = function(dropdownName, options, initVal, multiSelect, dropdownCallback)
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
				
				local opened = false
				local containerSizeY = 90
				
				DropdownContainer.ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					containerSizeY = math.clamp(DropdownContainer.ListLayout.AbsoluteContentSize.Y, 0, 90)
					DropdownContainer.Parent.Size = UDim2.new(0, 170, 0, math.clamp(DropdownContainer.ListLayout.AbsoluteContentSize.Y, 0, 90))
					DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownContainer.ListLayout.AbsoluteContentSize.Y)
					if opened then
						Dropdown.Size = UDim2.new(0, 170, 0, 45 + containerSizeY + 10)
					end
				end)
				
				local function open()
					if tt[Dropdown] ~= nil then tt[Dropdown]:Pause() end
					if tt[Dropdown.Toggle.Arrow] ~= nil then tt[Dropdown.Toggle.Arrow]:Pause() end
					local tinfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
					local t = ts:Create(Dropdown, tinfo, {Size = UDim2.new(0, 170, 0, 45 + containerSizeY + 10)})
					local t2 = ts:Create(Dropdown.Toggle.Arrow, tinfo, {Rotation = 180})
					t:Play()
					t2:Play()
					DropdownContainer._SearchBox:CaptureFocus()
					opened = true
				end
				
				local function close()
					if tt[Dropdown] ~= nil then tt[Dropdown]:Pause() end
					if tt[Dropdown.Toggle.Arrow] ~= nil then tt[Dropdown.Toggle.Arrow]:Pause() end
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
				
				DropdownContainer._SearchBox.Changed:Connect(function(prop)
					if prop == "Text" then
						if #DropdownContainer._SearchBox.Text > 0 then
							for i,v in pairs(DropdownContainer:GetChildren()) do
								if v:IsA("TextButton") and string.find(v.Text:lower(), DropdownContainer._SearchBox.Text:lower()) then
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
					end
				end)
				
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

				addDropdown.set = function(val)
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
				end
				
				return addDropdown
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
		gui:Destroy()
	end

	return libNew
end

return lib