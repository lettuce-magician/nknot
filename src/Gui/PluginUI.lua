local plugin = script:FindFirstAncestorWhichIsA("Plugin")
local Selection = game:GetService("Selection")

local Packages = script.Parent.Parent.Packages
local Systems = script.Parent.Parent.Systems

local Roact = require(Packages.roact)
local Signal = require(Packages.)
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

local OnRequestDone = 

local function StringProp(Name, Data)
    Data[Name] = ""
    return Roact.createElement("TextLabel", {
        Font = Enum.Font.SourceSans,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1.000, 0, 0.075, 0),
        Text = Name,
        TextScaled = true,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
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
                Data[me.Name] = me.Text
            end
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

local function ColorProp(Name, Data)
    Data[Name] = Color3.new(0,0,0)
    local preview = Roact.createRef()

    return Roact.createElement("TextLabel", {
        Font = Enum.Font.SourceSans,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1.000, 0, 0.075, 0),
        Text = Name,
        TextScaled = true,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
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
            [Roact.Change.Text] = function(me:TextBox)
                me.Text = me.Text:gsub("%D+", "")
                local R,G,B = me.Text:match("(%d%d?%d?),(%d%d?%d?),(%d%d?%d?)")

                if R == nil then
                    R, G, B = 0,0,0
                end

                Data[me.Name] = Color3.fromRGB(R,G,B)
                preview:getValue().BackgroundColor3 = Data[me.Name]
            end
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
            Size = UDim2.new(0.037, 0, 0.709, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            [Roact.Ref] = preview
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

local Checkbox = {
    [true] = "rbxasset://textures//DeveloperFramework/checkbox_checked_dark.png",
    [false] = "rbxasset://textures//DeveloperFramework/checkbox_unchecked_dark.png"
}

local function BoolProp(Name, Default, Data)
    Data[Name] = Default

    return Roact.createElement("TextLabel", {
        Font = Enum.Font.SourceSans,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1.000, 0, 0.075, 0),
        Text = Name,
        TextScaled = true,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    }, {
        Toggle = Roact.createElement("ImageButton", {
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            Image = Checkbox[Data[Name]],
            BackgroundTransparency = 1,
            Position = UDim2.new(0.935, 0, 0.142, 0),
            Size = UDim2.new(0.037, 0, 0.709, 0),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            [Roact.Event.Activated] = function(inst:ImageButton)
                Data[Name] = not Data[Name]
                inst.Image = Checkbox[Data[Name]]
            end
        }),
    })
end

function UI.Component.RequestNodeInfo(InitProps: { Dock: DockWidgetPluginGui })
    local Data = {}

	return Roact.createFragment({
		MainFrame = Roact.createElement("Frame", {
			Color = Color3.fromRGB(255, 255, 255),
			Position = UDim2.new(0.330, 0, 0.301, 0),
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(43, 43, 43),
		}, {
			UIGridLayout = Roact.createElement("UIGridLayout", {
				VerticalAlignment = Enum.VerticalAlignment.Top,
				SortOrder = Enum.SortOrder.LayoutOrder,
				CellPadding = UDim2.new(0.000, 0, 0.000, 0),
				CellSize = UDim2.new(1.000, 0, 0.075, 0),
			}),

			Type = StringProp("Type", Data),
			Space = StringProp("Space",Data),
			Color = ColorProp("Color",Data),

			Inputs = BoolProp("Input", true, Data),
            Outputs = BoolProp("Output", true, Data),
		}),
		Close = Roact.createElement("TextButton", {
			Font = Enum.Font.SourceSans,
			Position = UDim2.new(0.481, 0, 0.654, 0),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.new(0.000, 60, 0.000, 35),
			Text = "Save",
			TextScaled = true,
			BackgroundColor3 = Color3.fromRGB(84, 84, 84),
            [Roact.Event.Activated] = function()
                local Node = NodeUtil.CreateNode(Data.Type, Data.Color, Data.Space)
                Node:SetAttribute("Inputs", Data.Input)
                Node:SetAttribute("Outputs", Data.Outputs)
                Selection:Set({Node})
                InitProps.Dock.Enabled = false
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
