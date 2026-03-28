SMODS.Joker({
	key = "philosophical",
	name = "Philosophical Joker",
	atlas = "mf_jokers",
	config = {
		extra = { slots = 1 },
	},
	pos = { x = 4, y = 0 },
	rarity = 1,
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.slots },
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
	end
})

return joker
