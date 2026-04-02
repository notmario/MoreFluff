SMODS.Joker({
	key = "lettergem_k",
	atlas = "mf_oldfluff",
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	no_shader_on_modbadge = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_oldfluff",
	cost = 5 * 2,
	pos = { x = 1, y = 4 },
	config = { extra = { odds = 500 } },
	attributes = { "generation", "joker", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			local other_card = SMODS.add_card({
				set = "Joker",
				key = "j_cavendish",
				edition = "e_negative",
			})
			other_card.ability.extra.odds = math.floor(other_card.ability.extra.odds / card.ability.extra.odds)
			return {
				message = localize("k_plus_joker"),
				colour = G.C.BLUE,
			}
		end
	end,
})
