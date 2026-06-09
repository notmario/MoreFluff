SMODS.Joker({
	key = "lettergem_t",
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
	pos = { x = 1, y = 2 },
	config = { extra = {} },
	attributes = { "enhancements", },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	calculate = function(self, card, context)
		if context.hand_drawn then
			local extra_cards = 0
			for _, other_card in pairs(context.hand_drawn) do
				if SMODS.has_enhancement(other_card, "m_wild") then
					extra_cards = extra_cards + 1
				end
			end
			if extra_cards > 0 then
				SMODS.draw_cards(extra_cards)
			end
		end
		if context.other_drawn then
			local extra_cards = 0
			for _, other_card in pairs(context.other_drawn) do
				if SMODS.has_enhancement(other_card, "m_wild") then
					extra_cards = extra_cards + 1
				end
			end
			if extra_cards > 0 then
				SMODS.draw_cards(extra_cards)
			end
		end
	end,
})
