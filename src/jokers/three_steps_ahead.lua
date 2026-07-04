SMODS.Joker {
	key = "three_steps_ahead",
	name = "Three Steps Ahead",

	config = {
		extra = {
            boss_blinds = 0,

            jokers_sold = 0,

            discarded = 0,
            discard_limit = 2,
        },
	},
	atlas = "mf_jokers",
	rarity = 3,
	pos = { x = 7, y = 15 },
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "discard", "boss_blind", "editions", "joker", "generation", },
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.boss_blinds,
                card.ability.extra.jokers_sold,
                card.ability.extra.discarded,
                card.ability.extra.discard_limit,
            }
        }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss and card.ability.extra.boss_blinds < 4 then
			card.ability.extra.boss_blinds = card.ability.extra.boss_blinds + 1
            if card.ability.extra.boss_blinds >= 4 then
                return {
                    message = localize "k_active_ex"
                }
            end
            return {
                message = card.ability.extra.boss_blinds .. "/4"
            }
		end
        if card.ability.extra.boss_blinds >= 4 and context.setting_blind and not context.blueprint and context.blind.boss then
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
		if
			context.selling_card
			and not context.selling_self
			and context.card.ability.set == "Joker"
			and card.ability.extra.jokers_sold < 8
		then
            card.ability.extra.jokers_sold = card.ability.extra.jokers_sold + 1
            if card.ability.extra.jokers_sold >= 8 then
                return {
                    message = localize "k_active_ex"
                }
            end
            return {
                message = card.ability.extra.jokers_sold .. "/8"
            }
        end
        if context.ending_shop and G.jokers.cards[1] and card.ability.extra.jokers_sold >= 8 then
            local has_negative = false
            for _, _card in ipairs(G.jokers.cards) do
                if (_card.edition and _card.edition.negative) then
                    has_negative = true
                    break
                end
            end
            if not has_negative then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card_to_copy, _ = pseudorandom_element(G.jokers.cards, 'vremade_perkeo')
                        local copied_card = SMODS.copy_card(card_to_copy)
                        copied_card:set_edition("e_negative", true)
                        return true
                    end
                }))
                return { message = localize('k_duplicated_ex') }
            end
        end
        if context.discard and card.ability.extra.discarded < 50 then
            card.ability.extra.discarded = card.ability.extra.discarded + 1
            if card.ability.extra.discarded >= 50 then
                SMODS.change_discard_limit(card.ability.extra.discard_limit)
                return {
                    message = localize "k_active_ex"
                }
            end
            return {
                message = card.ability.extra.discarded .. "/50"
            }
        end
	end,
	add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.discarded >= 50 then
            SMODS.change_discard_limit(card.ability.extra.discard_limit)
        end
	end,
	remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.discarded >= 50 then
            SMODS.change_discard_limit(-card.ability.extra.discard_limit)
        end
	end,
}