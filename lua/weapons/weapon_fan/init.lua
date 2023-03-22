AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 1.0)

    local ow = self:GetOwner()
    local trace = util.QuickTrace(ow:EyePos(), ow:GetAimVector() * TTT_FAN.CVARS.fan_place_range, player:GetAll())

    local traceNormal = trace.HitNormal
    local upVec = Vector(0, 0, 1)

    local angle = math.acos(upVec:GetNormalized():Dot(traceNormal:GetNormalized()))
    angle = math.deg(angle)

    if (angle >= 5 or angle <= -5) then return end

    local fanEnt = ents.Create("ent_ttt_fan")

    fanEnt:Spawn()
    fanEnt:SetOwner(ow)

    local spawnPos = trace.HitPos + Vector(0, 0, 30)

    fanEnt:SetPos(spawnPos)
    local modelAngle = Angle(0, ow:EyeAngles()[2] - 90, 0)
    fanEnt:SetAngles(modelAngle)

    ow:StripWeapon("weapon_fan")
end