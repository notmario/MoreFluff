SMODS.Joker {
	key = "megantic_sliver",
	name = "Megantic Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 1.5,
            emult = 1.08,
        }
    },
	pos = { x = 9, y = 17 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "emult", "joker", "sliver", }, 
    mf_sliver_ability = "megantic_sliver",
	loc_vars = function(self, info_queue, card)
	    return { vars = { card.ability.extra.odds, card.ability.extra.emult, }}
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

FLUFF.sliver_effects.megantic_sliver = {
    add_box = function(extra, default_text)
        return FLUFF.generate_ui_multiboxes {
            {
                localized_text = default_text,
                loc_vars = function(self, card, center)
                    return { vars = { extra.emult } }
                end
            }
        }
    end,
    calculate = function(jokers, triggered, context, card, extra)
        if context.joker_main then
            if not jokers then jokers = {} end
			if FLUFF.should_talisman_key("emult") then
				jokers = SMODS.merge_effects({ jokers, {
					emult = extra.emult,
				}})
			else
				jokers = SMODS.merge_effects({ jokers, {
					message = "^" .. extra.emult .. " Mult",
					colour = G.C.DARK_EDITION,
					sound = "mf_emult",
					pre_func = function()
						mult = mod_mult(mult ^ extra.emult)
					end,
				}})
			end
        end
        return jokers, triggered
    end,
}