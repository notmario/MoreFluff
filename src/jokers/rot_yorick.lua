SMODS.Joker {
    key = "rot_yorick",
    name = "Yorick!",
    atlas = "mf_jokers",
    config = {},
    pos = {x = 2, y = 10},
    soul_pos = {x = 2, y = 11},
    mf_rotate_by = math.pi/4,
    rarity = "mf_rot_legendary",
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    -- loc_vars = function(self, info_queue, center)
    --     return {
    --         vars = { }
    --     }
    -- end,
    calculate = function(self, card, context)
    end
}
