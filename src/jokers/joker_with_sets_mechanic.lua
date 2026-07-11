SMODS.Joker({
	key = "joker_with_sets_mechanic",
	name = "Joker With Set's Mechanic",
	atlas = "mf_jokers",
	config = {
        extra = {
            mult = 4,
            poisonous = 8,
        }
    },
	pos = { x = 6, y = 16 },
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "score", "mult", },
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.poisonous,

                colours = {
                    darken(G.C.GREEN, 0.2)
                }
            }
        }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
		if context.post_trigger and card == context.other_card and G.GAME.blind and G.GAME.blind.in_blind then
			return FLUFF.poisonous(context.other_ret.jokers, card.ability.extra.poisonous)
		end
	end,
})
