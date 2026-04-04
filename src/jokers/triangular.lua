SMODS.Joker({
	key = "triangular",
	name = "Triangular Joker",

	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_collection = true,
	no_shader_on_modbadge = true,
	pos = { x = 1, y = 0 },
	cost = 7,
	config = { extra = { chips = 1, chip_mod = 2, chip_mod_mod = 1 } },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "chips", "scaling", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.chip_mod_mod } }
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint and #context.full_hand == 3 then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "chip_mod",
				message_key = "a_chips",
				message_colour = G.C.CHIPS,
			})
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chip_mod",
				scalar_value = "chip_mod_mod",
				message_key = "a_plus_pluschips",
				message_colour = G.C.CHIPS,
			})
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end,
})
