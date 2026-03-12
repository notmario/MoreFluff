SMODS.Joker {
    key = "brainrot",
    name = "Brainrot",

    atlas = "mf_oldfluff",
    rarity = "mf_oldfluff",
    no_collection = true,
    no_shader_on_modbadge = true,
    pos = { x = 0, y = 0 },
    cost = 6,
    config = { extra = { chips = 0, scale_by = 0, scale_factor = 5, } },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.scale_factor } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            if G.jokers.cards[1] and not SMODS.is_eternal(G.jokers.cards[1], card) and not G.jokers.cards[1].getting_sliced then
                local sliced_card = G.jokers.cards[1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        -- See note about SMODS Scaling Manipulation on the wiki
                        card.ability.extra.scale_by = sliced_card.sell_cost * 5
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "chips",
                            scalar_value = "scale_by",
                            message_key = 'a_chips',
                            message_colour = G.C.CHIPS
                        })
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}