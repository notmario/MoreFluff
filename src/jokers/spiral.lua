SMODS.Joker {
	key = "spiral",
	name = "Spiral Joker",
	atlas = "mf_jokers",
	config = {
		extra = { mult = 10, coeff = 7, dilation = 8 },
	},
	pos = { x = 1, y = 1 },
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		local val = center.ability.extra.mult
			+ math.floor(
				center.ability.extra.coeff
						* math.cos(math.pi / center.ability.extra.dilation * to_number(G.GAME.dollars) or 0)
					+ 0.5
			)
		return {
			vars = { center.ability.extra.mult, center.ability.extra.coeff, center.ability.extra.dilation, val },
		}
	end,

	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
			return {
				mult = card.ability.extra.mult + math.floor(
					card.ability.extra.coeff
							* math.cos(math.pi / card.ability.extra.dilation * to_number(G.GAME.dollars) or 0)
						+ 0.5
				),
			}
		end
	end,
}
