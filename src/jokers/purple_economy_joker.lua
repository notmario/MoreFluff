SMODS.Joker {
	key = "purple_economy_joker",
	name = "Purple Economy Joker",

	atlas = "mf_purple",
	rarity = "mf_oldfluff",
	no_collection = true,
	cost = 8,
	pos = { x = 2, y = 0 },
	config = { extra = { dollars = 2 } },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "economy", "booster", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
        if context.mf_deck_shuffled then
            return { dollars = card.ability.extra.dollars }
        end
	end,
}