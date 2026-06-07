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
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	attributes = { },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.cards },
		}
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.ability.mf_my_cool_id = math.random(1000000000000)
	end,
	remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            local return_to_deck = {}
            for _, other_card in ipairs(G.mf_exile.cards) do
                if other_card.ability.mf_pact_id == card.ability.mf_my_cool_id then
                    return_to_deck[#return_to_deck + 1] = other_card
                    other_card.ability.mf_pact_id = nil
                end
            end
            for i, card in ipairs(return_to_deck) do
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.1,
                    func = function()
                        card.area:remove_card(card)
                        G.deck:emplace(card)
                        -- card.T.w = card.T.w / FLUFF.exile_scale
                        -- card.T.h = card.T.h / FLUFF.exile_scale
                        card.T.scale = card.T.scale / FLUFF.exile_scale
                        play_sound('card1', 0.65 - (i / #return_to_deck)*0.2, 0.6)
                        return true
                    end
                }))
            end
        end
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and context.blind.boss and not card.getting_sliced then
			for i = 1, card.ability.extra.cards do
				FLUFF.draw_to_exile(false, i / card.ability.extra.cards, nil, function(other_card)
                    other_card.ability.mf_pact_id = card.ability.mf_my_cool_id
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