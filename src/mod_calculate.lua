FLUFF.calculate = function(self, context)
    local res = nil

    if context.end_of_round and context.main_eval then
        colour_end_of_round_effects()
    end

    if context.open_booster and G.GAME.modifiers.mf_bonus_scrapped then
        if context.booster and context.booster.kind == "Buffoon" then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = function()
                    SMODS.add_card {
                        set = "Joker",
                        area = G.pack_cards,
                        rarity = "mf_oldfluff",
                    }
                    return true
                end
            }))
            res = SMODS.merge_effects({
                message = localize "k_added_ex",
                colour = HEX "000000",
            }, res)
        end
    end

    if res then return res end
end