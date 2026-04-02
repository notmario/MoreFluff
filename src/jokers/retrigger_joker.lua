SMODS.Joker({
	key = "retrigger_joker",
	name = "Retrigger Joker",
	atlas = "mf_jokers",
	pos = { x = 5, y = 11 },
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	attributes = { "retrigger", "joker", },
	loc_vars = function(self, info_queue, center)
		return {
			vars = {},
		}
	end,
    calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
			if FLUFF.has_attribute(context.other_card, "retrigger") then
				return {
					message = localize("k_again_ex"),
					repetitions = 1,
					card = card,
				}
			end
		end
		if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[5] then
			return {
				repetitions = 1,
			}
		end
    end,
})
