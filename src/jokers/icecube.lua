SMODS.Joker({
	key = "icecube",
	name = "Ice Cube",
	atlas = "mf_jokers",
	config = {
		extra = {
            odds = 4,
            odds_mod = 0.5,
        },
	},
	pos = { x = 6, y = 11 },
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	demicoloncompat = false,
	attributes = { "mod_chance", "food", "scaling" },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.odds, center.ability.extra.odds_mod },
		}
	end,
	calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator * card.ability.extra.odds
            }
        end
		if
			context.end_of_round
			and not context.individual
			and not context.repetition
			and not context.blueprint
			and not context.retrigger_joker
		then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "odds",
				scalar_value = "odds_mod",
				operation = "-",
				message_key = "a_xprob_minus",
				message_colour = G.C.GREEN,
			})
			if card.ability.extra.odds <= 1.01 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.FILTER,
				}
			else
				-- card.ability.x_mult = card.ability.x_mult - card.ability.extra
			end
        end
	end,
})
