SMODS.Joker {
	key = "lettergem_b",
	atlas = "mf_oldfluff",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	no_shader_on_modbadge = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_oldfluff",
	cost = 3 * 2,
	pos = { x = 2, y = 3 },
	config = { extra = { cost = 7 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cost } }
	end,
	calculate = function(self, card, context)
		if context.starting_shop and not card.ability.triggered then
			card.ability.triggered = true
			local other_card = SMODS.add_booster_to_shop "p_buffoon_normal_1"
			other_card.base_cost = card.ability.extra.cost
			other_card:set_cost()
			return nil, true
		end
		if context.end_of_round then
			card.ability.triggered = nil
		end
	end,
}
