SMODS.Joker {
	key = "triangle",
	name = "Triangle",
	atlas = "mf_jokers",
	config = {
		extra = {
			scaling_mod = 1,
			scaling_mod_mod = 0.5,
		},
	},
	pos = { x = 9, y = 4 },
	soul_pos = { x = 9, y = 5 },
	rarity = 4,
	cost = 20,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pronouns = "she_they",
	demicoloncompat = false,
	loc_vars = function(self, info_queue, center)
		local has_other_copy = #SMODS.find_card "j_mf_triangle" >= 2
		return {
			key = has_other_copy and "j_mf_triangle_lame",
			vars = { center.ability.extra.scaling_mod, center.ability.extra.scaling_mod_mod },
		}
	end,
	calculate = function(self, card, context)
		if context.before and context.scoring_name == "Three of a Kind" and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "scaling_mod",
				scalar_value = "scaling_mod_mod",
			})
		end
	end,
	calc_scaling = function(_self, self, card, initial, scalar_value, args)
		if card.config.center.key == "j_mf_triangle" then
			return nil
		end
		if args.operation == "X" then
			return {
				override_scalar_value = { value = scalar_value ^ self.ability.extra.scaling_mod },
			}
		else
			return {
				override_scalar_value = { value = scalar_value * self.ability.extra.scaling_mod },
			}
		end
	end,
}
