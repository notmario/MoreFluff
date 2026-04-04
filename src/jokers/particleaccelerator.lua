SMODS.Joker({
	key = "particleaccelerator",
	name = "particleaccelerator",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 7, y = 0 },
	cost = 7,
	config = { extra = { xmult = 1, xmult_scale = 1 } },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xmult", "scaling", "reset", "hand_type", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_scale } }
	end,
	calculate = function(self, card, context)
		if context.after and context.full_hand ~= nil and context.cardarea == G.jokers then
			if #context.full_hand == 1 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "xmult_scale",
					message_key = "a_xmult",
					message_colour = G.C.RED,
				})
			else
				card.ability.extra.x_mult = 1
				return {
					message = localize("k_reset_ex"),
				}
			end
		end
		if context.cardarea == G.jokers and context.joker_main then
			if #context.full_hand ~= 1 then
				return {
					xmult = card.ability.extra.x_mult,
				}
			end
		end
	end,
})
