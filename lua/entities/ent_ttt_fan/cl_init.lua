include("shared.lua")

local color = Color(206, 0, 0)

function ENT:Initialize()
    net.Receive("TTT2_Fan_OwnerPopup", function()
        local icon = Material("vgui/ttt/weapon_fan_gun.png") -- Lade das Material
        local victim = net.ReadPlayer()
        print(victim)

        MSTACK:AddColoredImagedMessage(
            "You killed " .. victim:GetName(),
            Color(205, 0, 0),
            icon,
            "Fan"
        )
    end)
    
    hook.Add("HUDPaint", self, function()
        if (LocalPlayer():GetTeam() ~= "traitors") then return end

        local screenPos = {}
        local textPos = self:GetPos() + Vector(0, 0, 30)

        cam.Start3D()
        screenPos = textPos:ToScreen()
        cam.End3D()

        local distance = (self:GetPos() - LocalPlayer():GetPos()):Length() * 0.01905
        cam.Start2D()
        draw.DrawText("Fan\n" .. string.format("%.2f m", distance), "Default", screenPos.x, screenPos.y, color, TEXT_ALIGN_CENTER)
        cam.End2D()

        if (not LocalPlayer():IsLineOfSightClear(self:GetPos()) || not TTT_FAN.CVARS.fan_show_range) then return end

        cam.Start3D()
        render.DrawLine(self:GetPos(), self:GetPos() + self:GetRight() * TTT_FAN.CVARS.fan_range * -1, color, true)
        cam.End3D()
    end)
end

function ENT:Draw()
    self:DrawModel()
end