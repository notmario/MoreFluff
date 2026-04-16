SMODS.Joker({
	key = "rot_marigold",
	name = "Marigold!",
	atlas = "mf_jokers",
	config = {},
	pos = { x = 6, y = 10 },
	soul_pos = { x = 0, y = 5 },
	mf_rotate_by = math.pi / 4,
	rarity = "mf_rot_legendary",
	mf_art_credit = "marigold",
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	enhancement_gate = "m_mf_marigold",
	attributes = { "enhancements" },
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_marigold
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
	    return {
	        vars = { }
	    }
	end,
	calculate = function(self, card, context)
		if context.check_enhancement then
			if context.other_card.config.center.key == "m_mf_marigold" then
				return {
					m_gold = true,
					m_steel = true,
					m_glass = true,
				}
			end
		end
    end,
})
