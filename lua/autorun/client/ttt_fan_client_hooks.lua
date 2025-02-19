hook.Add("TTTRenderEntityInfo", "TTT2FanRenderHealthState", function(tData)
	local ent = tData:GetEntity()
	if not IsValid(ent) then return end

    if (ent:GetNWString("fanName") ~= "ttt_fan") then return end

	local fanHealth = ent:GetNWInt("health")
	local fanEnabled = ent:GetNWBool("fanenabled")
	local percentHealth = fanHealth / TTT_FAN.CVARS.fan_health * 100
	local drawText
	local drawColor
	local drawTitle

	if fanEnabled then
		drawTitle = "Press E to disable"
	else
		drawTitle = "Press E to enable"
	end

	if (not TTT_FAN.CVARS.fan_invincible) then
		if (percentHealth >= 100) then
			drawText = "Healthy"
			drawColor = Color(30, 230, 30)
		elseif (percentHealth >= 80) then
			drawText = "Hurt"
			drawColor = Color(157, 209, 26)
		elseif (percentHealth >= 50) then
			drawText = "Wounded"
			drawColor = Color(202, 205, 33)
		elseif (percentHealth >= 25) then
			drawText = "Badly Wounded"
			drawColor = Color(214, 139, 0)
		elseif (percentHealth >= 0) then
			drawText = "Near Death"
			drawColor = Color(170, 24, 24)
		else
			drawText = "Unaviable"
			drawColor = Color(255, 255, 255)
		end

		tData:SetSubtitle(drawText, drawColor, {})
	end

	tData:SetTitle(drawTitle, Color(255, 255, 255))
	tData:EnableText(true)
	tData:EnableOutline(false)

	return true
end)