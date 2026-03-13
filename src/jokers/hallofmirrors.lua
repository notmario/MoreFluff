SMODS.Joker {
    key = "hallofmirrors",
    name = "Hall of Mirrors",
    config = {
        h_size = 0,
        extra = 3,
    },
    pos = {x = 7, y = 2},
    atlas = "mf_oldfluff",
    rarity = "mf_oldfluff",
    no_shader_on_modbadge = true,
    no_collection = true,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.h_size, center.ability.extra }
        }
    end,
    calculate = function(self, card, context)
        if context.forcetrigger or (context.individual and context.cardarea == G.play and context.other_card:get_id() == 6 and not context.blueprint) then
            card.ability.h_size = card.ability.h_size + card.ability.extra
            G.hand:change_size(card.ability.extra)
            
            return {
                message = localize('k_upgrade_ex'),
                card = card
            }
        end
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            G.hand:change_size(-card.ability.h_size)
            card.ability.h_size = 0
        end
    end
}