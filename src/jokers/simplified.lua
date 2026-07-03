SMODS.Joker({
	key = "simplified",
	name = "Simplified Joker",
	atlas = "mf_jokers",
	config = {
		extra = { mult = 4 },
	},
	pos = { x = 9, y = 0 },
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "mult", "rarity", "joker", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.mult },
		}
	end,
	calculate = function(self, card, context)
		if
			context.other_joker
			and context.other_joker.config.center.rarity == 1
			and context.other_joker.ability.set == "Joker"
		then
			G.E_MANAGER:add_event(Event({
				func = function()
					context.other_joker:juice_up(0.5, 0.5)
					return true
				end,
			}))
			return {
				mult = card.ability.extra.mult,
			}
		end
		if context.forcetrigger then
			return { mult = card.ability.extra.mult }
		end
	end,
})
