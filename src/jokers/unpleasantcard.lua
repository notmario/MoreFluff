SMODS.Joker({
	key = "unpleasantcard",
	name = "Unpleasant Card",
	atlas = "mf_jokers",
	config = {
		extra = {
			x_chips = 2.067,
		},
	},
	pos = { x = 0, y = 7 },
	rarity = 2,
	cost = 6.5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	pools = { ["Meme"] = true },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.x_chips },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return {
				xchips = card.ability.extra.x_chips,
			}
		end
	end,
})
