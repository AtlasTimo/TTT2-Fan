AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("TTT2_Fan_OwnerPopup")

function ENT:Initialize()
    self:SetModel("models/fan/ent_fan/ent_fan.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.affectedPlayersTable = {}

	local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

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

			v.was_pushed = { att = self.Owner, t = CurTime(), wep = self:GetClass() }
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

function ENT:OnTakeDamage() 
	local fanHealth = self:GetNWInt("health")
	local percentHealth = fanHealth / TTT_FAN.CVARS.fan_health * 100
	if (percentHealth <= 20) then
		self:CreateFanFire()
	end
end

function ENT:RemoveFan()
	if not IsValid(self) then return end

    local explosionPos = self:GetPos()

    -- Erzeuge den Explosionseffekt
    local effectData = EffectData()
    effectData:SetOrigin(explosionPos)
    effectData:SetMagnitude(5) -- Stärke des Effekts
    effectData:SetScale(1) -- Skalierung des Effekts
    effectData:SetRadius(256) -- Radius der Explosion

    util.Effect("Explosion", effectData, true, true) -- Standard-Explosionseffekt

    -- Explosion Sound abspielen
    sound.Play("ambient/explosions/explode_4.wav", explosionPos, 100, 100) -- Explosion Sound

	self.FireEffect:Remove()
	self.sound:Stop()
	self:Remove()
end

function ENT:CreateFanFire()
    if not IsValid(self) or self.FireEffect then return end

    local fire = ents.Create("env_fire")
    fire:SetPos(self:GetPos()) -- Setze Position auf den Fan
    fire:SetKeyValue("health", "30") -- Lebensdauer des Feuers
    fire:SetKeyValue("firesize", "64") -- Größe des Feuers
    fire:SetKeyValue("fireattack", "4") -- Schaden pro Sekunde (falls gewünscht)
    fire:SetKeyValue("spawnflags", "128") -- 128 = Unendlich lange brennen
    fire:SetKeyValue("StartDisabled", "0")
    fire:SetKeyValue("ignitionpoint", "0")
    fire:SetKeyValue("damagescale", "1") -- Standard-Schaden
    fire:Spawn()
    fire:Activate()
    fire:Fire("StartFire", "", 0)

    self.FireEffect = fire -- Speichere das Feuer-Entity im Fan
end
