SMODS.Joker({
	key = "old_rot_triangle",
	name = "Triangle!?",
	config = {
		extra = {
			first_proc = true,
			last_ability = 3,
			last_ability_per = 7,
		}
	},
	pos = { x = 2, y = 6 },
	-- soul_pos = { x = 9, y = 5 },
	mf_rotate_by = math.pi / 4,
	weight = 0.1,
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	no_collection = true,
	attributes = { "hand_type", "hand_level", },
	loc_vars = function(self, info_queue, center)
	    return {
	        vars = { center.ability.extra.first_proc and (localize "k_active") or (localize "k_inactive"), center.ability.extra.last_ability, center.ability.extra.last_ability_per }
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
    if card.ability and card.ability.set == "Joker" and next(SMODS.find_card("j_mf_old_rot_triangle")) then
        for _, other_card in pairs(SMODS.find_card("j_mf_old_rot_triangle")) do
			G.E_MANAGER:add_event(Event({
				func = function()
					other_card:juice_up()
					return true
				end
			}))
			if other_card.ability.extra.first_proc then
				other_card.ability.extra.first_proc = false
				-- lol ?
				local levels = other_card.ability.extra.last_ability
				levels = levels + math.floor(G.GAME.hands["Three of a Kind"].level / other_card.ability.extra.last_ability_per)
				SMODS.smart_level_up_hand(card, "Three of a Kind", false, levels, nil)
			else
            	SMODS.smart_level_up_hand(card, "Three of a Kind", false, 1, nil)
			end
        end
        return nil
    end
    return ssc(card, ...)
end