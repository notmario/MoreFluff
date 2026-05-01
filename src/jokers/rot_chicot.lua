SMODS.Joker({
	key = "rot_chicot",
	name = "Chicot!",
	atlas = "mf_jokers",
	config = {
		extra = {
			xblindsize = 0.5,
		}
	},
	pos = { x = 3, y = 10 },
	soul_pos = { x = 3, y = 11 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = {},
	loc_vars = function(self, info_queue, center)
	    return {
	        vars = { center.ability.extra.xblindsize }
	    }
	end,
	calculate = function(self, card, context)
		if context.pre_discard then
			local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text = G.FUNCS.get_poker_hand_info(context.full_hand)
			if non_loc_disp_text == "Two Pair" then
				G.E_MANAGER:add_event(Event({
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								G.GAME.blind:disable()
								play_sound('timpani')
								delay(0.4)
								return true
							end
						}))
						SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
						return true
					end
				}))
				return {
					xblindsize = card.ability.extra.xblindsize
				}
			end
        end
	end,
})
