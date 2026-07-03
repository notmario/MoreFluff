SMODS.Joker({
	key = "lettergem_b",
	atlas = "mf_letterjokers",
    display_size = { h = 78 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_letter",
	cost = 3 * 2,
	pos = { x = 1, y = 0 },
	config = { extra = { cost = 7 } },
	attributes = { "generation", "shop", "booster", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cost } }
	end,
	calculate = function(self, card, context)
		if context.starting_shop and not card.ability.triggered then
			card.ability.triggered = true
			local other_card = SMODS.add_booster_to_shop("p_buffoon_normal_1")
			other_card.base_cost = card.ability.extra.cost
			other_card:set_cost()
			return nil, true
		end
		if context.end_of_round then
			card.ability.triggered = nil
		end
	end,
})
