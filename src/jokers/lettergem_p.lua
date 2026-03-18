SMODS.Joker({
	key = "lettergem_p",
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
	cost = 3 * 2,
	pos = { x = 6, y = 4 },
	config = { extra = { per_ante = 0.9 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.per_ante, card.ability.extra.per_ante ^ G.GAME.round_resets.ante } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind and not card.getting_sliced then
			local amount = G.GAME.blind.chips * (card.ability.extra.per_ante ^ G.GAME.round_resets.ante)
			amount = amount - amount % (10 ^ math.floor(math.log10(amount) - 1))
			G.GAME.blind.chips = amount
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			return {
				message = localize("k_reduced_ex"),
				colour = G.C.PURPLE,
			}
		end
	end,
})
