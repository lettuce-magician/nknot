local Packages = script.Parent.Parent.Packages
local Roact = require(Packages.roact)

local NodeFrame = Roact.Component:extend("NodeFrame")

local PropertyTypes = {
    String = Roact.createElement("TextButton", {
        Font = Enum.Font.SourceSans,
        Position = UDim2.new(0.817, 0, 0.000, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0.000, 39, 0.000, 23),
        Text = "Edit",
        TextSize = 24,
        BackgroundColor3 = Color3.fromRGB(56, 56, 56),
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

    Vector3 = Roact.createElement("TextBox", {
        Position = UDim2.new(0.730, 0, 0.056, 0),
        Transparency = 0,
        Font = Enum.Font.SourceSans,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0.000, 52, 0.000, 22),
        Text = "0,0,0",
        TextScaled = true,
        BackgroundColor3 = Color3.fromRGB(26, 26, 26),
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
}

local PropTypes = {}

function PropTypes.Bool(Child)
    return Roact.createElement("ImageButton", {
        ImageColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        AnchorPoint = Vector2.new(1.000, 0.500),
        Image = "rbxasset://textures/DeveloperFramework/checkbox_unchecked_dark.png",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.959, 0, 0.467, 0),
        ZIndex = 2,
        Size = UDim2.new(0.000, 16, 0.000, 16),
        BackgroundColor3 = Color3.fromRGB(117, 166, 245),
        [Roact.Event.Activated] = function()
            Child.Value = not Child.Value
        end
    }, {
        Toggle = Roact.createElement("ImageLabel", {
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            BorderColor3 = Color3.fromRGB(27, 42, 53),
            AnchorPoint = Vector2.new(1.000, 0.500),
            Image = "rbxasset://textures//DeveloperFramework/checkbox_checked_dark.png",
            BackgroundTransparency = 1,
            Position = UDim2.new(1.000, 0, 0.500, 0),
            Transparency = 1,
            ZIndex = 12,
            Size = UDim2.new(1.000, 0, 1.000, 0),
            BackgroundColor3 = Color3.fromRGB(117, 166, 245),
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

function PropTypes.Number(Child)
    local ref = Roact.createRef()
    return Roact.createElement("TextBox", {
        Position = UDim2.new(0.775, 0, 0.056, 0),
        Transparency = 0,
        Font = Enum.Font.SourceSans,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0.000, 42, 0.000, 22),
        Text = "100000",
        TextScaled = true,
        BackgroundColor3 = Color3.fromRGB(26, 26, 26),
        [Roact.Ref] = ref,
        [Roact.Change.Text] = function()
            local TextBox = ref:getValue()
            TextBox.Text = TextBox.Text:gsub('%D+', '');
        end
    }, {
        UIStroke = Roact.createElement("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            LineJoinMode = Enum.LineJoinMode.Round,
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Transparency = 0,
        }),

        UICorner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0.000, 8),
        }),
    })
end

local function Property(Name, PropList)
    local Elements = {}

    for _, Child:Instance in PropList do
        if Child:IsA("BoolValue") then
            table.insert(Elements, PropTypes.Bool(Child))
        elseif Child:IsA("NumberValue") or Child:IsA("IntValue") then

        end
    end

    local FinishedProduct = Roact.createElement("TextLabel", {
        Position = UDim2.new(0.000, 0, 0.000, 0),
        Font = Enum.Font.SourceSansBold,
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1.005, 0, 0.257, 0),
        Text = "Hello",
        TextSize = 25,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    }, Elements)
end

function NodeFrame:init(initProps:{node:Configuration})
	self.props.node = initProps.node
end

function NodeFrame:render()
	return Roact.createElement("Frame", {
		Position = UDim2.new(0.071, 0, 0.040, 0),
		Size = UDim2.new(0.000, 221, 0.000, 100),
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
	}, {
		UICorner = Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0.000, 8),
		}),

		Props = Roact.createElement("Frame", {
			Position = UDim2.new(0.000, 0, 0.410, 0),
			Size = UDim2.new(0.000, 221, 0.000, 58),
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		}, {
			UIListLayout = Roact.createElement("UIListLayout", {
				VerticalAlignment = Enum.VerticalAlignment.Top,
				FillDirection = Enum.FillDirection.Vertical,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0.000, 5),
			}),

			UICorner = Roact.createElement("UICorner", {
				CornerRadius = UDim.new(0.000, 8),
			}),
		}),

		NameEdit = Roact.createElement("TextBox", {
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Text = "Basic node",
			Transparency = 1,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.000, 0, 0.100, 0),
			Font = Enum.Font.SourceSans,
			Size = UDim2.new(0.000, 221, 0.000, 23),
			TextScaled = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		}),

		Out = Roact.createElement("ImageButton", {
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			Image = "http://www.roblox.com/asset/?id=6988018907",
			BackgroundTransparency = 1,
			Position = UDim2.new(1.045, 0, 0.380, 0),
			Size = UDim2.new(0.000, 23, 0.000, 23),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		}),

		In = Roact.createElement("ImageButton", {
			ImageColor3 = Color3.fromRGB(255, 255, 255),
			Image = "http://www.roblox.com/asset/?id=6988018907",
			BackgroundTransparency = 1,
			Position = UDim2.new(-0.186, 0, 0.360, 0),
			Size = UDim2.new(0.000, 23, 0.000, 23),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		}),

		TypeName = Roact.createElement("TextLabel", {
			LayoutOrder = 100000000,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0.5,
			Text = "Root",
			Font = Enum.Font.SourceSansBold,
			BackgroundTransparency = 1,
			Position = UDim2.new(-0.009, 0, -0.010, 0),
			Size = UDim2.new(1.005, 0, 0.146, 0),
			TextScaled = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		}),

		NodeColor = Roact.createElement("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			LineJoinMode = Enum.LineJoinMode.Round,
			Color = Color3.fromRGB(255, 255, 255),
			Thickness = 2,
			Transparency = 0.10000000149011612,
		}),
	})
end

return NodeFrame
