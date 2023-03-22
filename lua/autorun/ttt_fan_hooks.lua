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