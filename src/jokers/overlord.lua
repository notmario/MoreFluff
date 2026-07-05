SMODS.Joker({
	key = "overlord",
	name = "Overlord of the Plasmadeck",
	config = {},
	atlas = "mf_jokers",
	pos = { x = 9, y = 15 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "hands", "chips", },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
		if context.initial_scoring_step then
			return {
                balance = true
            }
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		if not card.ability.mf_suspended then
            FLUFF.suspend_card(card, 7)
        end
	end,
})
