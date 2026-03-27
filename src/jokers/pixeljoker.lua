SMODS.Joker {
    key = "pixeljoker",
    name = "Pixel Joker",
    atlas = "mf_jokers",
    config = {
        extra = {x_mult = 1.5}
    },
    pos = {x = 9, y = 3},
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    display_size = { w = 16, h = 16 },
    pixel_size = { w = 16, h = 16 },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.x_mult }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 or context.other_card:get_id() == 4 or context.other_card:get_id() == 9 then
                return {
                    x_mult = card.ability.extra.x_mult,
                    colour = G.C.RED,
                    card = card
                }
            end
        end
    end
}