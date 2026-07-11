SMODS.Joker {
	key = "the_first_sliver",
	name = "The First Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 2,
        }
    },
	pos = { x = 0, y = 18 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "generation", "economy", "reroll", "shop", "joker", "sliver", }, 
    mf_sliver_ability = "the_first_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, }}
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

FLUFF.sliver_effects.the_first_sliver = {
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
        if context.buying_self then
            FLUFF.cascade(card, 7)
			triggered = true
        end
        return jokers, triggered
    end,
}