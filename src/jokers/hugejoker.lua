SMODS.Joker({
	key = "hugejoker",
	name = "Huge Joker",
	atlas = "mf_jokers",
	config = {
		h_size = -2,
		extra = {
			x_mult = 3,
		},
	},
	pos = { x = 3, y = 3 },
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	display_size = { w = 71.0 * 1.5, h = 95 * 1.5 },
	pools = { ["Meme"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				center.ability.extra.x_mult,
				center.ability.h_size < 0 and center.ability.h_size or "+" .. center.ability.h_size,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return {
				xmult = card.ability.extra.x_mult,
			}
		end
	end,
})
