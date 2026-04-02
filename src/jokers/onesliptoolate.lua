SMODS.Joker({
	key = "onesliptoolate",
	name = "One Slip Too Late",
	atlas = "mf_jokers",
	config = {
		extra = {},
	},
	pos = { x = 5, y = 5 },
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	demicoloncompat = true,
	attributes = { "xmult", "hands", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { (G.GAME.current_round.hands_played or 0) + 1 },
		}
	end,
	calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and context.joker_main
			and (context.scoring_hand and #context.scoring_hand == (G.GAME.current_round.hands_played or 0) + 1)
		then
			return {
				xmult = (G.GAME.current_round.hands_played or 0) + 1,
			}
		end
	end,
})
