AddCSLuaFile()
if not (CLIENT) then
  return 
end
local Split, StartWith, lower
do
  local _obj_0 = string
  Split, StartWith, lower = _obj_0.Split, _obj_0.StartWith, _obj_0.lower
end
local actionDescriptions
net.Receive("CFCDynamicLimits_DescribeAction", function()
  if actionDescriptions then
    return 
  end
  print("[CFC_Dynamic_Limits] Received action descriptions")
  actionDescriptions = net.ReadTable()
end)
local COLORS = {
  RED = Color(255, 0, 0),
  YELLOW = Color(255, 255, 0),
  GREEN = Color(0, 255, 0)
}
local describeAction
describeAction = function(name)
  chat.AddText(COLORS.GREEN, "Rule definition (" .. tostring(name) .. "):\n")
  local description = actionDescriptions[name]
  if not description then
    chat.AddText(COLORS.RED, "No Action found with that name\n")
    return 
  end
  for _index_0 = 1, #description do
    local line = description[_index_0]
    chat.AddText(COLORS.YELLOW, line, "\n\n")
  end
end
return hook.Add("OnPlayerChat", "CFCDynamicLimits_DescribeAction", function(ply, text)
  if not (StartWith(text, "!describe")) then
    return 
  end
  local actionName = Split(text, " ")[2]
  actionName = lower(actionName)
  if actionName == "*" then
    for name, description in pairs(actionDescriptions) do
      describeAction(name)
    end
  else
    describeAction(actionName)
  end
  return true
end)
