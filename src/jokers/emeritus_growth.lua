SMODS.Joker {
	key = "emeritus_growth",
	name = "Emeritus of Growth",
	config = {
		extra = {
			is_prepared = false,
			count = 0,
		},
	},
	prepared_card = "c_ectoplasm",
	pos = { x = 8, y = 5 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "spectral", "generation", "reset", "consumable", },
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.count } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
			card.ability.extra.count = card.ability.extra.count + (G.jokers.config.card_limit - #G.jokers.cards)
			if card.ability.extra.count >= 20 then
				card.ability.extra.count = 0
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
					message = card.ability.extra.count.."/20",
				}
			end
		end
		if context.mf_used_prepared and context.card == card then
			G.hand:change_size(G.GAME.ecto_minus or 1)
		end
	end,
}