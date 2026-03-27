SMODS.Joker {
    key = "teacup",
    name = "Teacup",
    atlas = "mf_jokers",
    config = {
        extra = 5
    },
    pos = {x = 6, y = 1},
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    pools = { ["Food"] = true },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            if context.before then
                local text,disp_text = G.FUNCS.get_poker_hand_info(context.full_hand)
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
                level_up_hand(context.blueprint_card or card, text, nil, 1)
                if not context.blueprint and not context.retrigger_joker then
                    if card.ability.extra - 1 <= 0 then 
                        G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true; end})) 
                            return true
                        end
                        })) 
                        return {
                            message = localize('k_drank_ex'),
                            colour = G.C.FILTER
                        }
                    else
                        card.ability.extra = card.ability.extra - 1
                        return {
                            message = card.ability.extra..'',
                            colour = G.C.FILTER
                        }
                    end
                end
            end
        end
    end
}