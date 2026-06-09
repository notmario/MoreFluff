SMODS.Joker {
	key = "saturnburger",
	name = "Saturn Burger",
	atlas = "mf_jokers",
	config = {
		extra = {
            remaining = 4,
        },
	},
	pos = { x = 1, y = 13 },
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	attributes = { "food", "hand_type", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.remaining },
		}
	end,
	calculate = function(self, card, context)
        if context.pre_discard and not context.hook and #context.full_hand >= 4 then
            local text, disp_text = G.FUNCS.get_poker_hand_info(context.full_hand)
            card_eval_status_text(
                context.blueprint_card or card,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_upgrade_ex") }
            )
            update_hand_text(
                { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
                {
                    handname = localize(text, "poker_hands"),
                    chips = G.GAME.hands[text].chips,
                    mult = G.GAME.hands[text].mult,
                    level = G.GAME.hands[text].level,
                }
            )
            level_up_hand(context.blueprint_card or card, text, nil, 1)
            if not context.blueprint and not context.retrigger_joker then
                card.ability.extra.one = 1
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "remaining",
                    scalar_value = "one",
                    operation = "-",
                })
                if card.ability.extra.remaining <= 0 then
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
                        message = localize("k_eaten_ex"),
                        colour = G.C.FILTER,
                    }
                end
            end
            return nil, true
        end
	end,
}

local smods_four_fingers_ref = SMODS.four_fingers
function SMODS.four_fingers(hand_type)
	local val = smods_four_fingers_ref(hand_type)
	if next(SMODS.find_card("j_mf_saturnburger")) and hand_type == "straight" then
		return math.max(1, val - 2)
	end
	return val
end
