util.AddNetworkString("TTT2_Fan_OwnerPopup")

hook.Add("KeyPress", "AlignFanOnMagnetoStickRelease", function(ply, key)
    if (key ~= IN_ATTACK2) then return end
    if (IsValid(ply) and ply:Alive() and ply:GetObserverMode() == OBS_MODE_NONE and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "weapon_zm_carry") then
        local targetEnt = ply:GetEyeTrace().Entity

        if (targetEnt:GetClass() ~= "ent_ttt_fan") then return end
        local groundCheckTrace = util.QuickTrace(targetEnt:GetPos(), targetEnt:GetUp() * -25, targetEnt)

        if (groundCheckTrace.HitWorld) then return end
        timer.Simple(0.05, function()
            targetEnt:SetAngles(Angle(0, ply:EyeAngles()[2] - 90, 0))
        end)

    end
end)

hook.Add("EntityTakeDamage", "FanDamageCheck", function(target, dmg)
    if (TTT_FAN.CVARS.fan_invincible) then return end
    local attacker = dmg:GetAttacker()
    if ((dmg:IsBulletDamage() or dmg:IsExplosionDamage()) and target:GetName() == "ttt_fan") then
        local fanHealth = target:GetNWInt("health", TTT_FAN.CVARS.fan_health)
        fanHealth = fanHealth - dmg:GetDamage()
        if (fanHealth <= 0) then
            target:RemoveFan()
        else
            target:SetNWInt("health", fanHealth)
        end
    end
end)

hook.Add("PlayerDeath", "ttt_fan_check_player_fall_damage", function(victim, inflictor, attacker)
    local push = victim.was_pushed
    if push and math.max(push.t or 0) >= CurTime() - 5 and push.wep == "ent_ttt_fan" then
        local fanowner = push.att
        if fanowner:IsValid() and fanowner:IsActive() and fanowner:Alive() then
            net.Start("TTT2_Fan_OwnerPopup")
            net.WritePlayer(victim)
            net.Send(fanowner)
        end
    end
end)

