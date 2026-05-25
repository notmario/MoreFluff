SMODS.Joker({
	key = "lettergem_c",
	atlas = "mf_letterjokers",
    display_size = { h = 78 },
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	no_collection = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_letter",
	cost = 3 * 2,
	pos = { x = 2, y = 0 },
	config = { extra = { xmult = 5, counter = 0 } },
	attributes = { "xmult", "rank", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.counter } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint then
			if context.other_card.ability and context.other_card.ability.effect == "Stone Card" then
				card.ability.extra.counter = card.ability.extra.counter + (50 + card.ability.perma_bonus)
			else
				card.ability.extra.counter = card.ability.extra.counter
					+ (context.other_card.base.nominal + context.other_card.ability.perma_bonus)
			end
			local effects = {}
			while card.ability.extra.counter >= 100 do
				card.ability.extra.counter = card.ability.extra.counter - 100
				effects[#effects + 1] = { xmult = card.ability.extra.xmult }
			end
			return SMODS.merge_effects(effects)
		end
	end,
})
