SMODS.Joker({
	key = "gentlemelon",
	name = "Gentlemelon",
	atlas = "mf_jokers",
	config = {
		extra = { odds = 100, purchases = 3 },
	},
	pos = { x = 8, y = 11 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "passive", "food", },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.odds, card.ability.extra.purchases },
		}
	end,
	calculate = function(self, card, context)
		if context.modify_weights then
			for _, c in pairs(context.pool) do
                c.weight = c.weight * (card.ability.extra.odds ^ (#SMODS.find_card(c.key)))
			end
		end
        if context.buying_card and not context.buying_self and (card ~= context.card) and not context.blueprint then
            card.ability.extra.one = 1
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "purchases",
                scalar_value = "one",
                operation = "-",
                no_message = true,
            })
            if card.ability.extra.purchases <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true
                            end,
                        }))
                        return true
                    end,
                }))
                return {
                    message = localize("k_dead_ex"),
                    colour = G.C.RED,
                }
            else
                return {
                    message = ""..card.ability.extra.purchases,
                    colour = G.C.RED,
                }
            end
        end
	end,
})

local sms = SMODS.showman
function SMODS.showman(card_key, ...)
    if next(SMODS.find_card('j_mf_gentlemelon')) then
        return true
    end
    return sms(card_key, ...)
end