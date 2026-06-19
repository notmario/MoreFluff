SMODS.Joker({
	key = "lettergem_w",
	atlas = "mf_letterjokers",
    display_size = { h = 78 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_letter",
	cost = 4 * 2,
	pos = { x = 4, y = 2 },
	config = { extra = { odds = 0.8 } },
	attributes = { "generation", "tarot", "modify_card", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if
			context.setting_blind
			and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
		then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
							local other_card = SMODS.add_card({
								-- set = 'Joker',
								key = "c_wheel_of_fortune",
							})
							other_card.ability.extra = math.floor(other_card.ability.extra / card.ability.extra.odds)
							G.GAME.consumeable_buffer = 0
							return true
						end,
					}))
					SMODS.calculate_effect(
						{ message = localize("k_plus_tarot"), colour = G.C.PURPLE },
						context.blueprint_card or card
					)
					return true
				end,
			}))
			return nil, true -- This is for Joker retrigger purposes
		end
	end,
})
