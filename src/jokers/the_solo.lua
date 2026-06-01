SMODS.Joker({
	key = "the_solo",
	name = "The Solo",
	atlas = "mf_jokers",
	config = {
		extra = { x_mult = 1, x_mult_gain = 0.1 },
	},
	pos = { x = 8, y = 0 },
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "xmult", "scaling", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.x_mult, center.ability.extra.x_mult_gain },
		}
	end,
	calculate = function(self, card, context)
		if context.before and context.full_hand ~= nil and context.cardarea == G.jokers and not context.blueprint then
			if #context.full_hand == 1 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "x_mult_gain",
					message_key = "a_xmult",
				})
			end
		end
		if context.cardarea == G.jokers and context.joker_main then
			return {
				xmult = card.ability.extra.x_mult,
			}
		end
	end,
})
