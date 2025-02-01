AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/fan/ent_fan/ent_fan.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetHealth(TTT_FAN.CVARS.fan_health)

	local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

	self:SetTrigger(true)

	if (TTT_FAN.CVARS.fan_use_sound) then
		sound.Add({
			name = "fan_sound",
			channel = CHAN_AUTO,
			volume = TTT_FAN.CVARS.fan_sound_loudness,
			level = 65,
			pitch = 30,
			sound = "fan_sound.wav"
		})
	
		self.sound = CreateSound(self, "fan_sound", nil)
		self.sound:Play()
		self.sound:ChangePitch(30, 2)
		self.sound:ChangePitch(150, 2)
	end
end

function ENT:Think()
	if (not self:Grounded()) then return end

	local velocity = self:GetVelocity()
	if (velocity:Length() > 0.1) then return end

	self.stuetzVektor = self:GetPos()
	self.richtungsVektor = self:GetRight() * TTT_FAN.CVARS.fan_range * -1

	local allEnts = ents.FindInBox(self:GetPos() - self:GetUp() * 10 + self:GetForward() * 3, self:GetPos() + self:GetUp() * 10 - self:GetForward() * 3 + self:GetRight() * TTT_FAN.CVARS.fan_range * -1)

	for i, v in pairs(allEnts) do
		if (v:GetClass() == self:GetClass()) then continue end

		if v:IsPlayer() then
			if (not v:IsLineOfSightClear(self:GetPos())) then continue end
			v:SetVelocity((TTT_FAN.CVARS.fan_strength / 10) * self.richtungsVektor + Vector(0, 0, 100));
		else
			if (not TTT_FAN.CVARS.fan_effect_props) then continue end
			local trace = util.QuickTrace(self:GetPos(), v:GetPos() - self:GetPos(), self)
			if (trace.HitWorld) then continue end

			local physObj = v:GetPhysicsObject()
			if (physObj:IsValid()) then
				physObj:ApplyForceCenter(TTT_FAN.CVARS.fan_prop_strength * self.richtungsVektor + Vector(0, 0, 100))
			end
		end
	end

	self:NextThink(CurTime() + 1 / 30)
	return true
end

function ENT:Grounded()
	local groundCheckTrace = util.QuickTrace(self:GetPos(), self:GetUp() * -25, self)
	if (groundCheckTrace.HitWorld) then
		return true
	end
	return false
end

function ENT:OnTakeDamage(dmginfo)
	print("Fan: Damage")
end