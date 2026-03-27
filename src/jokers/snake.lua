SMODS.Joker {
    key = "snake",
    name = "Snake",
    atlas = "mf_jokers",
    config = {
        extra = 3
    },
    pos = {x = 3, y = 7},
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra }
        }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger then
            for i=1, card.ability.extra do
                draw_card(G.deck,G.hand, i*100/card.ability.extra,'up', true)
            end
        end
    end
}
