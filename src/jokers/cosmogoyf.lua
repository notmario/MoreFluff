SMODS.Joker({
	key = "cosmogoyf",
	name = "Cosmogoyf",
	atlas = "mf_jokers",
	config = {
        extra = {
            mult_per = 1,
        }
    },
	pos = { x = 5, y = 16 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "exile", "mult", "shop", "space", },
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.mult_per,
                #((G.mf_exile or {}).cards or {}) * card.ability.extra.mult_per,
            }
        }
	end,
	calculate = function(self, card, context)
        if context.ending_shop and not context.blueprint then
            for i, _card in ipairs(G.shop_jokers.cards) do
                if _card.children.price then _card.children.price:remove() end
                _card.children.price = nil
                if _card.children.buy_button then _card.children.buy_button:remove() end
                _card.children.buy_button = nil
                remove_nils(_card.children)
                FLUFF.exile_card(_card, 1 - i / #G.shop_jokers.cards, nil)
            end
        end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult_per * #G.mf_exile.cards
			}
		end
	end,
})
