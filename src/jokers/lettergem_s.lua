SMODS.Joker({
	key = "lettergem_s",
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
	pos = { x = 0, y = 2 },
	config = { extra = { chips = 6, mult = 7 } },
	attributes = { "chips", "mult", "rank", "six", "seven", },
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
})
