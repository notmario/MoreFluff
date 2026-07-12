SMODS.Joker {
	key = "muscle_sliver",
	name = "Muscle Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 1.5,
            mult = 4,
        }
    },
	pos = { x = 1, y = 17 },
	rarity = 1,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "mult", "joker", "sliver", }, 
    mf_sliver_ability = "muscle_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, card.ability.extra.mult, }}
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

FLUFF.sliver_effects.muscle_sliver = {
    add_box = function(extra, default_text)
        return FLUFF.generate_ui_multiboxes {
            {
                localized_text = default_text,
                loc_vars = function(self, card, center)
                    return { vars = { extra.mult } }
                end
            }
        }
    end,
    calculate = function(jokers, triggered, context, card, extra)
        if context.joker_main then
            if not jokers then jokers = {} end
            jokers = SMODS.merge_effects({ jokers, { mult = extra.mult }})
        end
        return jokers, triggered
    end,
}