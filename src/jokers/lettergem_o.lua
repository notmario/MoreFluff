SMODS.Joker({
	key = "lettergem_o",
	atlas = "mf_letterjokers",
    display_size = { h = 78 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	no_collection = true,
	lettergem_badge = true,
	pools = {
		letterjoker = true,
	},
	rarity = "mf_letter",
	cost = 1 * 2,
	pos = { x = 5, y = 1 },
	config = { extra = {} },
	attributes = { "mod_chance", },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.fix_probability then
			return {
				numerator = 1,
				denominator = 2,
			}
		end
	end,
})
