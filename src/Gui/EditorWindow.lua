local Selection = game:GetService("Selection")
local Packages = script.Parent.Parent.Packages
local Roact = require(Packages.roact)

local Index = require(script.Parent.Parent.Indexer)
local UI = require(script.Parent.PluginUI)

local EditorWindow = Roact.Component:extend("EditorWindow")

function EditorWindow:init()
	self:setState({
		Enabled = false
	})

	UI.Buttons.NewTree.Click:Connect(function()
		Selection:Set({Index.Node.CreateTree()})
	end)

	Selection.SelectionChanged:Connect(function()
		local Selected = Selection:Get()
		local This
		for _, Child in ipairs(Selected) do
			if not Child:HasTag("NKnotTree") then continue end
			This = Child
			break
		end

		if not This then
			return
		end

		self:setState({
			Enabled = true
		})
	end)
end

function EditorWindow:render()
	return Roact.createElement("ScreenGui", { Name = "EditorWindow", Enabled = self.state.Enabled }, {
		Roact.createElement("Frame", {
			BorderColor3 = Color3.fromRGB(27, 42, 53),
			Size = UDim2.new(0.000, 10000, 0.000, 10000),
			BorderSizePixel = 1,
			BackgroundColor3 = Color3.fromRGB(22, 22, 22),
			Name = "Viewport",
		}, {
			Close = Roact.createElement("TextButton", {
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextTransparency = 0.1,
				Text = "Close",
				TextScaled = true,
				Font = Enum.Font.SourceSans,
				BorderColor3 = Color3.fromRGB(27, 42, 53),
				Position = UDim2.new(0.073, 0, 0.090, 0),
				Size = UDim2.new(0.010, 0, 0.003, 0),
				ZIndex = 2,
				BorderSizePixel = 1,
				BackgroundColor3 = Color3.fromRGB(61, 61, 61),
				[Roact.Event.Activated] = function()
					self:setState({
						Enabled = false
					})
				end
			}, {
				UICorner = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0.000, 8),
				}),

				UIStroke = Roact.createElement("UIStroke", {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					LineJoinMode = Enum.LineJoinMode.Round,
					Color = Color3.fromRGB(42,42,42),
					Thickness = 2,
					Transparency = 0,
				}),
			}),
		}),
	})
end

return EditorWindow
