SMODS.Joker({
	key = "aheartofcold",
	name = "A Heart of Cold",
	atlas = "mf_jokers",
	config = {
		extra = {
			polychrome_mod = 66,
            bosses_left = 2,
		},
	},
	pos = { x = 8, y = 9 },
	rarity = 3,
	cost = 9,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "passive", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.polychrome_mod, center.ability.extra.bosses_left },
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
			card.ability.extra.bosses_left = card.ability.extra.bosses_left - 1
			if
				card.ability.extra.bosses_left <= 0
			then
                card:set_ability(G.P_CENTERS["j_mf_deadheatpulse"])
                card:juice_up()
                G.jokers:unhighlight_all()
                return {
                    message = localize "k_transformed_ex"
                }
			end
			return {
				message = ""..card.ability.extra.bosses_left
			}
		end
	end,
})
