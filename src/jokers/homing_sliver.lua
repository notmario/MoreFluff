SMODS.Joker {
	key = "homing_sliver",
	name = "Homing Sliver",
	atlas = "mf_jokers",
	config = {
        extra = {
            odds = 5,
        }
    },
	pos = { x = 6, y = 17 },
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    attributes = { "joker", "sliver", }, 
    -- mf_sliver_ability = "homing_sliver",
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