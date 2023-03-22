CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"
CLGAMEMODESUBMENU.title = "submenu_addons_fan_title"

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "help_fan_general")

	form:MakeCheckBox({
		label = "label_fan_use_sound",
		serverConvar = "ttt_fan_use_sound"
	})

	form:MakeSlider({
		label = "label_fan_sound_loudness",
		serverConvar = "ttt_fan_sound_loudness",
		min = 0.1,
		max = 1.0,
		decimal = 1
	})

	form:MakeSlider({
		label = "label_fan_place_range",
		serverConvar = "ttt_fan_place_range",
		min = 200,
		max = 1000,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_fan_range",
		serverConvar = "ttt_fan_range",
		min = 100,
		max = 3000,
		decimal = 0
	})

	local form2 = vgui.CreateTTT2Form(parent, "help_fan_props")

	form2:MakeCheckBox({
		label = "label_fan_effect_props",
		serverConvar = "ttt_fan_effect_props"
	})

	form2:MakeSlider({
		label = "label_fan_prop_strength",
		serverConvar = "ttt_fan_prop_strength",
		min = 0.1,
		max = 5,
		decimal = 1
	})

	local form3 = vgui.CreateTTT2Form(parent, "help_fan_player")

	form3:MakeSlider({
		label = "label_fan_strength",
		serverConvar = "ttt_fan_strength",
		min = 2,
		max = 20,
		decimal = 0
	})
end
