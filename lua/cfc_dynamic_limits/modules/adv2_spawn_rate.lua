do
  local threshold = 50
  local thresholdType = "percentage"
  local description = {
    "At 50% server capacity, the following values are changed:",
    "AdvDupe2_SpawnRate: 0.5 -> 0.6"
  }
  local on
  on = function()
    return RunConsoleCommand("AdvDupe2_SpawnRate", 0.6)
  end
  local off
  off = function()
    return RunConsoleCommand("AdvDupe2_SpawnRate", 0.5)
  end
  CFCDynamicLimits.Action("Slower-Adv2-Spawn-Rate", on, off, threshold, description, thresholdType)
end
do
  local threshold = 100
  local thresholdType = "percentage"
  local description = {
    "At 100% server capacity, the following values are changed:",
    "AdvDupe2_SpawnRate: 0.6 -> 0.75"
  }
  local on
  on = function()
    return RunConsoleCommand("AdvDupe2_SpawnRate", 0.75)
  end
  local off
  off = function()
    return RunConsoleCommand("AdvDupe2_SpawnRate", 0.6)
  end
  return CFCDynamicLimits.Action("Slower-Adv2-Spawn-Rate2", on, off, threshold, description, thresholdType)
end
