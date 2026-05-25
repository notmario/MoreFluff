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
	end

	if context.starting_shop and G.GAME.round_resets.ante == G.GAME.win_ante and not G.GAME.mf_missed_superboss then
		G.GAME.mf_missed_superboss = true
		local other_card = SMODS.add_voucher_to_shop("v_mf_superboss_ticket")
		other_card.base_cost = 0
		other_card:set_cost()
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
