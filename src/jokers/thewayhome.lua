SMODS.Joker({
	key = "thewayhome",
	name = "the way home",
	atlas = "mf_jokers",
	config = {
		extra = 4,
		odds = 3,
	},
	pos = { x = 1, y = 8 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "chance", "hands", },
	loc_vars = function(self, info_queue, center)
		local new_numerator, new_denominator = SMODS.get_probability_vars(center, 1, center.ability.odds, "thewayhome")
		return {
			vars = { new_numerator, new_denominator, center.ability.extra },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
			if SMODS.pseudorandom_probability(card, "thewayhome", 1, card.ability.odds, "thewayhome") then
				return {
					message = localize("k_correct_ex"),
					func = function()
						ease_hands_played(card.ability.extra)
					end,
				}
			end
		end
	end,
})
