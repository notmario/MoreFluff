SMODS.Joker({
	key = "doubledscale",
	name = "Doubled Scale",
	atlas = "mf_jokers",
	mf_art_credit = "LFMoth",
	config = {},
	pos = { x = 6, y = 9 },
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "passive", },
	loc_vars = function(self, info_queue, center)
		return {}
	end,
	calculate = function(self, card, context) end,
	calc_scaling = function(self, _self, card, initial, scalar_value, args)
		if args.operation == "X" then
			return {
				override_scalar_value = { value = scalar_value * scalar_value },
			}
		else
			return {
				override_scalar_value = { value = scalar_value * 2 },
			}
		end
	end,
})
