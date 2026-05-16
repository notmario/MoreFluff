SMODS.Joker({
	key = "jankman",
	name = "Jankman",
	atlas = "mf_jokers",
	config = {
		extra = { x_chips = 1.31 },
	},
	pos = { x = 0, y = 1 },
	rarity = 3,
	cost = 9,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xchips", "joker", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.x_chips },
		}
	end,
	calculate = function(self, card, context)
		if context.other_joker and context.other_joker.ability.set == "Joker" then
			local real = context.other_joker.config.center.original_mod
			if real then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
				return {
					xchips = card.ability.extra.x_chips,
				}
			end
		end
	end,
})
