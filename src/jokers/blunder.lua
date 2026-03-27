SMODS.Joker({
	key = "blunder",
	name = "Blunder",
	atlas = "mf_jokers",
	config = {
		extra = 3,
	},
	pos = { x = 6, y = 7 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		return {
			vars = { center.ability.extra },
		}
	end,
	calculate = function(self, card, context)
		if context.hand_drawn then
			local any_forced = nil
			for k, v in ipairs(G.hand.cards) do
				if v.ability.forced_selection then
					any_forced = true
				end
			end
			if not any_forced then
				G.hand:unhighlight_all()
				local cb_dx_pool = {}
				for _, card in pairs(G.hand.cards) do
					cb_dx_pool[#cb_dx_pool + 1] = card
				end
				if #cb_dx_pool ~= 0 then
					local forced_card = pseudorandom_element(cb_dx_pool, pseudoseed("blunder"))

					forced_card.ability.forced_selection = true
					G.hand:add_to_highlighted(forced_card)
				end
			end
		end
		if context.selling_self and not context.blueprint then
			for _, v in pairs(G.hand.cards) do
				v.ability.forced_selection = false
			end
			G.hand:unhighlight_all()
		end
		if context.cardarea == G.jokers and context.joker_main then
			return {
				xmult = card.ability.extra,
			}
		end
	end,
})
