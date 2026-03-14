SMODS.Joker {
    key = "lettergem_y",
    atlas = "mf_oldfluff",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    no_collection = true,
    no_shader_on_modbadge = true,
    lettergem_badge = true,
    pools = {
        letterjoker = true,
    },
    rarity = "mf_oldfluff",
    cost = 4 * 2,
    pos = { x = 5, y = 5 },
    config = { extra = { dollars = 10, card_total = 13, cards_scored = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.card_total, card.ability.extra.cards_scored } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.cards_scored = card.ability.extra.cards_scored + 1
            local effects = {}
            while card.ability.extra.cards_scored >= card.ability.extra.card_total do
                card.ability.extra.cards_scored = card.ability.extra.cards_scored - card.ability.extra.card_total
                effects[#effects + 1] = { dollars = card.ability.extra.dollars } 
            end
            return SMODS.merge_effects(effects)
        end
    end,
}