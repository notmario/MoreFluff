SMODS.Joker({
	key = "brilliant",
	name = "Brilliant",
	atlas = "mf_jokers",
	config = {
		extra = {},
	},
	pos = { x = 7, y = 7 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "spectral", "hands", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.cardarea == G.jokers then
			if
				G.GAME.current_round.hands_played <= 1
				and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
			then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.0,
					func = function()
						local card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "sea")
						card:add_to_deck()
						G.consumeables:emplace(card)
						G.GAME.consumeable_buffer = 0
						return true
					end,
				}))
				return {
					message = localize("k_plus_spectral"),
					colour = G.C.SECONDARY_SET.Spectral,
					card = card,
				}
			end
		end
	end,
})
