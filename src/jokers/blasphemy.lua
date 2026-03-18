SMODS.Joker({
	key = "blasphemy",
	name = "Blasphemy",
	atlas = "mf_jokers",
	config = {
		extra = {
			xmult = 4,
			hands_lost = 9999,
		},
		base_cost = 5,
	},
	pos = { x = 7, y = 2 },
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.xmult, center.ability.extra.hands_lost },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			ease_hands_played(-G.GAME.current_round.hands_left, true)
		end
		if context.forcetrigger or (context.cardarea == G.jokers and context.joker_main) then
			return {
				xmult = card.ability.extra.xmult,
			}
		end
	end,
})
