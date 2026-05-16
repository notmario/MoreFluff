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
	key = "music_modded",
	path = "music_modded.ogg",
	select_music_track = function()
		return (
			((SMODS.OPENED_BOOSTER or {}).ability or {}).modded_pack
			and G.booster_pack
			and not G.booster_pack.REMOVED
		)
	end,
})

SMODS.Sound({
	key = "music_duelzone",
	path = "music_duelzone.ogg",
	sync = false,
	pitch = 1.0,
	volume = 1.3,
	select_music_track = function()
		return G.GAME.mf_superboss_active and 6 -- notably lower than jimball (Funny)
	end,
})

-- is this a leak?   i dont really care
if (SMODS.Mods.Cryptid or SMODS.Mods.Decryptid or {}).can_load then
	local key = "j_cry_jimball"
	if (SMODS.Mods.Decryptid or {}).can_load then key = "j_dcry_jimball" end
	SMODS.Sound({
		key = "music_duelzone_jimball",
		path = "music_duelzone_jimball.ogg",
		sync = false,
		pitch = 1.0,
		volume = 1.3,
		select_music_track = function()
			return G.GAME.mf_superboss_active and next(SMODS.find_card(key)) and 9999
		end,
	})
end

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


SMODS.Sound({
	key = "halt-alt",
	path = "halt-alt.ogg",
	pitch = 1.0,
})

SMODS.Sound({
	key = "jokerrotate",
	path = "jokerrotate.ogg",
	pitch = 1.0,
})

SMODS.Sound({
	key = "spacejumpscare",
	path = "spacejumpscare.ogg",
	pitch = 1.0,
})

SMODS.Sound({
	key = "disintegrationreset",
	path = "disintegrationreset.ogg",
	volume = 0.4,
	pitch = 1.0,
})
