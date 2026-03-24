SMODS.Joker({
	key = "mspaint",
	name = "MS Paint Joker",
	atlas = "mf_jokers",
	config = {
		h_size = 0,
		extra = 3,
	},
	pos = { x = 2, y = 1 },
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and card.ability.h_size == 0 then
			card.ability.h_size = card.ability.h_size + card.ability.extra
			G.hand:change_size(card.ability.extra)
		end
		if context.after and not context.blueprint and card.ability.h_size ~= 0 and context.cardarea == G.jokers then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.hand:change_size(-card.ability.extra)
					card.ability.h_size = 0
					return true
				end,
			}))
		end
	end,
})
