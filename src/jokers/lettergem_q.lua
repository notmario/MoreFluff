SMODS.Joker({
	key = "lettergem_q",
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
	cost = 10 * 2,
	pos = { x = 7, y = 1 },
	config = { extra = { xmult = 1.3 } },
	attributes = { "xmult", "rank", "queen", "position", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
				}
			else
				local is_adjacent = false
				for i = 1, #G.hand.cards do
					if
						(G.hand.cards[i]:get_id() == 12 and G.hand.cards[i - 1] == context.other_card)
						or (G.hand.cards[i]:get_id() == 12 and G.hand.cards[i + 1] == context.other_card)
					then
						return {
							x_mult = card.ability.extra.xmult,
						}
					end
				end
			end
		end
	end,
})
