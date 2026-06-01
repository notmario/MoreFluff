FLUFF.calculate = function(self, context)
	local res = {}

	if context.end_of_round and context.main_eval then
		colour_end_of_round_effects()

		if G.mf_missingjoker_revert then
			for _, joker in pairs(G.mf_missingjoker_revert) do
				joker:set_ability(G.P_CENTERS["j_mf_missingjoker"])
				joker:juice_up()
			end
			G.mf_missingjoker_revert = {}
		end

		if G.GAME.round_resets.ante < (G.GAME.win_ante or 8) then
			G.GAME.mf_missed_superboss = nil
		end

		local return_to_deck = {}
		for _, card in ipairs(G.mf_exile.cards) do
			if card.ability.mf_unexile_eor then
				return_to_deck[#return_to_deck + 1] = card
				card.ability.mf_unexile_eor = nil
			end
			if card.ability.mf_unexile_eoa and G.GAME.blind.boss then
				return_to_deck[#return_to_deck + 1] = card
				card.ability.mf_unexile_eoa = nil
			end
		end
		for i, card in ipairs(return_to_deck) do
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.1,
				func = function()
					card.area:remove_card(card)
					G.deck:emplace(card)
					-- card.T.w = card.T.w / FLUFF.exile_scale
					-- card.T.h = card.T.h / FLUFF.exile_scale
					card.T.scale = card.T.scale / FLUFF.exile_scale
					play_sound('card1', 0.65 - (i / #return_to_deck)*0.2, 0.6)
					return true
				end
			}))
		end
	end

	if context.starting_shop and G.GAME.round_resets.ante == G.GAME.win_ante and not G.GAME.mf_missed_superboss then
		G.GAME.mf_missed_superboss = true
		local other_card = SMODS.add_voucher_to_shop("v_mf_superboss_ticket")
		other_card.base_cost = 0
		other_card:set_cost()

		if G.GAME.modifiers.mf_final_stake then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.,
				func = function()
					G.GAME.mf_forced_weird_route = G.TIMERS.REAL
					G.GAME.mf_superboss_shader_timer = G.TIMERS.REAL
					G.GAME.mf_forced_weird_routed = true
					G.GAME.mf_forced_weird_route_state = 0
					return true
				end,
			}))
		end

		-- if G.GAME.modifiers and G.GAME.modifiers.mf_final_stake then
		-- 	G.FUNCS.use_card({
		-- 		config = { ref_table = other_card }
		-- 	}, nil, nil)
		-- end
	end

	if context.open_booster and G.GAME.modifiers.mf_bonus_scrapped then
		if context.booster and context.booster.kind == "Buffoon" then
			local rarity = pseudorandom_element({"mf_oldfluff", "mf_letter"}, pseudoseed("bonussheet_rarity"))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.7,
				func = function()
					SMODS.add_card({
						set = "Joker",
						area = G.pack_cards,
						rarity = rarity,
					})
					return true
				end,
			}))
			res[#res + 1] = {
				message = localize("k_added_ex"),
				colour = HEX("000000"),
			}
		end
	end

	if not RudeBuster then
		if context.setting_blind then
			for _, joker in pairs(G.jokers.cards) do
				if is_planeswalker(joker) and joker.config.center.default_loyalty_effects then
					joker.ability.extra.uses = 1
				end
			end
		end
	end

	if context.individual and context.cardarea == G.play then
		if context.other_card.mf_royal_decreed then
			res[#res + 1] = {
				xmult = 3,
				card = context.other_card
			}
		end
	end
	if context.destroy_card and context.cardarea == G.play then
		if context.destroy_card.mf_royal_decreed then
			res[#res + 1] = {
				remove = true
			}
		end
	end

	return SMODS.merge_effects(res)
end
