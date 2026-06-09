SMODS.Joker({
	key = "apex_devastator",
	name = "Apex Devastator",
	atlas = "mf_jokers",
	config = {
        extra = {
            mult = 10,
            chips = 10,
        }
    },
	pos = { x = 8, y = 14 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "generation", "economy", "reroll", "chips", "mult", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.mult,
				card.ability.extra.chips,
			},
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
			}
		end
        if context.buying_self then
            FLUFF.cascade(10, 4)
        end
	end,
})
