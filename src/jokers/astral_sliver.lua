SMODS.Joker {
	key = "astral_sliver",
	name = "Astral Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 1.5,
            lvup_odds = 8,
        }
    },
	pos = { x = 4, y = 18 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "hand_type", "space", "chance", "hand_level", "joker", "sliver", }, 
    mf_sliver_ability = "astral_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, card.ability.extra.lvup_odds }}
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

FLUFF.sliver_effects.astral_sliver = {
    add_box = function(extra, default_text)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, extra.lvup_odds, "astral_sliver")
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
        if context.before and SMODS.pseudorandom_probability(card, 'astral_sliver', 1, extra.lvup_odds) then
            if not jokers then jokers = {} end
            jokers = SMODS.merge_effects({ jokers, {
                level_up = true,
                message = localize('k_level_up_ex')
            }})
        end
        return jokers, triggered
    end,
}