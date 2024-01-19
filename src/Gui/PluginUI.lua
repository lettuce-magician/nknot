local plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Selection = game:GetService("Selection")

local Packages = script.Parent.Parent.Packages
local Systems = script.Parent.Parent.Systems

local Roact = require(Packages.roact)
local Signal = require(Packages.fastsignal)
local NodeUtil = require(Systems.Node)
local Toolbar = plugin:CreateToolbar("NKnot")

local UI = {
	Dockets = {
		TextEditor = plugin:CreateDockWidgetPluginGui(
			"NKnot Text Editor",
			DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, true, false, 250, 350, 150, 150)
		),
		RequestNodeInfo = plugin:CreateDockWidgetPluginGui(
			"NodeInfo",
			DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 325, 500, 450, 200)
		),
	},
	Component = {},
	Buttons = {
		NewTree = Toolbar:CreateButton(
			"New Tree",
			"Creates a new tree into the selected instance.",
			"rbxassetid://3964460467"
		),
		CreateNode = Toolbar:CreateButton(
			"Create Node",
			"Creates a new node and inserts it into the respective space.",
			"rbxassetid://12988752403"
		),
		OpenEditor = Toolbar:CreateButton(
			"Open Text Editor",
			"Opens the text editor, used for editing StringValues.",
			"rbxassetid://9086085345"
		),
	},
	Toolbar = Toolbar,
}

