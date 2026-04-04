SMODS.Joker({
	key = "passando",
	name = "Passing Balatro in 5 Minutes",
	atlas = "mf_jokers",
	config = {
		extra = {
			blinds_skipped = 0,
			threshold = 2,
		},
	},
	pos = { x = 5, y = 8 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "generation", "skip", },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_diet_cola
		return {
			vars = { center.ability.extra.blinds_skipped, center.ability.extra.threshold },
		}
	end,
	calculate = function(self, card, context)
		if context.skip_blind and not context.blueprint then
			card.ability.extra.blinds_skipped = card.ability.extra.blinds_skipped + 1
			local create = 0
			while card.ability.extra.blinds_skipped >= card.ability.extra.threshold do
				create = create + 1
				card.ability.extra.blinds_skipped = card.ability.extra.blinds_skipped - card.ability.extra.threshold
			end
			if create ~= 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						for i = 1, create do
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								delay = 0.4,
								func = function()
									play_sound("timpani")
									local n_card = create_card(nil, G.jokers, nil, nil, nil, nil, "j_diet_cola", "sup")
									n_card:add_to_deck()
									n_card:set_edition({ negative = true }, true)
									G.jokers:emplace(n_card)
									card:juice_up(0.3, 0.5)
									return true
								end,
							}))
						end
						delay(0.6)
						return true
					end,
				}))
			else
				return {
					message = card.ability.extra.blinds_skipped .. "/" .. card.ability.extra.threshold,
				}
			end
		end
	end,
})

return joker
