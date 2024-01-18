local Packages = script.Parent.Packages
local Gui = script.Parent.Gui
local Roact = require(Packages.roact)

local Editor = require(Gui.EditorWindow)
local TextEditor = require(Gui.TextEditor)
local PluginUI = require(Gui.PluginUI)

local Handles = {
    Roact.mount(Roact.createElement(Editor), game:GetService("CoreGui"), "NKnotMain"),
    Roact.mount(Roact.createElement(TextEditor), PluginUI.Dockets.TextEditor, "NKnotEdit")
}

for Name, Component in PluginUI.Component do
    local Dock = PluginUI.Dockets[Name]
    table.insert(Handles, Roact.mount(Roact.createElement(Component, {Dock = Dock}), Dock))
end

plugin.Unloading:Connect(function()
    for _, H in Handles do
        Roact.unmount(H)
    end
end)