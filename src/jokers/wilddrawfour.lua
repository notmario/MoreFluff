SMODS.Joker({
	key = "wilddrawfour",
	name = "Wild Draw Four",
	atlas = "mf_oldfluff",
	config = {
		h_size = 0,
		extra = 4,
	},
	pos = { x = 9, y = 1 },
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "hand_size", "enhancements", "reset", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.h_size, center.ability.extra },
		}
	end,
	calculate = function(self, card, context)
		if
			(context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_wild"))
			and not context.blueprint
		then
			card.ability.h_size = card.ability.h_size + card.ability.extra
			G.hand:change_size(card.ability.extra)

			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.MONEY,
			}
		end
		if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
			G.hand:change_size(-card.ability.h_size)
			card.ability.h_size = 0
		end
	end,
})
