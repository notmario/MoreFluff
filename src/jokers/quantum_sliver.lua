SMODS.Joker {
	key = "quantum_sliver",
	name = "Quantum Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 1.5,
            create_odds = 7,
        }
    },
	pos = { x = 3, y = 18 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "generation", "consumable", "chance", "joker", "sliver", }, 
    mf_sliver_ability = "quantum_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, card.ability.extra.create_odds }}
	end,
	calculate = function(self, card, context)
		if context.modify_weights and context.pool_types.Joker then
			for _, c in pairs(context.pool) do
				if FLUFF.has_attribute(c.key, "sliver") then
					c.weight = c.weight * card.ability.extra.odds
				end
			end
		end
    end,
}

FLUFF.sliver_effects.quantum_sliver = {
    add_box = function(extra, default_text)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, extra.create_odds, "quantum_sliver")
        return FLUFF.generate_ui_multiboxes {
            {
                localized_text = default_text,
                loc_vars = function(self, card, center)
                    return { vars = { new_numerator, new_denominator } }
                end
            }
        }
    end,
    calculate = function(jokers, triggered, context, card, extra)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			if SMODS.pseudorandom_probability(card, "quantum_sliver", 1, extra.create_odds, "quantum_sliver") then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = (function()
						G.E_MANAGER:add_event(Event({
							func = function()
								SMODS.add_card {
									set = 'Consumeables',
								}
								G.GAME.consumeable_buffer = 0
								return true
							end
						}))
						SMODS.calculate_effect({ message = localize('k_plus_consumable') },
							context.blueprint_card or card)
						return true
					end)
				}))
			end
			triggered = true
        end
        return jokers, triggered
    end,
}