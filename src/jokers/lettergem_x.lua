SMODS.Joker({
	key = "lettergem_x",
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
	cost = 8 * 2,
	pos = { x = 4, y = 5 },
	config = { extra = { current_increase = 0, scale_increase = 0.02 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.current_increase, card.ability.extra.scale_increase } }
	end,
	calculate = function(self, card, context) end,
})

local scalcieff = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	if key == "x_mult" or key == "xmult" or key == "Xmult" or key == "x_mult_mod" or key == "Xmult_mod" then
		local bonus = 0
		for _, card in ipairs(SMODS.find_card("j_mf_lettergem_x")) do
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "current_increase",
				scalar_value = "scale_increase",
			})
			bonus = bonus + card.ability.extra.current_increase
		end
		amount = amount + bonus
	end
	return scalcieff(effect, scored_card, key, amount, from_edition)
end
