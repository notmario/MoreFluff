SMODS.Joker {
	key = "pact_of_negation",
	name = "Pact of Negation",
	atlas = "mf_jokers",
	config = {
		extra = {
            cards = 7,
        },
	},
	pos = { x = 1, y = 15 },

	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { "boss_blind", "exile", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.cards },
		}
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if not card.ability.mf_exile_until_id then card.ability.mf_exile_until_id = math.random(1000000000000) end
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and context.blind.boss and not card.getting_sliced then
			for i = 1, card.ability.extra.cards do
				FLUFF.draw_to_exile(false, i / card.ability.extra.cards, nil, function(other_card)
                    other_card.ability.mf_pact_id = card.ability.mf_exile_until_id
                end)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            play_sound('timpani')
                            delay(0.4)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                    return true
                end
            }))
            return nil, true -- This is for Joker retrigger purposes
		end
    end,
}