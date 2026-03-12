SMODS.Joker {
    key = "boxofhands",
    name = "Box of Hands",

    atlas = "mf_oldfluff",
    rarity = "mf_oldfluff",
    no_shader_on_modbadge = true,
    pos = { x = 2, y = 0 },
    cost = 6,
    config = { extra = { hands = 5 } },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            if G.STATE == G.STATES.SELECTING_HAND then
                ease_hands_played(5, false)
            else
                return {
                    message = localize 'k_nope_ex',
                    colour = G.C.PURPLE,
                }
            end
        end
    end
}