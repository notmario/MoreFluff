SMODS.Joker {
    key = "lettergem_l",
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
    cost = 1 * 2,
    pos = { x = 2, y = 4 },
    config = { extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.check_enhancement and #G.play.cards > 0 then
            local _, _, _, scoring_hand = G.FUNCS.get_poker_hand_info(G.play.cards)
            if context.other_card == scoring_hand[1] then
                return {
                    m_lucky = true,
                }
            end
        end
        if context.mod_probability and #G.play.cards > 0 then
            local _, _, _, scoring_hand = G.FUNCS.get_poker_hand_info(G.play.cards)
            if context.trigger_obj == scoring_hand[1] then
                return {
                    numerator = context.numerator * card.ability.extra.odds,
                    denominator = context.denominator
                }
            end
        end
    end,
}