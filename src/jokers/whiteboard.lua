SMODS.Joker {
    key = "whiteboard",
    name = "Whiteboard",

    atlas = "mf_oldfluff",
    rarity = "mf_oldfluff",
    no_collection = true,
    no_shader_on_modbadge = true,
    pos = { x = 0, y = 1 },
    cost = 6,
    config = { extra = { xmult_per = 2, starting = 3, } },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.xmult_per, center.ability.extra.starting }
        }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger or (context.cardarea == G.jokers and context.joker_main) then
            if #G.hand.cards < card.ability.extra.starting then
                local cards_below = math.max(0, card.ability.extra.starting - #G.hand.cards)
                return {
                    xmult = math.pow(card.ability.extra.xmult_per, cards_below),
                }
            end
        end
    end
}