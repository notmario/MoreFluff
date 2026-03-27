SMODS.Joker {
    key = "gemstonejoker",
    name = "Gemstone Joker",
    atlas = "mf_jokers",
    config = {
        extra = {dollars_per = 1, gemstone_tally = 0}
    },
    pos = {x = 0, y = 6},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    enhancement_gate = "m_mf_gemstone",
    update = function(self, card, dt)
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.gemstone_tally = 0
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_mf_gemstone") then card.ability.extra.gemstone_tally = card.ability.extra.gemstone_tally+1 end
            end
        else
            card.ability.extra.gemstone_tally = 0
        end
    end,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_gemstone

        return {
            vars = { center.ability.extra.dollars_per, center.ability.extra.dollars_per * center.ability.extra.gemstone_tally }
        }
    end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.gemstone_tally > 0 then return card.ability.extra.dollars_per * card.ability.extra.gemstone_tally end
    end,
    draw = function(self, card, layer)
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        -- card.children.center:draw_shader(
        --   "negative",
        --   nil,
        --   card.ARGS.send_to_shader,
        --   notilt,
        --   card.children.center
        -- )
        card.children.center:draw_shader(
            "voucher",
            nil,
            card.ARGS.send_to_shader,
            notilt,
            card.children.center
        )
    end,
}