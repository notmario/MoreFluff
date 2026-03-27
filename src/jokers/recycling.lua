SMODS.Joker {
    key = "recycling",
    name = "Recycling",
    atlas = "mf_jokers",
    config = {},
    pos = {x = 2, y = 2},
    rarity = 2,
    cost = 5,
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
        if context.skipping_booster and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local card_type = pseudorandom_element({"Tarot", "Planet"}, pseudoseed('recycling_type'))
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, nil, 'sup')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                return true
                end)}))
            if card_type == "Tarot" then
                return {
                message = localize('k_plus_tarot'),
                colour = G.C.SECONDARY_SET.Tarot,
                card = card
                }
            else
                return {
                message = localize('k_plus_planet'),
                colour = G.C.SECONDARY_SET.Planet,
                card = card
                }
            end
        end
    end
}