SMODS.Joker({
	key = "hyperbeam",
	name = "Hyper Beam",
	atlas = "mf_jokers",
	config = {
		extra = 3,
	},
	pos = { x = 6, y = 2 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not (context.blueprint_card or card).getting_sliced then
			G.E_MANAGER:add_event(Event({
				func = function()
					ease_discard(-G.GAME.current_round.discards_left, nil, true)
					return true
				end,
			}))
		end
		if context.cardarea == G.jokers and context.joker_main then
			return {
				xmult = card.ability.extra,
			}
		end
	end,
})
