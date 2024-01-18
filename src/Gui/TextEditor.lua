local Selection = game:GetService("Selection")
local Packages = script.Parent.Parent.Packages
local Roact = require(Packages.roact)

local UI = require(script.Parent.PluginUI)
local Dock = UI.Dockets.TextEditor

local TextEditor = Roact.Component:extend("TextEditor")

function TextEditor:init()
	self:setState({
		text = Instance.new("StringValue"),
	})

	Dock.Title = "Text Editor"

	UI.Buttons.OpenEditor.Click:Connect(function()
		UI.Dockets.TextEditor.Enabled = true
	end)

	self.textBox = Roact.createRef()

	local Evs = {}
	Selection.SelectionChanged:Connect(function()
		local Value:StringValue = Selection:Get()[1]

		if Value and Value:IsA("StringValue") then
			self:setState({
				text = Value
			})

			for _, Ev in Evs do
				Ev:Disconnect()
			end

			Evs = {
				Value:GetPropertyChangedSignal("Name"):Connect(function()
					Dock.Title = "Text Editor: "..Value:GetFullName()
				end),
				Value:GetPropertyChangedSignal("Value"):Connect(function()
					Value.Value = self.textBox:getValue().Text
				end)
			}

			self.textBox:getValue().Text = Value.Value

			Dock.Title = "Text Editor: "..Value:GetFullName()
		end
	end)
end

function TextEditor:render()
	return Roact.createElement("TextBox", {
		LayoutOrder = 1,
		TextColor3 = Color3.fromRGB(204, 204, 204),
		BorderColor3 = Color3.fromRGB(27, 42, 53),
		Text = "",
		Transparency = 0,
		Font = Enum.Font.SourceSans,
		Size = UDim2.new(1.000, 0, 1.000, 0),
		TextSize = 20,
		BorderSizePixel = 1,
		BackgroundColor3 = Color3.fromRGB(18, 18, 18),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		MultiLine = true,
		ClearTextOnFocus = false,

		[Roact.Ref] = self.textBox,
		[Roact.Change.Text] = function(box)
			self.state.text.Value = box.Text
		end
	}, {
		UIPadding = Roact.createElement("UIPadding", {
			PaddingBottom = UDim.new(0.000, 5),
			PaddingRight = UDim.new(0.000, 5),
			PaddingLeft = UDim.new(0.000, 5),
		}),
	})
end

return TextEditor
