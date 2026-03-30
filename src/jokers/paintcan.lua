SMODS.Joker({
	key = "paintcan",
	name = "Paint Can",
	atlas = "mf_jokers",
	config = {
		extra = {
			odds = 2,
		},
	},
	pos = { x = 1, y = 7 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		local new_numerator, new_denominator =
			SMODS.get_probability_vars(center, 1, center.ability.extra.odds, "paintcan")
		return {
			vars = { new_numerator, new_denominator },
		}
	end,
})
