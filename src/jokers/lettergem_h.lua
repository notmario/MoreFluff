SMODS.Joker({
	key = "lettergem_h",
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
	cost = 4 * 2,
	pos = { x = 7, y = 0 },
	config = { extra = {} },
	attributes = { "retrigger", },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and context.other_card ~= context.scoring_hand[1] then
			return {
				repetitions = 1,
			}
		end
	end,
})
