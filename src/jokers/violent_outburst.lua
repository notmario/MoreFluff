SMODS.Joker({
	key = "violent_outburst",
	name = "Violent Outburst",
	config = {},
	atlas = "mf_jokers",
	pos = { x = 1, y = 16 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "economy", "reroll", "shop",  },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        if context.starting_shop then
            FLUFF.cascade(4, 1)
			return nil, true
        end
	end,
})
