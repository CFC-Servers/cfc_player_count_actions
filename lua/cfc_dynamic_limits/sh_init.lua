AddCSLuaFile()
require("logger")
CFCDynamicLimits = { }
CFCDynamicLimits.Logger = Logger("CFC DynamicLimits")
include("cl_describer.lua")
if not (SERVER) then
  return 
end
include("sv_manager.lua")
include("sv_action.lua")
local MODULES_PATH = "cfc_dynamic_limits/modules"
local modules = file.Find(tostring(MODULES_PATH) .. "/*.lua", "LUA")
for _index_0 = 1, #modules do
  local limitModule = modules[_index_0]
  include(tostring(MODULES_PATH) .. "/" .. tostring(limitModule))
end
