SMODS.Joker {
	key = "philosophical",
	name = "Philosophical Joker",
	atlas = "mf_jokers",
	config = {
		card_limit = 1,
	},
	pos = { x = 4, y = 0 },
	rarity = 1,
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.card_limit },
		}
	end,
}

return joker
