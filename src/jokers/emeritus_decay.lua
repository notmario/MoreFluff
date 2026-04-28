SMODS.Joker {
	key = "emeritus_decay",
	name = "Emeritus of Decay",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = false,
		},
	},
	prepared_card = "c_hanged_man",
	pos = { x = 0, y = 0 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "tarot", "generation", "reset", },
	loc_vars = function(self, info_queue, center)
		return {}
	end,
	calculate = function(self, card, context)
		if context.playing_card_added and not card.ability.extra.is_prepared then
			card.ability.extra.is_prepared = true
			return {
				message = localize "k_prepared_ex",
				colour = G.C.SECONDARY_SET.Spectral,
			}
		end
	end,
}