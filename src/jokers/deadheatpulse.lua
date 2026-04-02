SMODS.Joker({
	key = "deadheatpulse",
	name = "This Heat, an Evil Heat",
	atlas = "mf_jokers",
	config = {
		extra = {
            cards_total = 25,
            current_cards = 25,
		},
	},
	pos = { x = 7, y = 10 },
	rarity = 3,
	cost = 9,
    in_pool = function(self, args)
        return false
    end,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	no_collection = true,
	attributes = { "retrigger", "joker", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.cards_total, center.ability.extra.current_cards },
		}
	end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.current_cards = card.ability.extra.cards_total
            return {
                colour = G.C.RED,
                message = localize "k_reset"
            }
        end
        if context.drawing_cards and G.GAME.blind then
            local cards_drawn = math.min(context.amount, card.ability.extra.current_cards)
            card.ability.extra.current_cards = card.ability.extra.current_cards - cards_drawn
            return {
                cards_to_draw = cards_drawn
            }
        end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
			if context.other_card.edition and context.other_card.edition.polychrome then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			end
		end
		if context.repetition and context.other_card.edition and context.other_card.edition.polychrome then
			return {
				repetitions = 1,
			}
		end
    end,
})
