SMODS.Joker {
	key = "fish",
	name = "Fish",
	atlas = "mf_jokers",
	config = {
		extra = { chips = 4, mult = 4, },
	},
	pos = { x = 3, y = 12 },
	rarity = "mf_token",
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	no_collection = true,
	attributes = { "chips", "mult" },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.chips, center.ability.extra.mult },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
			}
		end
	end,
}
