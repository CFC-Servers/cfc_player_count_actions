local lower
lower = string.lower
local pairs
pairs = _G.pairs
local DESCRIBE_ACTIONS_NET = "CFCDynamicLimits_DescribeActions"
util.AddNetworkString(DESCRIBE_ACTIONS_NET)
local CFCDynamicLimitsManager
do
  local _class_0
  local _actionDescriptions
  local _base_0 = {
    cacheActionDescriptions = function()
      for name, action in pairs(CFCDynamicLimits.Actions) do
        _actionDescriptions[lower(name)] = action.description
      end
    end,
    onPlayerJoin = function()
      local newCount = player.GetCount()
      for name, action in pairs(CFCDynamicLimits.Actions) do
        if newCount == action.threshold then
          action:enable()
        end
      end
    end,
    onPlayerLeave = function()
      local newCount = player.GetCount()
      for name, action in pairs(CFCDynamicLimits.Actions) do
        if newCount == action.threshold - 1 then
          action:disable()
        end
      end
    end,
    sendActionDescriptions = function(ply)
      net.Start(DESCRIBE_ACTIONS_NET)
      net.WriteTable(_actionDescriptions)
      return net.Send(ply)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "CFCDynamicLimitsManager"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  _actionDescriptions = { }
  CFCDynamicLimitsManager = _class_0
end
hook.Add("InitPostEntity", "CFCDynamicLimits_CacheActionDescriptions", function()
  CFCDynamicLimits.Manager.cacheActionDescriptions()
  return nil
end)
hook.Add("PlayerAuthed", "CFCDynamicLimits_SendActionDescriptions", function(ply)
  CFCDynamicLimits.Manager.sendActionDescriptions(ply)
  return nil
end)
hook.Add("PlayerInitialSpawn", "CFCDynamicLimits_PlayerJoin", function()
  CFCDynamicLimits.Manager.onPlayerJoin()
  return nil
end)
hook.Add("PlayerDisconnected", "CFCDynamicLimits_PlayerDisconnected", function()
  CFCDynamicLimits.Manager.onPlayerLeave()
  return nil
end)
CFCDynamicLimits.Manager = CFCDynamicLimitsManager()
