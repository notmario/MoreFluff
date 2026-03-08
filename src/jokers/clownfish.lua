SMODS.Joker {
    key = "clownfish",
    name = "Clownfish",
    atlas = "mf_jokers",
    config = {
        extra = {chips=15, mult=4}
    },
    pos = {x = 0, y = 3},
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.chips, center.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.ability.name ~= "Default Base" then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                card = card
            }
        end
        if context.forcetrigger then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end,
}