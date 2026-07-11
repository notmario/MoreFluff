SMODS.Joker {
	key = "plasma_sliver",
	name = "Plasma Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 2,
            percent_swap = 0.1,
        }
    },
	pos = { x = 5, y = 18 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "swap", "joker", "sliver", }, 
    mf_sliver_ability = "plasma_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, card.ability.extra.percent_swap * 100 }}
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

FLUFF.sliver_effects.plasma_sliver = {
    add_box = function(extra, default_text)
        return FLUFF.generate_ui_multiboxes {
            {
                localized_text = default_text,
                loc_vars = function(self, card, center)
                    return { vars = { extra.percent_swap * 100 } }
                end
            }
        }
    end,
    calculate = function(jokers, triggered, context, card, extra)
        if context.joker_main then
            if not jokers then jokers = {} end
			if FLUFF.has_calc_key("cry_broken_swap") then
				jokers = SMODS.merge_effects({ jokers, {
					cry_broken_swap = extra.percent_swap
				}})
			else
				jokers = SMODS.merge_effects({ jokers, {
					message = localize "k_balanced_qu",
					colour = G.C.PURPLE,
					func = function()
						juice_card(card)
						local chips = SMODS.Scoring_Parameters.chips
						local mult = SMODS.Scoring_Parameters.mult
						local chip_mod = chips.current * extra.percent_swap
						local mult_mod = mult.current * extra.percent_swap

						-- modifications are done in two steps to avoid rounding errors with larger bignums setting values to 0
						chips.current = chips.current * (1 - extra.percent_swap)
						chips:modify(mult_mod)
						mult.current = mult.current * (1 - extra.percent_swap)
						mult:modify(chip_mod)

						G.E_MANAGER:add_event(Event({
							func = (function()
								-- scored_card:juice_up()
								play_sound('gong', 0.6, 0.3)
								play_sound('gong', 0.6*1.5, 0.2)
								play_sound('tarot1', 1.5)
								ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
								ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									blockable = false,
									blocking = false,
									delay =  0.8,
									func = (function()
										ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
										ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
										return true
									end)
								}))
								G.E_MANAGER:add_event(Event({
									trigger = 'after',
									blockable = false,
									blocking = false,
									no_delete = true,
									delay =  1.3,
									func = (function()
										G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
										G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
										return true
									end)
								}))
								return true
							end)
						}))     
					end
				}})
			end
		end
        return jokers, triggered
    end,
}