SMODS.Joker({
	key = "lettergem_j",
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
	cost = 8 * 2,
	pos = { x = 0, y = 1 },
	config = { extra = { money_per = 0.5 } },
	attributes = { "retrigger", "joker", "economy", "position", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money_per } }
	end,
	calculate = function(self, card, context)
		if context.retrigger_joker_check then
			for i = 1, #G.jokers.cards do
				if
					(G.jokers.cards[i] == card and G.jokers.cards[i + 1] == context.other_card)
					or (G.jokers.cards[i] == card and G.jokers.cards[i + 2] == context.other_card)
				then
					return {
						repetitions = 1,
					}
				end
			end
		end
		if context.post_trigger then
			for i = 1, #G.jokers.cards do
				if
					(G.jokers.cards[i] == card and G.jokers.cards[i + 1] == context.other_card)
					or (G.jokers.cards[i] == card and G.jokers.cards[i + 2] == context.other_card)
				then
					return {
						dollars = -card.ability.extra.money_per,
					}
				end
			end
		end
	end,
})
