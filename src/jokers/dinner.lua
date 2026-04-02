SMODS.Joker({
	key = "dinner",
	name = "Dinner",
	atlas = "mf_jokers",
	config = {
		extra = {
			rounds_left = 5,
		},
	},
	pos = { x = 5, y = 9 },
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "retrigger", "joker", "food", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.rounds_left },
		}
	end,
	calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
			retrigger_card = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card and i ~= #G.jokers.cards then
					retrigger_card = G.jokers.cards[i + 1]
					break
				end
			end
			if retrigger_card == context.other_card then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			end
		end
		if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
			if card.ability.extra.rounds_left - 1 <= 0 then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.FILTER,
				}
			else
				card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
				return {
					message = card.ability.extra.rounds_left .. "",
					colour = G.C.FILTER,
				}
			end
		end
	end,
})
