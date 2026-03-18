SMODS.Joker({
	key = "oopsallfives",
	name = "Token",
	atlas = "mf_jokers",
	config = {
		extra = 1,
	},
	pos = { x = 4, y = 8 },
	rarity = "mf_token",
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	no_collection = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra },
		}
	end,
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
			local new_denominator = context.denominator
			if context.denominator >= 1 and context.denominator < 2 then
				new_denominator = 1
			elseif context.denominator >= 2 then
				new_denominator = new_denominator - 1
			end
			return {
				denominator = new_denominator,
			}
		end
	end,
})
