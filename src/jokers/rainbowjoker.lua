SMODS.Joker {
    key = "rainbowjoker",
    name = "Rainbow Joker",
    atlas = "mf_jokers",
    config = {
        extra = 1.5
    },
    pos = {x = 5, y = 3},
    rarity = 3,
    cost = 6,
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
        if context.other_consumeable and FLUFF.is_colour(context.other_consumeable) then
            G.E_MANAGER:add_event(Event({
                func = function()
                context.other_consumeable:juice_up(0.5, 0.5)
                return true
                end
            })) 
            return {
                xmult = card.ability.extra
            }
        end
    end
}