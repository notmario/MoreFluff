SMODS.Joker {
    key = "flintandsteel",
    name = "Flint and Steel",
    config = {},
    pos = {x = 3, y = 2},
    atlas = "mf_oldfluff",
    rarity = "mf_oldfluff",
    no_shader_on_modbadge = true,
    no_collection = true,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    pools = { ["Meme"] = true },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return {
            vars = { }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            if context.before then
                local flint = false
                local steel = false

                for i = 1, #context.scoring_hand do
                local c_card = context.scoring_hand[i]
                if SMODS.has_enhancement(c_card, "m_stone") then flint = true end
                if SMODS.has_enhancement(c_card, "m_steel") then steel = true end
                end

                if flint and steel then -- PEAK CINEMA
                    local text,disp_text = G.FUNCS.get_poker_hand_info(context.full_hand)
                    SMODS.upgrade_poker_hands {
                        hands = { text },
                        from = card,
                    }
                end
            end
        end
    end
}