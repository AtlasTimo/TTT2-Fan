TTT_FAN = TTT_FAN or {}
TTT_FAN.CVARS = TTT_FAN.CVARS or {}

local fan_effect_props = CreateConVar("ttt_fan_effect_props", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local fan_use_sound = CreateConVar("ttt_fan_use_sound", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local fan_sound_loudness = CreateConVar("ttt_fan_sound_loudness", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local fan_prop_strength = CreateConVar("ttt_fan_prop_strength", "2", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local fan_place_range = CreateConVar("ttt_fan_place_range", "300", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local fan_range = CreateConVar("ttt_fan_range", "800", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local fan_show_range = CreateConVar("ttt_fan_show_range", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local fan_strength = CreateConVar("ttt_fan_strength", "3", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local fan_health = CreateConVar("ttt_fan_health", "300", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local fan_invincible = CreateConVar("ttt_fan_invincible", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})

TTT_FAN.CVARS.fan_use_sound = fan_use_sound:GetBool()
TTT_FAN.CVARS.fan_effect_props = fan_effect_props:GetBool()
TTT_FAN.CVARS.fan_sound_loudness = fan_sound_loudness:GetFloat()
TTT_FAN.CVARS.fan_prop_strength = fan_prop_strength:GetFloat()
TTT_FAN.CVARS.fan_place_range = fan_place_range:GetInt()
TTT_FAN.CVARS.fan_range = fan_range:GetInt()
TTT_FAN.CVARS.fan_show_range = fan_show_range:GetBool()
TTT_FAN.CVARS.fan_strength = fan_strength:GetInt()
TTT_FAN.CVARS.fan_health = fan_health:GetInt()
TTT_FAN.CVARS.fan_invincible = fan_invincible:GetBool()

if SERVER then

  cvars.AddChangeCallback("ttt_fan_use_sound", function(name, old, new)
    TTT_FAN.CVARS.fan_use_sound = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_fan_effect_props", function(name, old, new)
    TTT_FAN.CVARS.fan_effect_props = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_fan_sound_loudness", function(name, old, new)
    TTT_FAN.CVARS.fan_sound_loudness = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_fan_prop_strength", function(name, old, new)
    TTT_FAN.CVARS.fan_prop_strength = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_fan_place_range", function(name, old, new)
    TTT_FAN.CVARS.fan_place_range = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_fan_range", function(name, old, new)
    TTT_FAN.CVARS.fan_range = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_fan_show_range", function(name, old, new)
    TTT_FAN.CVARS.ttt_fan_show_range = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_fan_strength", function(name, old, new)
    TTT_FAN.CVARS.fan_strength = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_fan_health", function(name, old, new)
    TTT_FAN.CVARS.fan_health = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_fan_invincible", function(name, old, new)
    TTT_FAN.CVARS.fan_invincible = util.StringToType(new, "bool")
  end, nil)
end

if CLIENT then
  cvars.AddChangeCallback("ttt_fan_use_sound", function(name, old, new)
    TTT_FAN.CVARS.fan_use_sound = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_fan_place_range", function(name, old, new)
    TTT_FAN.CVARS.fan_place_range = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_fan_sound_loudness", function(name, old, new)
    TTT_FAN.CVARS.fan_sound_loudness = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_fan_range", function(name, old, new)
    TTT_FAN.CVARS.fan_range = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_fan_show_range", function(name, old, new)
    TTT_FAN.CVARS.fan_show_range = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_fan_invincible", function(name, old, new)
    TTT_FAN.CVARS.fan_invincible = util.StringToType(new, "bool")
  end, nil)
end
