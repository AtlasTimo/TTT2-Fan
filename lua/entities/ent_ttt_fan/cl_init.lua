include("shared.lua")

local color = Color(206, 0, 0)

function ENT:Initialize()
    hook.Add("HUDPaint", self, function()
        if (LocalPlayer():GetTeam() ~= "traitors") then return end

        local screenPos = {}
        local textPos = self:GetPos() + Vector(0, 0, 30)

        cam.Start3D()
        screenPos = textPos:ToScreen()
        cam.End3D()

        cam.Start2D()
        draw.DrawText("Fan\n" .. tostring(math.floor((self:GetPos() - LocalPlayer():GetPos()):Length())), "Default", screenPos.x, screenPos.y, color, TEXT_ALIGN_CENTER)
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