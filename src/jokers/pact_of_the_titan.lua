SMODS.Joker {
	key = "pact_of_the_titan",
	name = "Pact of the Titan",
	atlas = "mf_jokers",
	config = {
		extra = {
            cards = 2,
			chips = 20,
			mult = 20,
        },
	},
	pos = { x = 3, y = 15 },

	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.cards, card.ability.extra.chips, card.ability.extra.mult },
		}
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if not card.ability.mf_exile_until_id then card.ability.mf_exile_until_id = math.random(1000000000000) end
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not card.getting_sliced then
			for i = 1, card.ability.extra.cards do
				FLUFF.draw_to_exile(false, i / card.ability.extra.cards, nil, function(other_card)
                    other_card.ability.mf_pact_id = card.ability.mf_exile_until_id
                end)
            end
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
			}
		end
    end,
}