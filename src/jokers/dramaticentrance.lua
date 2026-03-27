SMODS.Joker({
	key = "dramaticentrance",
	name = "Dramatic Entrance",
	atlas = "mf_jokers",
	config = {
		extra = { chips = 150 },
		base_cost = 6,
	},
	pos = { x = 3, y = 2 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.chips },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and G.GAME.current_round.hands_played == 0 then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end,
})
