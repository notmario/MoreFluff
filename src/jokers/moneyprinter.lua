SMODS.Joker {
    key = "moneyprinter",
    name = "Money Printer",

    atlas = "mf_oldfluff",
    rarity = "mf_oldfluff",
    no_collection = true,
    no_shader_on_modbadge = true,
    pos = { x = 5, y = 0 },
    cost = 5,
    config = { extra = { dollars_per = 2 } },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars_per } }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint and context.full_hand ~= nil and context.cardarea == G.jokers then
            local total_money = 0
            local values = G.GAME.dollars..""
            for k, v in ipairs(context.full_hand) do
                if not v:is_face() and string.match(values, v.base.nominal % 10 .. "") then
                    total_money = total_money + card.ability.extra.dollars_per
                end
            end
            if total_money > 0 then
                return {
                    dollars = total_money
                }
            end
        end
    end
}