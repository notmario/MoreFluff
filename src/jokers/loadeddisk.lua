SMODS.Joker {
    key = "loadeddisk",
    name = "Loaded Disk",
    atlas = "mf_jokers",
    config = { },
    pos = {x = 6, y = 3},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_mf_pink
        info_queue[#info_queue + 1] = G.P_CENTERS.c_mf_yellow
        return {
            vars = { }
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                    func = function() 
                        local n_card = create_card('Colour',G.consumeables, nil, nil, nil, nil, 'c_mf_pink', nil)
                        n_card:add_to_deck()
                        G.consumeables:emplace(n_card)
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end}))                   
                    return true
                end)}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_colour'), colour = G.C.PURPLE})
            end
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                    func = function() 
                        local n_card = create_card('Colour',G.consumeables, nil, nil, nil, nil, 'c_mf_yellow', nil)
                        n_card:add_to_deck()
                        G.consumeables:emplace(n_card)
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end}))                   
                    return true
                end)}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_colour'), colour = G.C.PURPLE})
            end
        end
    end
}