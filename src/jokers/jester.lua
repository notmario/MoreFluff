SMODS.Joker({
	key = "jester",
	name = "Jester",
	atlas = "mf_jokers",
	config = {
		extra = { chips = 40 },
	},
	pos = { x = 3, y = 0 },
	rarity = 1,
	cost = 2,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.chips },
		}
	end,
	calculate = function(self, card, context)
		if context.forcetrigger or (context.cardarea == G.jokers and context.joker_main) then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end,
})
