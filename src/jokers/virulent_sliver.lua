SMODS.Joker {
	key = "virulent_sliver",
	name = "Virulent Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 2,
            poisonous = 0.5,
        }
    },
	pos = { x = 5, y = 17 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "score", "joker", "sliver", }, 
    mf_sliver_ability = "virulent_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, card.ability.extra.poisonous,
            colours = {
                darken(G.C.GREEN, 0.2)
            }
        }}
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

FLUFF.sliver_effects.virulent_sliver = {
    add_box = function(extra, default_text)
        return FLUFF.generate_ui_multiboxes {
            {
                localized_text = default_text,
                loc_vars = function(self, card, center)
                    return { vars = { extra.poisonous, 
                    colours = {
                        darken(G.C.GREEN, 0.2)
                    } } }
                end
            }
        }
    end,
    calculate = function(jokers, triggered, context, card, extra)
		if context.post_trigger and card == context.other_card then
            if not jokers then jokers = {} end
            jokers = SMODS.merge_effects({ jokers, FLUFF.poisonous(context.other_ret.jokers, extra.poisonous) })
		end
        return jokers, triggered
    end,
}