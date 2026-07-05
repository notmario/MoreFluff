SMODS.Joker {
	key = "slaughter_pact",
	name = "Slaughter Pact",
	atlas = "mf_jokers",
	config = {
		extra = {
            cards = 4,
			eblindsize = 0.9,
        },
	},
	pos = { x = 4, y = 15 },

	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { "eblindsize", "exile", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.cards, card.ability.extra.eblindsize },
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
			G.GAME.blind.chips = G.GAME.blind.chips ^ card.ability.extra.eblindsize
			play_sound('timpani')
		end
    end,
}