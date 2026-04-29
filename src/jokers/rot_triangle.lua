SMODS.Joker({
	key = "rot_triangle",
	name = "Triangle!",
	atlas = "mf_jokers",
	config = {
		extra = {
			first_proc = true,
		}
	},
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
	attributes = { "hand_type", },
	loc_vars = function(self, info_queue, center)
	    return {
	        vars = { center.ability.extra.first_proc and (localize "k_active") or (localize "k_inactive") }
	    }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and not card.getting_sliced then
			if not card.ability.extra.first_proc then
				card.ability.extra.first_proc = true
				return {
					message = localize "k_reset",
					colour = G.C.PURPLE,
				}
			end
		end
    end,
})

local ssc = SMODS.scale_card
function SMODS.scale_card(card, ...)
    if card.ability and card.ability.set == "Joker" and next(SMODS.find_card("j_mf_rot_triangle")) then
        for _, other_card in pairs(SMODS.find_card("j_mf_rot_triangle")) do
			if other_card.ability.extra.first_proc then
				other_card.ability.extra.first_proc = false
				-- lol ?
				SMODS.smart_level_up_hand(card, "Three of a Kind", false, 3, nil)
			else
            	SMODS.smart_level_up_hand(card, "Three of a Kind", false, 1, nil)
			end
        end
        return nil
    end
    return ssc(card, ...)
end