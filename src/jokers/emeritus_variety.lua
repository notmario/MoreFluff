SMODS.Joker {
	key = "emeritus_variety",
	name = "Emeritus of Variety",
	atlas = "mf_jokers",
	config = {
		extra = {
			is_prepared = false,
			sell_count = 0,
		},
	},
	prepared_card = "c_emperor",
	pos = { x = 7, y = 12 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "tarot", "generation", "consumable", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.sell_count } }
	end,
	calculate = function(self, card, context)
		if context.selling_card and not context.selling_self then
            card.ability.extra.sell_count = card.ability.extra.sell_count + 1
			if card.ability.extra.sell_count >= 4 then
				card.ability.extra.sell_count = card.ability.extra.sell_count - 4
				if not card.ability.extra.is_prepared then
					card.ability.extra.is_prepared = true
					return {
						message = localize "k_prepared_ex",
						colour = G.C.SECONDARY_SET.Spectral,
					}
				else
					return {
						message = localize "k_reset",
						colour = G.C.RED,
					}
				end
			else
				return {
					message = card.ability.extra.sell_count.."/4",
				}
			end
		end
	end,
}