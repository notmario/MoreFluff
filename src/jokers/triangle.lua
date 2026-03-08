SMODS.Joker {
    key = "triangle",
    name = "Triangle",
    atlas = "mf_jokers",
    config = {
        extra = {
            x_mult = 3,
        }
    },
    pos = {x = 9, y = 4},
    soul_pos = {x = 9, y = 5},
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pronouns = "she_they",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.x_mult }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.scoring_name == "Three of a Kind" then
            return {
                x_mult = card.ability.extra.x_mult,
                colour = G.C.RED,
                card = card
            }
        end
        if context.forcetrigger then
            return {
                xmult = card.ability.extra.x_mult,
            }
        end
    end,
}