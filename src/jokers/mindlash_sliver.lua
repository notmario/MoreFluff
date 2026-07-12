SMODS.Joker {
	key = "mindlash_sliver",
	name = "Mindlash Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 1.5,
        }
    },
	pos = { x = 8, y = 17 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "on_sell", "joker", "sliver", "boss_blind" }, 
    mf_sliver_ability = "mindlash_sliver",
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

FLUFF.sliver_effects.mindlash_sliver = {
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
        if context.selling_self then
            if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.boss then
                if not jokers then jokers = {} end
                jokers = SMODS.merge_effects({ jokers, {
                    message = localize('ph_boss_disabled'),
                    func = function() -- This is for timing purposes, it runs after the message
                        G.GAME.blind:disable()
                    end
                }})
            end
        end
        return jokers, triggered
    end,
}