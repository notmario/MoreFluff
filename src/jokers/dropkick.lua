SMODS.Joker({
	key = "dropkick",
	name = "Dropkick",
	atlas = "mf_jokers",
	config = {
		extra = {
			hands = 1,
		},
		base_cost = 8,
	},
	pos = { x = 4, y = 2 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.hands },
		}
	end,
	calculate = function(self, card, context)
		if
			context.after
			and context.cardarea == G.jokers
			and context.poker_hands
			and next(context.poker_hands["Straight"])
		then
			ease_hands_played(card.ability.extra.hands)
			return {
				message = localize({ type = "variable", key = "a_plus_hand", vars = { card.ability.extra.hands } }),
				colour = G.C.BLUE,
			}
		end
	end,
})
