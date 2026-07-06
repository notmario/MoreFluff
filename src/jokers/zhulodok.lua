SMODS.Joker({
	key = "zhulodok",
	name = "Zhulodok",
	atlas = "mf_jokers",
	config = {
        extra = {
            active = true,
        }
    },
	pos = { x = 4, y = 16 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "economy", "reroll", "shop", "rarity", "on_sell", },
	loc_vars = function(self, info_queue, card)
		return {}
	end,
	calculate = function(self, card, context)
		if context.selling_card and card.ability.extra.active and context.card.ability.set == "Joker" and context.card.config.center.rarity ~= 1 and (G.shop_jokers and G.shop_jokers.cards) then
            card.ability.extra.active = false

            FLUFF.cascade(card, 10, 2)
		end
		if
			context.starting_shop and not card.ability.extra.active
		then
			card.ability.extra.active = true
			return {
				message = localize("k_active_ex"),
			}
		end
	end,
})
