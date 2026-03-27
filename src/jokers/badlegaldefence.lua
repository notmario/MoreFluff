SMODS.Joker({
	key = "badlegaldefence",
	name = "Bad Legal Defence",
	config = {},
	pos = { x = 7, y = 3 },
	atlas = "mf_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_death
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if
			(context.setting_blind and context.blind.boss)
			and not (context.blueprint_card or self).getting_sliced
		then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.0,
					func = function()
						local n_card = create_card(nil, G.consumeables, nil, nil, nil, nil, "c_death", "sup")
						n_card:add_to_deck()
						G.consumeables:emplace(n_card)
						G.GAME.consumeable_buffer = 0
						return true
					end,
				}))
				return {
					message = localize("k_death_caps"),
					colour = G.C.PURPLE,
				}
			end
		end
	end,
})
