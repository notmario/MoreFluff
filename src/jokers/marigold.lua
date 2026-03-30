SMODS.Joker({
	key = "marigold",
	name = "Marigold",
	atlas = "mf_jokers",
	config = {
		extra = {
			retriggers = 2,
		},
	},
	mf_art_credit = "marigold",
	pos = { x = 5, y = 4 },
	soul_pos = { x = 0, y = 5 },
	rarity = 4,
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	enhancement_gate = "m_mf_marigold",
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_marigold

		return {
			vars = { center.ability.extra.retriggers },
		}
	end,
	calculate = function(self, card, context)
		if context.repetition and SMODS.has_enhancement(context.other_card, "m_mf_marigold") then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.extra.retriggers,
				card = card,
			}
		end
	end,
})
