SMODS.Joker {
    key = "bigshot",
    name = "Big Shot",

    atlas = "mf_oldfluff",
    rarity = "mf_oldfluff",
    no_collection = true,
    no_shader_on_modbadge = true,
    pos = { x = 6, y = 1 },
    cost = 7,
    config = { extra = { money = 1 } },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.money }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 or context.other_card:get_id() == 9 or context.other_card:get_id() == 7 then
                return {
                    dollars = 1
                }
            end
        elseif context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 9 then
                return {
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
}