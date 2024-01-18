local CollectionService = game:GetService("CollectionService")
local Selection = game:GetService("Selection")

local NodeSystem = {}

local NodeSpaces = game.ServerStorage:FindFirstChild("Nodespaces") or Instance.new("Folder")
NodeSpaces.Name = "Nodespaces"
NodeSpaces.Parent =  game.ServerStorage

NodeSystem.Spaces = NodeSpaces

function NodeSystem.CreateTree()
    local Selected = Selection:Get()[1] or workspace

    local Config = Instance.new("Configuration")
    Config.Name = "NodeTree"
    Config:AddTag("NKnotTree")
    Config:SetAttribute("Nodespace", "Default")
    Config.Parent = Selected

    return Config
end

function NodeSystem.GetAllTrees(...)
    local Select = {...}
    local Tag = CollectionService:GetTagged("NKnotTree")

    if #Select > 0 then
        for i, Inst in Tag do
            if table.find(Select, Inst:GetAttribute("Nodespace") or "Default") then continue end
            Tag[i] = nil
        end
    end

    return Tag
end

function NodeSystem.CreateNode(Type:string, Color:BrickColor, Space:string|"Default")

    local SpaceInst = NodeSpaces:FindFirstChild(Space)
    if not SpaceInst then
        SpaceInst = Instance.new("Folder")
        SpaceInst.Name = Space
        SpaceInst.Parent = NodeSpaces
    end

    local Node = Instance.new("Configuration")
    Node.Name = Type
    Node:SetAttribute("Color", Color)
    Node:SetAttribute("Inputs", true)
    Node:SetAttribute("Outputs", true)
    Node.Parent = SpaceInst

    return Node
end

function NodeSystem.NewNode(Tree:Configuration, Name:string)
    local Space = NodeSpaces:FindFirstChild(Tree:GetAttribute("Nodespace"))
    if not Space then return end
    local Node = Space:FindFirstChild(Name)
    if not Node then return end

    local New = Instance.new("ObjectValue")
    New.Name = Name
    New:SetAttribute("Type",Name)
    New:SetAttribute("Priority", 1)
    New:SetAttribute("Position", UDim2.fromScale(0,0))
    New.Parent = Tree

    return New
end

return NodeSystem