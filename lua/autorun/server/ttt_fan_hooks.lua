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

hook.Add("PlayerDeath", "ttt_fan_check_player_fall_damage", function(victim, inflictor, attacker)
    print("attacker IsPlayer ", attacker:IsPlayer())
    print("victim IsPlayer ", victim:IsPlayer())
    print("attacker IsAlive", attacker:Alive())
    print("attacker Observer ", attacker:GetObserverMode())
    print("attacker AccountID ", attacker:AccountID())
    print("victim AccountID ", victim:AccountID())
    print("inflictor Class ", inflictor:GetClass())
    print("affected ", inflictor.affectedPlayersTable ~= nil)
    print("result ", attacker:IsPlayer() and victim:IsPlayer() and attacker:Alive() and attacker:GetObserverMode() == OBS_MODE_NONE and attacker:AccountID() ~= victim:AccountID() and inflictor:GetClass() == "ent_ttt_fan" and inflictor.affectedPlayersTable ~= nil)
    if (attacker:IsPlayer() and victim:IsPlayer() and attacker:Alive() and attacker:GetObserverMode() == OBS_MODE_NONE and attacker:AccountID() ~= victim:AccountID() and inflictor:GetClass() == "ent_ttt_fan" and inflictor.affectedPlayersTable ~= nil) then
        for _, data in pairs(inflictor.affectedPlayersTable) do
            if (data.player.AccountID == victim.AccountID && data.lastAffectedTime + 5 >= CurTime()) then
                net.Start("TTT2_Fan_OwnerPopup")
                print(victim)
                net.WritePlayer(victim)
                net.Send(attacker)
            end
        end
    end
end)

hook.Add("EntityTakeDamage", "FanDamageCheck", function(target, dmg)
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