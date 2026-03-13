SMODS.Joker {
    key = "mashupalbum",
    name = "Mashup Album",
    config = {
        extra = {
            mult = 4,
            chips = 15,
            mult_gain = 4,
            chips_gain = 15,
        }
    },
    pos = {x = 1, y = 2},
    atlas = "mf_oldfluff",
    rarity = "mf_oldfluff",
    no_shader_on_modbadge = true,
    no_collection = true,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.mult, center.ability.extra.chips, center.ability.extra.mult_gain, center.ability.extra.chips_gain }
        }
    end,
    calculate = function(self, card, context)
        if not context.repetition and not context.other_joker and context.cardarea == G.jokers and context.before and next(context.poker_hands['Flush']) then
            local _, cards = next(context.poker_hands['Flush'])
            local h_card = cards[1]

            if h_card:is_suit("Hearts") or h_card:is_suit("Diamonds") then
                -- card.ability.extra.mult = card.ability.extra.mult + 4
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_gain"
                })
            else
                -- card.ability.extra.chips = card.ability.extra.chips + 15
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_gain"
                })
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end
}