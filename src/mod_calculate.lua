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

	if context.selling_card and context.card.ability.mf_exile_until_id then
		local return_to_deck = {}
		for _, other_card in ipairs(G.mf_exile.cards) do
			if other_card.ability.mf_pact_id == context.card.ability.mf_exile_until_id then
				return_to_deck[#return_to_deck + 1] = other_card
				other_card.ability.mf_pact_id = nil
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

		if G.GAME.modifiers and G.GAME.modifiers.mf_final_stake then
			G.GAME.mf_forced_weird_routed = true
			G.FUNCS.use_card({
				config = { ref_table = other_card }
			}, nil, nil)
		end
	end

	if context.open_booster and G.GAME.modifiers.mf_bonus_scrapped then
		if context.booster and context.booster.kind == "Buffoon" then
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.7,
				func = function()
					SMODS.add_card({
						set = "Joker",
						area = G.pack_cards,
						rarity = FLUFF.get_hidden_rarity(),
					})
					return true
				end,
			}))
			G.E_MANAGER:add_event(Event({
				trigger = "after",
				delay = 0.7,
				func = function()
					SMODS.add_card({
						set = "Joker",
						area = G.pack_cards,
						rarity = FLUFF.get_hidden_rarity(),
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

	local suspend_depth = 0
	if context.first_hand_drawn then
		local to_return = {}
		for _, card in ipairs(G.mf_exile.cards) do
			if card.ability.mf_suspended then
				card.ability.mf_suspended.rounds = card.ability.mf_suspended.rounds - 1
				if card.ability.mf_suspended.rounds <= 0 then
					if card.ability.consumeable then
						local function suspend_in_depth (d)
							if d <= 0 then
								G.E_MANAGER:add_event(Event({
									func = function()
										local old_su = G.GAME.STOP_USE
										G.GAME.STOP_USE = 0

										local old_state = G.STATE

										local function check_and_use()
											if Card.can_use_consumeable(card, true) then
												local hand_ids = {}
												G.E_MANAGER:add_event(Event({
													trigger = "after",
													delay = 0.15,
													func = function()
														-- G.E_MANAGER:add_event(Event({
														-- 	func = function()
														-- 		return G.STATE ~= G.STATES.PLAY_TAROT
														-- 	end,
														-- }))
														G.E_MANAGER:add_event(Event({
															func = function()
																card.T.scale = card.T.scale / FLUFF.exile_scale
																return true
															end,
														}))
														G.STATE = G.STATES.SELECTING_HAND
														G.FUNCS.use_card({
															config = { ref_table = card }
														}, nil, nil)
														G.STATE = old_state
														return true
													end,
												}))

												return true
											end
										end

										local has_used = check_and_use()

										if not has_used then
											local max_h = card.ability.max_highlighted or 5
											if max_h > #G.hand.cards then max_h = #G.hand.cards end

											while max_h > 1 and not has_used do
												for i = 1, 25 do
													-- pick that many random cards
													local temp_hand = {}
													for _, v in ipairs(G.hand.cards) do
														temp_hand[#temp_hand + 1] = v
													end
													pseudoshuffle(temp_hand, pseudoseed("mf_use_suspend"))
													
													for i = 1, max_h do
														G.hand.highlighted[#G.hand.highlighted + 1] = temp_hand[i]
														temp_hand[i]:highlight(true)
													end

													has_used = check_and_use()
													if has_used then
														break
													end
													G.hand:unhighlight_all()
												end
												max_h = max_h - 1
											end
										end

										if not has_used then
											SMODS.destroy_cards { card }
										end

										G.GAME.STOP_USE = old_su

										return true
									end,
								}))
							else
								G.E_MANAGER:add_event(Event({
									func = function()
										suspend_in_depth(d-1)
										return true
									end,
								}))
							end
						end
						suspend_in_depth(suspend_depth)
						suspend_depth = suspend_depth + 3
					else
						-- New Joker (i thinkj .)
						to_return[#to_return + 1] = card
					end
				else
					card_eval_status_text(card, "extra", nil, nil, nil, {
						message = card.ability.mf_suspended.rounds .. "",
						card = card,
					})
				end
			end
		end
		for _, card in ipairs(to_return) do
			if card.config.center.set == "Default" or card.config.center.set == "Enhanced" then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						card.area:remove_card(card)
						G.hand:emplace(card)
						card.T.scale = card.T.scale / FLUFF.exile_scale
						play_sound('card1', 0.45, 0.6)
						return true
					end,
				}))
			else
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.15,
					func = function()
						card.area:remove_card(card)
						G.jokers:emplace(card)
						if not card.added_to_deck then
							card:add_to_deck(false)
						end
						card.T.scale = card.T.scale / FLUFF.exile_scale
						play_sound('card1', 0.45, 0.6)
						return true
					end,
				}))
			end
		end
	end

	return SMODS.merge_effects(res)
end

-- this is close enough :p
FLUFF.set_debuff = function(card)
	if next(SMODS.find_card("j_mf_sword_of_steven_and_todd")) then
		return "prevent_debuff"
	end
end