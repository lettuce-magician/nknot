local index:Index = {}

local function addToIndex(s)
    for _, v in s:GetChildren() do
        if not v:IsA("ModuleScript") then continue end
        index[v.Name] = require(v)
    end
end

addToIndex(script.Parent.Packages)
addToIndex(script.Parent.Systems)

export type Index = {
    Node:typeof(require(script.Parent.Systems.Node))
}

return index