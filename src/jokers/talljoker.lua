SMODS.Joker({
	key = "talljoker",
	name = "Tall Joker",
	config = {
		extra = {
			mult = 44,
		},
	},
	pos = { x = 5, y = 2 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_shader_on_modbadge = true,
	no_collection = true,
	cost = 9,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	display_size = { w = 71.0 / 1.5, h = 95 * 1.5 },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.mult },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end,
})
