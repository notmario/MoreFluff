SMODS.Joker {
	key = "diabolical",
	name = "Diabolical Joker",
	atlas = "mf_jokers",
	config = {
		extra = {
			cards = 7,
			mult = 1,
			chips = 7,
		},
	},
	pos = { x = 4, y = 14 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "chips", "mult", "rank", "suit", "exile", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.cards, card.ability.extra.mult, card.ability.extra.chips },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not card.getting_sliced then
			for i = 1, card.ability.extra.cards do
				FLUFF.draw_to_exile(true, i / card.ability.extra.cards)
			end
		end
		if context.individual and context.cardarea == G.play then
			local returns = { }

			for _, other_card in ipairs(G.mf_exile.cards) do
				-- if this doesnt work then Fuck You
				if context.other_card:is_suit(other_card.base.suit) or other_card:is_suit(context.other_card.base.suit) then
					returns[#returns + 1] = {
						mult = card.ability.extra.mult,
						message_card = other_card,
						juice_card = context.other_card,
					}
				end
				if context.other_card:get_id() == other_card:get_id() then
					returns[#returns + 1] = {
						chips = card.ability.extra.chips,
						message_card = other_card,
						juice_card = context.other_card,
					}
				end
			end
			return SMODS.merge_effects(returns)
		end
	end,
}