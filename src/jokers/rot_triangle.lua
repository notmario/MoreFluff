SMODS.Joker({
	key = "rot_triangle",
	name = "Triangle!",
	atlas = "mf_jokers",
	config = {},
	pos = { x = 5, y = 10 },
	soul_pos = { x = 9, y = 5 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "enhancements" },
	loc_vars = function(self, info_queue, center)
	    return {
	        vars = { "hand_type", }
	    }
	end,
	calculate = function(self, card, context)
    end,
})

local ssc = SMODS.scale_card
function SMODS.scale_card(card, ...)
    if next(SMODS.find_card("j_mf_rot_triangle")) then
        for _, card in pairs(SMODS.find_card("j_mf_rot_triangle")) do
            SMODS.smart_level_up_hand(card, "Three of a Kind", false, 1, nil)
        end
        return nil
    end
    return ssc(card, ...)
end