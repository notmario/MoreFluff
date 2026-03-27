SMODS.Joker({
	key = "hollow",
	name = "Hollow Joker",
	atlas = "mf_jokers",
	config = {
		h_size = -1,
		extra = {
			mult_per = 10,
			thresh = 9,
		},
	},
	pos = { x = 4, y = 1 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.h_size, center.ability.extra.mult_per, center.ability.extra.thresh } }
	end,
	calculate = function(self, card, context)
		if
			(context.cardarea == G.jokers and context.joker_main)
			and G.hand.config.card_limit < card.ability.extra.thresh
		then
			return {
				mult = card.ability.extra.mult_per * (card.ability.extra.thresh - G.hand.config.card_limit),
			}
		end
	end,
})
