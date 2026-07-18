SMODS.Joker({
	key = "freaky_pizza",
	name = "Freaky Pizza",
	config = {
		extra = { freakiness = 23, increase = 23, },
	},
	pos = { x = 7, y = 6 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xchips", "freaky", "food", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.freakiness, card.ability.extra.increase },
		}
	end,
	calculate = function(self, card, context)
        if context.joker_main then
			if FLUFF.has_calc_key("xlog_chips") then
				return {
					xlog_chips = card.ability.freakiness,
				}
			else
				return {
					message = "Chips Xlog(Chips)",
					pre_func = function()
                        local param = SMODS.Scoring_Parameters["chips"]
						local log = math.log(param.current < 0 and 1 or param.current, card.ability.extra.freakiness)
                        param:modify(param.current*log - param.current)
					end,
					sound = "mf_echips",
					colour = G.C.DARK_EDITION,
				}
			end
        end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "freakiness",
				scalar_value = "increase",
                message_key = "a_freak",
                message_colour = G.C.RED,
			})
		end
	end,
})
