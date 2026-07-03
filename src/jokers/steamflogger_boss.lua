SMODS.Joker({
	key = "steamflogger_boss",
	name = "Steamflogger Boss",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	pos = { x = 5, y = 6 },
	cost = 6,
	config = { extra = { chips = 16, } },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "joker_slot", "chips", "joker", "consumable", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chips * (G.jokers and #G.jokers.cards or 0) } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * #G.jokers.cards
            }
        end
		if context.contraption_cranked and context.cranking_card.ability.set == "Wrench" then
			return {
				additional_cranks = 1
			}
		end
	end,
})
