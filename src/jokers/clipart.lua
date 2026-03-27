SMODS.Joker {
    key = "clipart",
    name = "Clipart Joker",
    atlas = "mf_jokers",
    config = {},
    pos = {x = 4, y = 3},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                G.E_MANAGER:add_event(Event({
                    func = function() 
                    local card = create_card('Colour',G.consumeables, nil, nil, nil, nil, nil, 'clipart')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                    return true
                    end}))   
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_colour'), colour = G.C.PURPLE})                       
                return true
                end)}))
        end
    end
}