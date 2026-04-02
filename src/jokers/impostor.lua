SMODS.Joker({
	key = "impostor",
	name = "Impostor",
	config = {
		extra = { x_mult = 3, check = 0 },
	},
	pos = { x = 9, y = 2 },
	atlas = "mf_oldfluff",
	rarity = "mf_oldfluff",
	no_shader_on_modbadge = true,
	no_collection = true,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	attributes = { "xmult", "suit", "hearts", "diamonds", "space", "hands", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra.x_mult },
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			local red_suits = 0
			for k, v in ipairs(context.full_hand) do
				if v:is_suit("Hearts", nil, true) or v:is_suit("Diamonds", nil, true) then
					red_suits = red_suits + 1
				end
			end
			card.ability.extra.check = red_suits
		end
		if context.cardarea == G.jokers and context.joker_main then
			if card.ability.extra.check == 1 then
				return {
					xmult = card.ability.extra.x_mult,
				}
			end
		end
	end,
})
