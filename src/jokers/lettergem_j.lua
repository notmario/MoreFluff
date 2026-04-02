SMODS.Joker({
	key = "lettergem_j",
	atlas = "mf_oldfluff",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	no_shader_on_modbadge = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_oldfluff",
	cost = 8 * 2,
	pos = { x = 0, y = 4 },
	config = { extra = { money_per = 0.5 } },
	attributes = { "retrigger", "joker", },
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
