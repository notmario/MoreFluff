SMODS.Joker {
	key = "lettergem_s",
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
	pos = { x = 9, y = 4 },
	config = { extra = { chips = 6, mult = 7 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if
			context.individual
			and not context.end_of_round
			and (context.cardarea == G.play or context.cardarea == G.hand)
			and (context.other_card:get_id() == 6 or context.other_card:get_id() == 7)
		then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
			}
		end
	end,
}
