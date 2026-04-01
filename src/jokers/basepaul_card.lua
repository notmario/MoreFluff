SMODS.Joker({
	key = "basepaul_card",
	name = "Basepaul Card",
	atlas = "mf_jokers",
	config = {
		extra = {
			x_mult = 1.25,
		},
	},
	pos = { x = 1, y = 0 },
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xmult", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.x_mult, center.ability.extra.x_mult * 10 },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			if string.find(string.lower(G.PROFILES[G.SETTINGS.profile].name), "paul") then
				return {
					xmult = card.ability.extra.x_mult * 10,
				}
			else
				return {
					xmult = card.ability.extra.x_mult,
				}
			end
		end
	end,
})
