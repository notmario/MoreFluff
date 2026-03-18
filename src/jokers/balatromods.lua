SMODS.Joker({
	key = "balatromods",
	name = "Balatro Mods (Working 2024)",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 8, y = 0 },
	cost = 3,
	config = { extra = { cost = 2 } },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cost } }
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			if not context.blueprint then
				local eval = function()
					return G.GAME.current_round.hands_played == 0
				end
				juice_card_until(card, eval, true)
			end
		end
		if context.cardarea == G.jokers then
			if context.before then
				if #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 then
					ease_dollars(-card.ability.extra.cost)
					for i, v in ipairs(context.full_hand) do
						local percent = 1.15 - (i - 0.999) / (#context.full_hand - 0.998) * 0.3
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.15,
							func = function()
								play_sound("card1", percent)
								context.full_hand[i]:juice_up(0.3, 0.3)
								context.full_hand[i]:flip()
								return true
							end,
						}))
					end
					for i, v in ipairs(context.full_hand) do
						local cen = SMODS.poll_enhancement({ guaranteed = true, no_replace = true })
						local percent = 0.85 + (i - 0.999) / (#context.full_hand - 0.998) * 0.3
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.15,
							func = function()
								play_sound("tarot2", percent)
								context.full_hand[i]:set_ability(cen)
								context.full_hand[i]:flip()
								return true
							end,
						}))
					end
					return {
						message = "Enhanced!",
						colour = G.C.RED,
						card = card,
					}
				end
			end
		end
	end,
})
