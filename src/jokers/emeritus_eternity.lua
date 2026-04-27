SMODS.Joker {
	key = "emeritus_eternity",
	name = "Emeritus of Eternity",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = false,
		},
	},
	prepared_card = "v_hieroglyph",
	pos = { x = 0, y = 0 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "spectral", "generation", "reset", },
	loc_vars = function(self, info_queue, center)
		return {}
	end,
	calculate = function(self, card, context)
	end,
}