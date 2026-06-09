SMODS.Enhancement({
	key = "monus",
	atlas = "mf_enhancers",
	pos = { x = 3, y = 1 },
	config = {
		per_level = 10,
	},
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text =
				G.FUNCS.get_poker_hand_info(G.play.cards)
			local level = to_number(G.GAME.hands[text].level)
			local chip_return = card.ability.per_level * level
			return {
				chips = chip_return,
			}
		end
	end,
	loc_vars = function(self, info_queue, card)
		-- info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_yucky

		return { vars = {
			card and card.ability.per_level or self.config.per_level,
		} }
	end,
})

SMODS.Enhancement({
	key = "cult",
	atlas = "mf_enhancers",
	pos = { x = 4, y = 1 },
	config = {
		per_level = 1,
	},
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text =
				G.FUNCS.get_poker_hand_info(G.play.cards)
			local level = to_number(G.GAME.hands[text].level)
			local chip_return = card.ability.per_level * level
			return {
				mult = chip_return,
			}
		end
	end,
	loc_vars = function(self, info_queue, card)
		-- info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_yucky

		return { vars = {
			card and card.ability.per_level or self.config.per_level,
		} }
	end,
})

SMODS.Enhancement({
	key = "styled",
	atlas = "mf_enhancers",
	pos = { x = 2, y = 1 },
	config = {},
	calculate = function(self, card, context)
		if context.hand_drawn then
			local doit = false
			for _, thing in ipairs(context.hand_drawn) do
				if thing == card then
					doit = true
					goto continue
				end
			end
			::continue::
			if doit then
				G.E_MANAGER:add_event(Event({
					trigger = "before",
					delay = 0.25,
					func = function()
						card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "styledcard" }), true, false)
						card:juice_up()
						play_sound("gold_seal", 1.2, 0.4)
						return true
					end,
				}))
			end
		end
	end,
})

SMODS.Enhancement({
	key = "brass",
	atlas = "mf_enhancers",
	pos = { x = 1, y = 2 },
	config = {
		retriggers = 2,
		chance = 3,
	},
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			return {
				message = localize("k_again_ex"),
				repetitions = card.ability.retriggers,
				card = card,
			}
		end
		if
			context.destroy_card
			and context.destroying_card == card
			and SMODS.pseudorandom_probability(card, "brass_card", 1, card.ability.chance, "brass_card")
		then
			return {
				remove = true,
			}
		end
	end,
	loc_vars = function(self, info_queue, card)
		-- info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_yucky

		local new_numerator, new_denominator =
			SMODS.get_probability_vars(card, 1, card and card.ability.chance or self.config.chance, "brass_card")

		return {
			vars = {
				card and card.ability.retriggers or self.config.retriggers,
				new_numerator,
				new_denominator,
			},
		}
	end,
})

SMODS.Enhancement({
	key = "teal",
	atlas = "mf_enhancers",
	pos = { x = 1, y = 1 },
	config = {
		h_x_chips = 1.5,
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card and card.ability.h_x_chips or self.config.h_x_chips,
		} }
	end,
})

SMODS.Enhancement({
	key = "gemstone",
	atlas = "mf_enhancers",
	pos = { x = 2, y = 2 },
	config = {
		p_dollars = 3,
	},
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	always_scores = true,
	weight = 4, -- make it slightly rarer (??)
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card and card.ability.p_dollars or self.config.p_dollars,
		} }
	end,
	-- draw = function(self, card, layer)
	-- 	local notilt = nil
	-- 	if card.area and card.area.config.type == "deck" then
	-- 		notilt = true
	-- 	end
	-- 	-- card.children.center:draw_shader(
	-- 	--   "negative",
	-- 	--   nil,
	-- 	--   card.ARGS.send_to_shader,
	-- 	--   notilt,
	-- 	--   card.children.center
	-- 	-- )
	-- 	card.children.center:draw_shader("voucher", nil, card.ARGS.send_to_shader, notilt, card.children.center)
	-- end,
})

SMODS.Enhancement({
	key = "marigold",
	atlas = "mf_enhancers",
	pos = { x = 0, y = 2 },
	config = {
		cash = 1,
	},
	calculate = function(self, card, context)
		if context.playing_card_end_of_round and context.cardarea == G.hand then
			local c = 1
			for _, other_card in pairs(G.hand.cards) do
				if other_card ~= card and other_card.config.center_key == card.config.center_key then
					c = c + 1
				end
			end
			if c < 10 then
				for _, other_card in pairs(G.hand.cards) do
					if other_card ~= card and other_card.config.center_key == card.config.center_key then
						G.E_MANAGER:add_event(Event({
							trigger = "before",
							delay = 0.25,
							func = function()
								other_card:juice_up()
								card:juice_up()
								play_sound("chips1", 0.8 + (0.9 + 0.2 * math.random()) * 0.2, 1)
								-- ease_dollars(card.ability.cash)
								return true
							end,
						}))
					end
				end
			end
			-- ease_dollars(card.ability.cash)
			return {
				dollars = card.ability.cash * c,
			}
		end
	end,
	loc_vars = function(self, info_queue, card)
		-- info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_yucky

		return { vars = {
			card and card.ability.cash or self.config.cash,
		} }
	end,
})

SMODS.Enhancement({
	key = "yucky",
	atlas = "mf_enhancers",
	pos = { x = 0, y = 1 },
	config = {
		chance = 2,
	},
	calculate = function(self, card, context)
		if
			context.destroy_card
			and context.destroying_card == card
			and SMODS.pseudorandom_probability(card, "yucky", 1, card.ability.chance, "yucky_card")
		then
			return {
				remove = true,
			}
		end
	end,
	loc_vars = function(self, info_queue, card)
		-- info_queue[#info_queue + 1] = G.P_CENTERS.m_mf_yucky

		local new_numerator, new_denominator =
			SMODS.get_probability_vars(card, 1, card and card.ability.chance or self.config.chance, "yucky_card")

		return { vars = {
			new_numerator,
			new_denominator,
		} }
	end,
})
