SMODS.Joker {
	key = "fury_sliver",
	name = "Fury Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 3,
        }
    },
	pos = { x = 4, y = 17 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
    attributes = { "retrigger", "joker", "sliver", }, 
    mf_sliver_ability = "fury_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, card.ability.extra.xmult, }}
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

FLUFF.sliver_effects.fury_sliver = {
    add_box = function(extra, default_text)
        return FLUFF.generate_ui_multiboxes {
            {
                localized_text = default_text,
                loc_vars = function(self, card, center)
                    return { vars = { } }
                end
            }
        }
    end,
    calculate = function(jokers, triggered, context, card, extra)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card == card then
            if not jokers then jokers = {} end
            jokers = SMODS.merge_effects({ jokers, { repetitions = 1 }})
        end
        return jokers, triggered
    end,
}