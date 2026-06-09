SMODS.Joker({
	key = "lettergem_a",
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
	pos = { x = 0, y = 0 },
	config = { extra = { mult = 2 } },
	attributes = { "mult", "rank", "ace", "retrigger", },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 then
			return {
				mult = card.ability.extra.mult,
			}
		end
		if context.repetition and context.cardarea == G.play and context.other_card:get_id() == 14 then
			return {
				repetitions = 1,
			}
		end
	end,
})
