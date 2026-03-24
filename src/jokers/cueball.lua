SMODS.Joker {
    key = "cueball",
    name = "Cue Ball",
    atlas = "mf_jokers",
    config = {
        odds = 2
    },
    pos = {x = 5, y = 7},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        local new_numerator, new_denominator = SMODS.get_probability_vars(center, 1, center.ability.odds, 'cueball')
        return {
            vars = { new_numerator, new_denominator }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_no_rank(context.other_card) then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and (SMODS.pseudorandom_probability(card, 'cueball', 1, card.ability.odds, 'cueball')) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {focus = card, message = localize('k_plus_rotarot'), func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                            local card = create_card('Rotarot',G.consumeables, nil, nil, nil, nil, nil, 'cba')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                        return true
                        end)}))
                    end},
                    colour = G.C.SECONDARY_SET.Tarot,
                    card = card
                }
            end
        end
    end
}