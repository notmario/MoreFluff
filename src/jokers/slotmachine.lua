SMODS.Joker({
	key = "slotmachine",
	name = "Big Win",
	atlas = "mf_jokers",
	config = {
		extra = {
			retriggers = 7,
			odds = 7,
		},
	},
	pos = { x = 2, y = 7 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		local new_numerator, new_denominator =
			SMODS.get_probability_vars(center, 1, center.ability.extra.odds, "slotmachine")
		return {
			vars = { new_numerator, new_denominator, center.ability.extra.retriggers },
		}
	end,
	calculate = function(self, card, context)
		if context.repetition and context.other_card:get_id() == 7 then
			if SMODS.pseudorandom_probability(card, "slotmachine", 1, card.ability.extra.odds, "slotmachine") then
				return {
					message = localize("k_again_ex_ex"),
					repetitions = card.ability.extra.retriggers,
					card = card,
				}
			end
		end
	end,
})
