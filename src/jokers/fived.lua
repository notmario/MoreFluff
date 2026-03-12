SMODS.Joker {
    key = "fived",
    name = "5D Joker with Multiverse Time Travel",

    atlas = "mf_oldfluff",
    rarity = "mf_oldfluff",
    no_collection = true,
    no_shader_on_modbadge = true,
    pos = { x = 9, y = 0 },
    cost = 10,
    config = { extra = { ante_mod = 1, mult = 10, } },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ante_mod, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.after and G.GAME.chips + SMODS.calculate_round_score() > G.GAME.blind.chips * card.ability.extra.mult and context.cardarea == G.jokers then
            ease_ante(-card.ability.extra.ante_mod)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante-card.ability.extra.ante_mod
            SMODS.destroy_cards { card }
            return {
                message = localize "k_timetravel_ex",
                colour = G.C.PURPLE
            }
        end
    end
}