SMODS.Joker {
	key = "fortunate_sliver",
	name = "Fortunate Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 1.5,
            odds_reduction = 1,
        }
    },
	pos = { x = 2, y = 18 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "mod_chance", "joker", "sliver", }, 
    mf_sliver_ability = "fortunate_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, card.ability.extra.odds_reduction }}
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

FLUFF.sliver_effects.fortunate_sliver = {
    add_box = function(extra, default_text)
        return FLUFF.generate_ui_multiboxes {
            {
                localized_text = default_text,
                loc_vars = function(self, card, center)
                    return { vars = { extra.odds_reduction } }
                end
            }
        }
    end,
    calculate = function(jokers, triggered, context, card, extra)
		if context.mod_probability and not context.blueprint then
			local new_denominator = context.denominator
			if context.denominator >= 1 and context.denominator < (1 + extra.odds_reduction) then
				new_denominator = 1
			elseif context.denominator >= (1 + extra.odds_reduction) then
				new_denominator = new_denominator - extra.odds_reduction
			end
            context.denominator = new_denominator
            if not jokers then jokers = {} end
			jokers = SMODS.merge_effects({ jokers, {
				denominator = new_denominator,
			}})
		end
        return jokers, triggered
    end,
}