function UI.Component.RequestNodeInfo(InitProps: { Dock: DockWidgetPluginGui })
	local OnRequestDone = Signal.new()

	local Checkbox = {
		[true] = "rbxasset://textures//DeveloperFramework/checkbox_checked_dark.png",
		[false] = "rbxasset://textures//DeveloperFramework/checkbox_unchecked_dark.png",
	}

	local Data = {}
	OnRequestDone:Connect(function()
		table.clear(Data)
	end)

	UI.Buttons.CreateNode.Click:Connect(function()
		InitProps.Dock.Enabled = true
	end)

	InitProps.Dock:BindToClose(function()
		OnRequestDone:Fire()
	end)

	local function StringProp(Name)
		Data[Name] = ""

		local self = Roact.createRef()
		OnRequestDone:Connect(function()
			self:getValue().Value.Text = ""
		end)

		return Roact.createElement("TextLabel", {
			Font = Enum.Font.SourceSans,
			BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.new(1.000, 0, 0.075, 0),
			Text = Name,
			TextScaled = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			TextXAlignment = Enum.TextXAlignment.Left,
			[Roact.Ref] = self,
		}, {
			Value = Roact.createElement("TextBox", {
				Position = UDim2.new(0.813, 0, 0.106, 0),
				Transparency = 0,
				Font = Enum.Font.SourceSans,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(0.174, 0, 0.780, 0),
				Text = "",
				TextScaled = true,
				BackgroundColor3 = Color3.fromRGB(16, 16, 16),
				[Roact.Change.Text] = function(me)
					Data[Name] = me.Text
                    print(Name, Data[Name])
				end,
			}, {
				UICorner = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.400, 0),
				}),

				UIStroke = Roact.createElement("UIStroke", {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Round,
					Color = Color3.fromRGB(255, 255, 255),
					Thickness = 1,
					Transparency = 0,
				}),
			}),
		})
	end

	local function ColorProp(Name)
		Data[Name] = Color3.new(0, 0, 0)
		local preview = Roact.createRef()

		local self = Roact.createRef()
		OnRequestDone:Connect(function()
			self:getValue().Value.Text = "0,0,0"
			preview:getValue().BackgroundColor3 = Color3.new(0, 0, 0)
		end)

		return Roact.createElement("TextLabel", {
			Font = Enum.Font.SourceSans,
			BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.new(1.000, 0, 0.075, 0),
			Text = Name,
			TextScaled = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			TextXAlignment = Enum.TextXAlignment.Left,
			[Roact.Ref] = self,
		}, {
			Value = Roact.createElement("TextBox", {
				Position = UDim2.new(0.813, 0, 0.106, 0),
				Transparency = 0,
				Font = Enum.Font.SourceSans,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Size = UDim2.new(0.174, 0, 0.780, 0),
				Text = "0,0,0",
				TextScaled = true,
				BackgroundColor3 = Color3.fromRGB(16, 16, 16),
				[Roact.Change.Text] = function(me: TextBox)
					local R, G, B = me.Text:match("(%d%d?%d?),(%d%d?%d?),(%d%d?%d?)")

					if R == nil then
						R, G, B = 0, 0, 0
					end

					Data[self:getValue().Name] = Color3.fromRGB(R, G, B)
					preview:getValue().BackgroundColor3 = Data[Name]

                    print(Name, Data[Name])
				end,
			}, {
				UICorner = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.400, 0),
				}),

				UIStroke = Roact.createElement("UIStroke", {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Round,
					Color = Color3.fromRGB(255, 255, 255),
					Thickness = 1,
					Transparency = 0,
				}),
			}),

			Preview = Roact.createElement("Frame", {
				Position = UDim2.new(0.756, 0, 0.142, 0),
				Size = UDim2.new(0, 20, 0, 20),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				[Roact.Ref] = preview,
			}, {
				UICorner = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.200, 0),
				}),

				UIStroke = Roact.createElement("UIStroke", {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Round,
					Color = Color3.fromRGB(255, 255, 255),
					Thickness = 1,
					Transparency = 0,
				}),
			}),
		})
	end

	local function BoolProp(Name, Default)
		local self = Roact.createRef()
		OnRequestDone:Connect(function()
            Data[Name] = Default
			self:getValue().Toggle.Image = Checkbox[Default]
		end)

		return Roact.createElement("TextLabel", {
			Font = Enum.Font.SourceSans,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.new(1.000, 0, 0.075, 0),
			Text = Name,
			TextScaled = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			[Roact.Ref] = self,
		}, {
			Toggle = Roact.createElement("ImageButton", {
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Image = Checkbox[Data[Name]],
				BackgroundTransparency = 1,
				Position = UDim2.new(0.935, 0, 0.142, 0),
				Size = UDim2.new(0, 20, 0, 20),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				[Roact.Event.Activated] = function(me)
					Data[Name] = not Data[Name]
					me.Image = Checkbox[Data[Name]]
                    print(Name, Data[Name])
				end,
			}),
		})
	end

	return Roact.createElement("Frame", {
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(43, 43, 43),
	}, {
		Items = Roact.createElement("Folder", {}, {
			UIGridLayout = Roact.createElement("UIGridLayout", {
				VerticalAlignment = Enum.VerticalAlignment.Top,
				SortOrder = Enum.SortOrder.LayoutOrder,
				CellPadding = UDim2.new(0.000, 0, 0.000, 0),
				CellSize = UDim2.new(1.000, 0, 0.075, 0),
			}),

			Type = StringProp("Type"),
			Space = StringProp("Space"),
			Color = ColorProp("Color"),

			Input = BoolProp("Input", true),
			Output = BoolProp("Output", true),
		}),
        Save = Roact.createElement("TextButton", {
            AnchorPoint = Vector2.new(0.5,0.5),
			Font = Enum.Font.SourceSans,
			Position = UDim2.new(0.5, 0, 0.8, 00),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.new(0.000, 60, 0.000, 35),
			Text = "Save",
			TextScaled = true,
			BackgroundColor3 = Color3.fromRGB(84, 84, 84),
            [Roact.Event.Activated] = function()
                print(Data)
                local Node = NodeUtil.CreateNode(Data.Type, Data.Color, Data.Space)
                Node:SetAttribute("Inputs", Data.Input)
                Node:SetAttribute("Outputs", Data.Output)
                Selection:Set({Node})
                InitProps.Dock.Enabled = false
                OnRequestDone:Fire()
            end
		}, {
			UICorner = Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0.000, 8),
			}),

			UIStroke = Roact.createElement("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				LineJoinMode = Enum.LineJoinMode.Round,
				Color = Color3.fromRGB(255, 255, 255),
				Thickness = 1,
				Transparency = 0,
			}),
		}),
	})
end

return UI
