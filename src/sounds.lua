SMODS.Sound({
	key = "g_riff",
	path = "g.ogg",
	pitch = 1.0,
})

SMODS.Sound({
	key = "music_colourpack",
	path = "music_colourpack.ogg",
	select_music_track = function()
		return (
			((SMODS.OPENED_BOOSTER or {}).ability or {}).colour_pack
			and G.booster_pack
			and not G.booster_pack.REMOVED
		)
	end,
})

SMODS.Sound({
	key = "music_rotarot",
	path = "music_rotarot.ogg",
	select_music_track = function()
		return (
			((SMODS.OPENED_BOOSTER or {}).ability or {}).rotarot_pack
			and G.booster_pack
			and not G.booster_pack.REMOVED
		)
	end,
})

SMODS.Sound({
	key = "treethree",
	path = "treethree.ogg",
	pitch = 1.0,
})

SMODS.Sound({
	key = "buzzer",
	path = "buzzer.ogg",
	pitch = 1.0,
})