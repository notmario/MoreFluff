SMODS.Joker({
	key = "lettergem_o",
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
	cost = 1 * 2,
	pos = { x = 5, y = 4 },
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
