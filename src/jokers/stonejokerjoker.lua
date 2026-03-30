SMODS.Joker({
	key = "stonejokerjoker",
	name = "Stone Joker Joker",
	atlas = "mf_jokers",
	config = {},
	pos = { x = 3, y = 6 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.j_marble
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if
			(context.ending_shop or context.forcetrigger)
			and not card.getting_sliced
			and not (context.blueprint_card or card).getting_sliced
		then
			local jokers_to_create = 1
			G.E_MANAGER:add_event(Event({
				func = function()
					local n_card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_marble", "sjj")
					n_card:add_to_deck()
					n_card:set_edition({ negative = true })
					n_card:set_eternal(true)
					G.jokers:emplace(n_card)
					n_card:start_materialize()
					G.GAME.joker_buffer = 0
					return true
				end,
			}))
			card_eval_status_text(
				context.blueprint_card or card,
				"extra",
				nil,
				nil,
				nil,
				{ message = localize("k_plus_joker"), colour = G.C.BLUE }
			)
		end
	end,
})
