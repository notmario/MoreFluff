SMODS.Joker {
	key = "gemhide_sliver",
	name = "Gemhide Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 1.5,
            dollars = 2,
        }
    },
	pos = { x = 7, y = 17 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "score", "joker", "sliver", }, 
    mf_sliver_ability = "gemhide_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, card.ability.extra.dollars }}
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

FLUFF.sliver_effects.gemhide_sliver = {
    add_box = function(extra, default_text)
        return FLUFF.generate_ui_multiboxes {
            {
                localized_text = default_text,
                loc_vars = function(self, card, center)
                    return { vars = { extra.dollars } }
                end
            }
        }
    end,
    calculate = function(jokers, triggered, context, card, extra)
		if context.modify_final_cashout and not context.retrigger_joker and not context.blueprint then
            if not jokers then jokers = {} end
            jokers = SMODS.merge_effects({ jokers, {
                modify = extra.dollars
            }})
		end
        return jokers, triggered
    end,
}