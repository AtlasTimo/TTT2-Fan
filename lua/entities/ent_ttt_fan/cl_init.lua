include("shared.lua")

function ENT:Initialize()
    hook.Add("HUDPaint", self, function()
        if (TTT2) then
            if (LocalPlayer():GetTeam() ~= "traitors") then return end
        else
            if (LocalPlayer():GetRole() ~= ROLE_TRAITOR) then return end
        end

        local screenPos = {}
        local textPos = self:GetPos() + Vector(0, 0, 30)

        cam.Start3D()
        screenPos = textPos:ToScreen()
        cam.End3D()

        cam.Start2D()
        draw.DrawText("Fan\n" .. tostring(math.floor((self:GetPos() - LocalPlayer():GetPos()):Length())), "Default", screenPos.x, screenPos.y, Color(206, 0, 0), TEXT_ALIGN_CENTER)
        cam.End2D()
    end)
end

function ENT:Draw()
    self:DrawModel()
end