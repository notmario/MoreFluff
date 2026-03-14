SMODS.Joker {
    key = "lettergem_h",
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
    cost = 4 * 2,
    pos = { x = 8, y = 3 },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card ~= context.scoring_hand[1] then
            return {
                repetitions = 1
            }
        end
    end,
}